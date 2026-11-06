import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/connectivity/connectivity_state.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/retry.dart';
import '../../domain/repositories/pokedex_repository.dart';
import '../images/image_store.dart';
import '../local/pokedex_local_data_source.dart';
import '../mappers/record_hashes.dart';
import '../remote/pokeapi_remote_data_source.dart';

/// Sincroniza remoto a local en segundo plano: pide solo lo que falta, lo
/// vencido o lo alterado, sin duplicar y con un trabajo por recurso.
class SyncEngine implements SyncService {
  SyncEngine({
    required PokeApiRemoteDataSource remote,
    required PokedexLocalDataSource local,
    required ConnectivityService connectivity,
    required ImageStore images,
    Future<void> Function(Duration)? sleep,
  }) : _remote = remote,
       _local = local,
       _connectivity = connectivity,
       _images = images,
       _sleep = sleep;

  final PokeApiRemoteDataSource _remote;
  final PokedexLocalDataSource _local;
  final ConnectivityService _connectivity;
  final ImageStore _images;
  final Future<void> Function(Duration)? _sleep;

  final _controller = StreamController<SyncState>.broadcast();
  SyncState _state = const SyncState();
  final _inFlight = <String, Future<void>>{};
  StreamSubscription<ServiceAvailability>? _availabilitySub;
  StreamSubscription<int>? _countSub;
  Timer? _integrityTimer;
  bool _started = false;
  bool _disposed = false;

  SyncState get state => _state;

  @override
  Stream<SyncState> watch() async* {
    yield _state;
    yield* _controller.stream;
  }

  void _emit(SyncState next) {
    _state = next;
    if (!_controller.isClosed) _controller.add(next);
  }

  /// Un trabajo por llave: la segunda llamada recibe el mismo Future. El
  /// callback va en bloque: con `=>`, whenComplete se esperaría a sí mismo.
  Future<void> _once(String key, Future<void> Function() job) =>
      _inFlight[key] ??= job().whenComplete(() {
        _inFlight.remove(key);
      });

  Future<T> _call<T>(Future<T> Function() action) => retryWithBackoff(
    action,
    sleep: _sleep ?? (d) => Future<void>.delayed(d),
    onRetry: (attempt, failure) =>
        debugPrint('sync: reintento $attempt tras ${failure.message}'),
  );

  @override
  Future<void> start() async {
    if (_started) return;
    _started = true;
    final lastSync = await _local.lastCatalogSync();
    _emit(
      _state.copyWith(
        lastSyncedAt: lastSync,
        localCount: await _local.pokemonCount(),
      ),
    );
    _countSub = _local.watchPokemonCount().listen(
      (count) => _emit(_state.copyWith(localCount: count)),
    );

    // Al volver el servicio se reanuda y se revisa la integridad.
    _availabilitySub = _connectivity.watch().listen((availability) {
      if (availability != ServiceAvailability.online) return;
      unawaited(refresh());
      unawaited(checkIntegrity());
    });

    // El vigilante de la modificación en caliente.
    _integrityTimer = Timer.periodic(
      AppConfig.integrityInterval,
      (_) => unawaited(checkIntegrity()),
    );
    unawaited(checkIntegrity());
  }

  @override
  Future<void> refresh({bool manual = false}) => _once('refresh', () async {
    var availability = _connectivity.current;
    if (manual || availability != ServiceAvailability.online) {
      availability = await _connectivity.recheck();
    }
    // Sin red no se intenta. Sin API, solo un pedido manual reintenta.
    if (availability == ServiceAvailability.offline) return;
    if (availability != ServiceAvailability.online && !manual) return;

    _emit(_state.copyWith(activity: SyncActivity.syncing, clearError: true));
    try {
      await _syncStaticData();
      await _syncCatalogDelta();
      await _revalidate();
      await _local.touchCatalog();
      _emit(_state.copyWith(lastSyncedAt: DateTime.now()));
      unawaited(_downloadMissingSprites());
    } on Failure catch (failure) {
      debugPrint('sync: se rinde tras los reintentos: ${failure.message}');
      if (failure.isTransient) _connectivity.reportServiceFailure();
      await _local.recordFailure(catalogResource, failure.message);
      _emit(_state.copyWith(lastError: failure.message));
    } finally {
      _emit(
        _state.copyWith(
          activity: SyncActivity.idle,
          pendingRepairs: await _local.countStale(),
        ),
      );
    }
  });

  Future<void> _syncStaticData() async {
    final meta = await _local.meta(staticResource);
    final fresh =
        meta?.lastSyncedAt != null &&
        DateTime.now().difference(meta!.lastSyncedAt!) < AppConfig.freshnessTtl;
    if (fresh) return;
    await _local.upsertStatic(await _call(_remote.fetchStaticData));
  }

  /// Delta del catálogo: ids remotos menos ids locales = lo que falta.
  Future<void> _syncCatalogDelta() async {
    final remoteIds = await _call(_remote.fetchCatalogIds);
    _emit(_state.copyWith(remoteTotal: remoteIds.length));
    final localIds = await _local.localIds();
    final missing = remoteIds.where((id) => !localIds.contains(id)).toList();
    for (final batch in missing.slices(AppConfig.catalogBatchSize)) {
      final items = await _call(() => _remote.fetchByIds(batch));
      await _local.upsertSummaries(items);
    }
  }

