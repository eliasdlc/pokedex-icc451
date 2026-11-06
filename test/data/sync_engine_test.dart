import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/connectivity/connectivity_state.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/pokedex/data/local/pokedex_local_data_source.dart';
import 'package:pokedex/features/pokedex/data/repositories/pokedex_repository_impl.dart';
import 'package:pokedex/features/pokedex/data/sync/sync_engine.dart';
import 'package:pokedex/features/pokedex/domain/entities/catalog_query.dart';
import 'package:pokedex/features/pokedex/domain/entities/pokemon_detail.dart';
import 'package:pokedex/features/pokedex/domain/usecases/toggle_favorite.dart';

import '../support/fakes.dart';

void main() {
  late AppDatabase db;
  late PokedexLocalDataSource local;
  late FakeRemote remote;
  late FakeConnectivity connectivity;
  late SyncEngine engine;
  late PokedexRepositoryImpl repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    local = PokedexLocalDataSource(db);
    remote = FakeRemote(250);
    connectivity = FakeConnectivity(ServiceAvailability.online, remote: remote);
    engine = SyncEngine(
      remote: remote,
      local: local,
      connectivity: connectivity,
      images: FakeImages(),
      sleep: (_) async {},
    );
    repository = PokedexRepositoryImpl(local, languageCode: () => 'es');
  });

  tearDown(() async {
    await engine.dispose();
    await db.close();
  });

  test('PA-01 primera ejecución: descarga el catálogo en lotes y lo deja en la base', () async {
    await engine.refresh();
    expect(await local.pokemonCount(), 250);
    // 250 ids faltantes en lotes de 100 = 3 consultas byIds.
    expect(remote.calls.where((c) => c.startsWith('byIds')).length, 3);
    expect(engine.state.remoteTotal, 250);
    expect(engine.state.lastSyncedAt, isNotNull);
  });

  test(
    'PA-13 sincronizar tres veces no duplica registros ni repite descargas',
    () async {
      await engine.refresh();
      remote.calls.clear();
      await engine.refresh();
      await engine.refresh();
      expect(await local.pokemonCount(), 250);
      final typeRows = await db.select(db.pokemonTypes).get();
      expect(typeRows.length, 250);
      expect(remote.calls.where((c) => c.startsWith('byIds')), isEmpty);
    },
  );

  test('delta: si la API agrega Pokémon, solo se piden los nuevos', () async {
    await engine.refresh();
    remote.total = 260;
    remote.calls.clear();
    await engine.refresh();
    expect(await local.pokemonCount(), 260);
    expect(remote.calls, contains('byIds:10'));
  });

  test('delta: una fila borrada a mano se vuelve a descargar', () async {
    await engine.refresh();
    await db.customStatement('DELETE FROM pokemon WHERE id = 42');
    await engine.refresh();
    expect(await local.pokemonById(42), isNotNull);
  });

  test('PA-16 modificación en caliente: el vigilante detecta y corrige desde la API', () async {
    await engine.refresh();
    await db.customStatement(
      "UPDATE pokemon SET name_es = 'HACKEADO', hp = 999 WHERE id = 25",
    );
    final tampered = await engine.checkIntegrity();
    expect(tampered, 1);
    final row = await local.pokemonById(25);
    expect(row!.nameEs, 'Poke 25');
    expect(row.hp, 50);
    expect(await local.countStale(), 0);
  });

  test('modificación en caliente sin servicio: queda marcada y se corrige al volver', () async {
    await engine.refresh();
    connectivity.availability = ServiceAvailability.offline;
    await db.customStatement('UPDATE pokemon SET hp = 1 WHERE id = 7');
    expect(await engine.checkIntegrity(), 1);
    expect((await local.pokemonById(7))!.hp, 1);
    final detail = await repository.getDetail(7);
    expect(detail!.isTampered, isTrue);

    connectivity.availability = ServiceAvailability.online;
    await engine.refresh();
    expect((await local.pokemonById(7))!.hp, 50);
  });

  test(
    'PA-08 caída de la API con red: conserva los datos locales y avisa',
    () async {
      await engine.refresh();
      remote.down = true;
      await engine.refresh(manual: true);
      expect(await local.pokemonCount(), 250);
      expect(connectivity.current, ServiceAvailability.serviceUnavailable);
    },
  );

  test('sin servicio no intenta sincronizar', () async {
    connectivity.availability = ServiceAvailability.offline;
    await engine.refresh();
    expect(remote.calls, isEmpty);
  });

  test('dos refresh simultáneos comparten el mismo trabajo', () async {
    await Future.wait([engine.refresh(), engine.refresh(), engine.refresh()]);
    expect(remote.calls.where((c) => c == 'ids').length, 1);
  });

  test('revalidación TTL: un cambio remoto real se aplica, uno igual no se reescribe', () async {
    await engine.refresh();
    final old = DateTime.now().subtract(const Duration(days: 30));
    await (db.update(db.syncMeta)..where((m) => m.resource.like('pokemon:%')))
        .write(SyncMetaCompanion(lastSyncedAt: Value(old)));
    remote.overrides[1] = fakeSummary(1, nameEn: 'Renamed');
    await engine.refresh();
    expect((await local.pokemonById(1))!.nameEn, 'Renamed');
    expect((await local.pokemonById(2))!.nameEn, 'Poke 2');
  });

  test('búsqueda, filtros y orden funcionan sobre la base local', () async {
    await engine.refresh();
    final byName = await repository
        .watchCatalog(const CatalogQuery(search: 'poke 12'), limit: 50)
        .first;
    expect(byName.map((p) => p.id), containsAll([12, 120, 121]));
    final byNumber = await repository
        .watchCatalog(const CatalogQuery(search: '#25'), limit: 50)
        .first;
    expect(byNumber.single.id, 25);
    final gen = await repository
        .watchCatalog(const CatalogQuery(generationId: 2), limit: 500)
        .first;
    expect(gen.every((p) => p.generationId == 2), isTrue);
    final sorted = await repository
        .watchCatalog(
          const CatalogQuery(sort: CatalogSort.number, ascending: false),
          limit: 3,
        )
        .first;
    expect(sorted.map((p) => p.id), [250, 249, 248]);
  });

  test(
    'favoritos: se guardan en menos de 150 ms y el catálogo reacciona',
    () async {
      await engine.refresh();
      final result = await ToggleFavorite(repository)(4);
      expect(result.isFavorite, isTrue);
      expect(result.withinBudget, isTrue, reason: 'tardó ${result.elapsed}');
      final favorites = await repository.watchFavorites().first;
      expect(favorites.single.id, 4);
      final catalog = await repository
          .watchCatalog(const CatalogQuery(search: '#4'), limit: 5)
          .first;
      expect(catalog.single.isFavorite, isTrue);
    },
  );

  test('detalle bajo demanda con debilidades calculadas', () async {
    await engine.refresh();
    await engine.ensureDetail(1);
    final detail = await repository.getDetail(1);
    expect(detail!.isComplete, isTrue);
    expect(detail.abilities.single.ability.nameEs, 'Espesura');
    expect(detail.summary.artworkFile, '/fake/artwork/1.png');
    // En el falso, el tipo 11 hace x2 al 10; el 1 es tipo 12, así que nada.
    expect(detail.matchups.weaknesses, isEmpty);
  });

  test('OF-20 al abrir la ficha se revisa ese Pokémon y se corrige sin esperar al vigilante', () async {
    await engine.refresh();
    await db.customStatement(
      "UPDATE pokemon SET name_es = 'ALTERADO' WHERE id = 30",
    );
    await engine.ensureDetail(30);
    expect((await local.pokemonById(30))!.nameEs, 'Poke 30');
    expect(await local.countStale(), 0);
  });

  test('RF-DET-05 movimientos por versión, método y orden', () async {
    await engine.refresh();
    await engine.ensureDetail(1);
    final detail = (await repository.getDetail(1))!;
    // Las dos versiones del falso, de la más vieja a la más nueva.
    expect(detail.versionGroups.map((v) => v.id), [1, 25]);
    expect(detail.defaultVersionGroupId, 25);
    final levelUp = detail.movesFor(
      versionGroupId: 25,
      method: MoveLearnMethod.levelUp,
    );
    expect(levelUp.single.slug, 'tackle');
    expect(levelUp.single.level, 5);
    final machine = detail.movesFor(
      versionGroupId: 25,
      method: MoveLearnMethod.machine,
    );
    expect(machine.single.slug, 'thunderbolt');
    expect(
      detail.movesFor(versionGroupId: 1, method: MoveLearnMethod.machine),
      isEmpty,
    );
  });

  test(
    'RF-DET-08 las formas se guardan con su especie y no entran al catálogo',
    () async {
      remote.forms[26] = [
        fakeSummary(10100, speciesId: 26, formName: 'Forma de Alola'),
      ];
      await engine.refresh();
      await engine.ensureDetail(26);
      // El catálogo sigue con 250: la forma solo se ve desde la ficha.
      expect(await local.pokemonCount(), 250);
      final catalog = await repository
          .watchCatalog(const CatalogQuery(), limit: 500)
          .first;
      expect(catalog.any((p) => p.id == 10100), isFalse);
      final detail = (await repository.getDetail(26))!;
      expect(detail.varieties.map((v) => v.id), [26, 10100]);
      // Abrir la forma trae su propio detalle.
      await engine.ensureDetail(10100);
      final form = (await repository.getDetail(10100))!;
      expect(form.speciesId, 26);
      expect(form.currentVariety!.formName('es'), 'Forma de Alola');
      expect(form.isComplete, isTrue);
    },
  );

  test('PA-08 con red y sin API, "Actualizar" reintenta con backoff y no toca los datos', () async {
    await engine.refresh();
    remote.down = true;
    connectivity.availability = ServiceAvailability.serviceUnavailable;
    remote.calls.clear();
    // Automático: sin servicio no intenta.
    await engine.refresh();
    expect(remote.calls, isEmpty);
    // Manual: 4 intentos (3 esperas de backoff) y se rinde.
    await engine.refresh(manual: true);
    expect(remote.calls.where((c) => c == 'ids').length, 4);
    expect(await local.pokemonCount(), 250);
    expect(connectivity.current, ServiceAvailability.serviceUnavailable);
  });
}
