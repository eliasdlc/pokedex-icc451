import 'dart:async';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/core/connectivity/connectivity_state.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/pokedex/domain/entities/catalog_query.dart';
import 'package:pokedex/features/pokedex/domain/entities/poke_type.dart';
import 'package:pokedex/features/pokedex/domain/entities/pokemon_detail.dart';
import 'package:pokedex/features/pokedex/domain/entities/pokemon_summary.dart';
import 'package:pokedex/features/pokedex/domain/repositories/pokedex_repository.dart';

const fakeTypes = [
  PokeType(id: 1, slug: 'water', nameEs: 'Agua', nameEn: 'Water'),
  PokeType(id: 2, slug: 'electric', nameEs: 'Eléctrico', nameEn: 'Electric'),
  PokeType(id: 3, slug: 'fire', nameEs: 'Fuego', nameEn: 'Fire'),
  PokeType(id: 4, slug: 'grass', nameEs: 'Planta', nameEn: 'Grass'),
  PokeType(id: 5, slug: 'poison', nameEs: 'Veneno', nameEn: 'Poison'),
  PokeType(id: 6, slug: 'ghost', nameEs: 'Fantasma', nameEn: 'Ghost'),
];

const fakeGenerations = [
  Generation(id: 1, slug: 'generation-i', region: 'kanto'),
  Generation(id: 2, slug: 'generation-ii', region: 'johto'),
  Generation(id: 3, slug: 'generation-iii', region: 'hoenn'),
];

PokemonSummary fakePokemon(
  int id,
  String name,
  List<PokeType> types, {
  int generationId = 1,
  bool isFavorite = false,
  String? spriteFile,
}) => PokemonSummary(
  id: id,
  slug: name.toLowerCase(),
  nameEs: name,
  nameEn: name,
  generationId: generationId,
  types: types,
  stats: const BaseStats(
    hp: 45,
    attack: 49,
    defense: 49,
    specialAttack: 65,
    specialDefense: 65,
    speed: 45,
  ),
  spriteUrl: null,
  artworkUrl: null,
  spriteFile: spriteFile,
  artworkFile: null,
  isFavorite: isFavorite,
);

class FakePokedexRepository implements PokedexRepository {
  FakePokedexRepository(List<PokemonSummary> pokemon) : _all = [...pokemon];

  List<PokemonSummary> _all;
  CatalogQuery saved = const CatalogQuery();
  final _changes = StreamController<void>.broadcast();

  final queries = <CatalogQuery>[];

  List<PokemonSummary> _filter(CatalogQuery q) {
    final text = q.search.toLowerCase();
    final list = [
      for (final p in _all)
        if ((text.isEmpty || p.nameEs.toLowerCase().contains(text)) &&
            (q.typeIds.isEmpty ||
                p.types.any((t) => q.typeIds.contains(t.id))) &&
            (q.generationId == null || p.generationId == q.generationId) &&
            (!q.favoritesOnly || p.isFavorite))
          p,
    ];
    list.sort(
      (a, b) => switch (q.sort) {
        CatalogSort.name => a.nameEs.compareTo(b.nameEs),
        _ => a.id.compareTo(b.id),
      },
    );
    return q.ascending ? list : list.reversed.toList();
  }

  Stream<T> _watch<T>(T Function() read) async* {
    yield read();
    await for (final _ in _changes.stream) {
      yield read();
    }
  }

  @override
  Stream<List<PokemonSummary>> watchCatalog(
    CatalogQuery query, {
    required int limit,
  }) {
    queries.add(query);
    return _watch(() => _filter(query).take(limit).toList());
  }

  @override
  Stream<int> watchCatalogCount(CatalogQuery query) =>
      _watch(() => _filter(query).length);

  @override
  Stream<List<PokemonSummary>> watchFavorites() => _watch(
    () => [
      for (final p in _all)
        if (p.isFavorite) p,
    ],
  );

  @override
  Stream<List<PokeType>> watchTypes() => Stream.value(fakeTypes);

  @override
  Stream<List<Generation>> watchGenerations() => Stream.value(fakeGenerations);

  @override
  Stream<List<Ability>> watchAbilities() => Stream.value(const []);

  @override
  Future<bool> toggleFavorite(int pokemonId) async {
    final now = !_all.firstWhere((p) => p.id == pokemonId).isFavorite;
    _all = [
      for (final p in _all) p.id == pokemonId ? _withFavorite(p, now) : p,
    ];
    _changes.add(null);
    return now;
  }

  @override
  Future<CatalogQuery> loadSavedQuery() async => saved;

  @override
  Future<void> saveQuery(CatalogQuery query) async => saved = query;

  @override
  Stream<PokemonDetail?> watchDetail(int id) => const Stream.empty();

  @override
  Future<List<PokemonSummary>> playablePokemon({bool requireDetail = false}) =>
      throw UnimplementedError();

  @override
  Future<PokemonDetail?> getDetail(int id) => throw UnimplementedError();

  @override
  Future<Map<(int, int), int>> typeEfficacy() => throw UnimplementedError();
}

PokemonSummary _withFavorite(PokemonSummary p, bool isFavorite) =>
    PokemonSummary(
      id: p.id,
      slug: p.slug,
      nameEs: p.nameEs,
      nameEn: p.nameEn,
      generationId: p.generationId,
      types: p.types,
      stats: p.stats,
      spriteUrl: p.spriteUrl,
      artworkUrl: p.artworkUrl,
      spriteFile: p.spriteFile,
      artworkFile: p.artworkFile,
      isFavorite: isFavorite,
    );

class FakeSyncService implements SyncService {
  int refreshes = 0;

  @override
  Stream<SyncState> watch() => const Stream.empty();

  @override
  Future<void> start() async {}

  @override
  Future<void> refresh({bool manual = false}) async => refreshes++;

  @override
  Future<void> ensureDetail(int pokemonId) async {}

  @override
  Future<int> checkIntegrity() async => 0;

  @override
  void restartIntegrityTimer() {}
}

/// Las pestañas Jugar y Perfil leen una base en memoria.
List<Override> fakePokedexOverrides(
  FakePokedexRepository repository, {
  SyncState sync = const SyncState(localCount: 12, remoteTotal: 12),
  ServiceAvailability availability = ServiceAvailability.online,
  FakeSyncService? syncService,
}) {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  return [
    databaseProvider.overrideWithValue(AppDatabase(NativeDatabase.memory())),
    pokedexRepositoryProvider.overrideWithValue(repository),
    syncServiceProvider.overrideWithValue(syncService ?? FakeSyncService()),
    syncStateProvider.overrideWith((ref) => Stream.value(sync)),
    availabilityProvider.overrideWith((ref) => Stream.value(availability)),
  ];
}