  /// Revalida lo vencido (TTL) o alterado (stale): pide esos ids, compara
  /// huellas y solo reescribe lo que cambió.
  Future<void> _revalidate() async {
    final attempted = <int>{};
    while (true) {
      final resources = await _local.resourcesNeedingRefresh('pokemon:');
      final ids = [for (final r in resources) int.parse(r.split(':').last)]
          .where(attempted.add)
          .toList();
      // Cada id se intenta una vez por pasada: un id que la API no devuelve
      // queda en "error" para la próxima, sin ciclar.
      if (ids.isEmpty) break;
      final items = await _call(() => _remote.fetchByIds(ids));
      await _local.upsertSummaries(items);
      final returned = {for (final i in items) i.id};
      for (final id in ids.where((id) => !returned.contains(id))) {
        await _local.recordFailure(
          summaryResource(id),
          'No llegó en la revalidación',
        );
      }
    }
    // Los detalles alterados o vencidos se vuelven a pedir uno por uno.
    for (final resource in await _local.resourcesNeedingRefresh(
      'detail:',
      limit: 30,
    )) {
      await _fetchDetail(int.parse(resource.split(':').last));
    }
  }

  @override
  Future<void> ensureDetail(
    int pokemonId,
  ) => _once('detail:$pokemonId', () async {
    // Si este Pokémon fue alterado, queda stale y se vuelve a pedir a la API.
    final tampered = await _local.findTamperedResources(onlyId: pokemonId);
    if (tampered.isNotEmpty) {
      debugPrint('integridad: $tampered alterados, al abrir la ficha');
      await _local.markStale(tampered);
    }
    final summaryMeta = await _local.meta(summaryResource(pokemonId));
    if (summaryMeta?.status == 'stale' &&
        _connectivity.current == ServiceAvailability.online) {
      try {
        await _local.upsertSummaries(
          await _call(() => _remote.fetchByIds([pokemonId])),
        );
      } on Failure catch (failure) {
        if (failure.isTransient) _connectivity.reportServiceFailure();
      }
    }
    final row = await _local.pokemonById(pokemonId);
    final meta = await _local.meta(detailResource(pokemonId));
    final fresh =
        row != null &&
        row.hasDetail &&
        meta?.status == 'ok' &&
        meta?.lastSyncedAt != null &&
        DateTime.now().difference(meta!.lastSyncedAt!) < AppConfig.freshnessTtl;
    final needsArtwork =
        row != null && row.artworkFile == null && row.artworkUrl != null;
    if (fresh && !needsArtwork) return;
    if (_connectivity.current != ServiceAvailability.online) return;
    try {
      if (!fresh) await _fetchDetail(pokemonId);
      await _saveArtwork(pokemonId);
    } on Failure catch (failure) {
      if (failure.isTransient) _connectivity.reportServiceFailure();
      await _local.recordFailure(detailResource(pokemonId), failure.message);
    }
  });

  Future<void> _fetchDetail(int pokemonId) async {
    final dto = await _call(() => _remote.fetchDetail(pokemonId));
    await _local.upsertDetail(dto);
  }

  Future<void> _saveArtwork(int pokemonId) async {
    final row = await _local.pokemonById(pokemonId);
    if (row == null) return;
    final artwork = row.artworkUrl == null || row.artworkFile != null
        ? null
        : await _images.save(
            row.artworkUrl!,
            kind: 'artwork',
            pokemonId: pokemonId,
          );
    final sprite = row.spriteUrl == null || row.spriteFile != null
        ? null
        : await _images.save(
            row.spriteUrl!,
            kind: 'sprite',
            pokemonId: pokemonId,
          );
    await _local.setImageFiles({pokemonId: (sprite: sprite, artwork: artwork)});
  }

  /// Sprites del catálogo, en lotes y con concurrencia limitada. Se detiene en
  /// cuanto se pierde el servicio y continúa en la próxima reconexión.
  Future<void> _downloadMissingSprites() => _once('sprites', () async {
    while (!_disposed && _connectivity.current == ServiceAvailability.online) {
      final pending = await _local.pokemonMissingSprites();
      if (pending.isEmpty) return;
      final saved = <int, ({String? sprite, String? artwork})>{};
      for (final group in pending.slices(AppConfig.imageDownloadConcurrency)) {
        final paths = await Future.wait([
          for (final row in group)
            _images.save(row.spriteUrl!, kind: 'sprite', pokemonId: row.id),
        ]);
        for (final (i, path) in paths.indexed) {
          if (path != null) saved[group[i].id] = (sprite: path, artwork: null);
        }
      }
      await _local.setImageFiles(saved);
      if (saved.isEmpty) return; // Nada se pudo bajar: no insistir ahora.
    }
  });

  /// Marca como alterado lo editado a mano y, con servicio, lo corrige desde
  /// la API.
  @override
  Future<int> checkIntegrity() async {
    final tampered = await _local.findTamperedResources();
    if (tampered.isNotEmpty) {
      debugPrint(
        'integridad: ${tampered.length} registros alterados: $tampered',
      );
      await _local.markStale(tampered);
    }
    final pending = await _local.countStale();
    _emit(_state.copyWith(pendingRepairs: pending));
    if (pending > 0 && _connectivity.current == ServiceAvailability.online) {
      await refresh();
    }
    return tampered.length;
  }

  Future<void> dispose() async {
    _disposed = true;
    _integrityTimer?.cancel();
    // Espera a que terminen los trabajos en curso antes de soltar la base.
    await Future.wait([..._inFlight.values]);
    await _availabilitySub?.cancel();
    await _countSub?.cancel();
    await _controller.close();
  }
}
