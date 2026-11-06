import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/catalog_query.dart';
import '../../domain/entities/poke_type.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../../domain/entities/pokemon_summary.dart';
import '../../domain/repositories/pokedex_repository.dart';
import '../../domain/usecases/compute_matchups.dart';
import '../local/pokedex_local_data_source.dart';
import '../mappers/entity_mappers.dart';
import '../mappers/record_hashes.dart';

class PokedexRepositoryImpl implements PokedexRepository {
  PokedexRepositoryImpl(this._local, {required String Function() languageCode})
    : _languageCode = languageCode;

  final PokedexLocalDataSource _local;
  final String Function() _languageCode;
  AppDatabase get _db => _local.db;

  static const _queryKey = 'catalog_query';

  Future<Map<int, PokeType>> _typesById() async => {
    for (final row in await _db.select(_db.pokeTypes).get())
      row.id: typeFromRow(row),
  };

  @override
  Stream<List<PokemonSummary>> watchCatalog(
    CatalogQuery query, {
    required int limit,
  }) => _local
      .watchCatalog(query, limit: limit, languageCode: _languageCode())
      .asyncMap((rows) async {
        final types = await _typesById();
        return [for (final row in rows) summaryFromRow(row, types)];
      });

  @override
  Stream<int> watchCatalogCount(CatalogQuery query) =>
      _local.watchCatalogCount(query);

  @override
  Stream<List<PokemonSummary>> watchFavorites() =>
      _local.watchFavorites().asyncMap((rows) async {
        final types = await _typesById();
        return [for (final row in rows) summaryFromRow(row, types)];
      });

  @override
  Stream<List<PokeType>> watchTypes() =>
      (_db.select(_db.pokeTypes)..orderBy([(t) => OrderingTerm.asc(t.id)]))
          .watch()
          .map((rows) => rows.map(typeFromRow).toList());

  @override
  Stream<List<Generation>> watchGenerations() =>
      (_db.select(
        _db.generations,
      )..orderBy([(g) => OrderingTerm.asc(g.id)])).watch().map(
        (rows) => [
          for (final g in rows)
            Generation(id: g.id, slug: g.name, region: g.regionName),
        ],
      );

  @override
  Stream<List<Ability>> watchAbilities() =>
      (_db.select(
        _db.abilities,
      )..orderBy([(a) => OrderingTerm.asc(a.nameEs)])).watch().map(
        (rows) => [
          for (final a in rows)
            Ability(id: a.id, slug: a.name, nameEs: a.nameEs, nameEn: a.nameEn),
        ],
      );

  @override
  Stream<PokemonDetail?> watchDetail(int id) => _db
      .customSelect(
        'SELECT 1',
        readsFrom: {
          _db.pokemon,
          _db.pokemonTypes,
          _db.favorites,
          _db.pokemonAbilities,
          _db.abilities,
          _db.pokemonMoves,
          _db.moves,
          _db.versionGroups,
          _db.evolutions,
          _db.syncMeta,
          _db.pokeTypes,
          _db.typeEfficacy,
        },
      )
      .watch()
      .asyncMap((_) => getDetail(id));

  @override
  Future<PokemonDetail?> getDetail(int id) async {
    final row = await _local.pokemonById(id);
    if (row == null) return null;
    final types = await _typesById();
    final typeRows =
        await (_db.select(_db.pokemonTypes)
              ..where((t) => t.pokemonId.equals(id))
              ..orderBy([(t) => OrderingTerm.asc(t.slot)]))
            .get();
    final isFavorite =
        await (_db.select(
          _db.favorites,
        )..where((f) => f.pokemonId.equals(id))).getSingleOrNull() !=
        null;
    final summary = summaryFromRow((
      pokemon: row,
      typeIds: [for (final t in typeRows) t.typeId],
      isFavorite: isFavorite,
    ), types);

    final abilityRows = await (_db.select(_db.pokemonAbilities).join([
      innerJoin(
        _db.abilities,
        _db.abilities.id.equalsExp(_db.pokemonAbilities.abilityId),
      ),
    ])..where(_db.pokemonAbilities.pokemonId.equals(id))).get();
    final moveRows = await (_db.select(_db.pokemonMoves).join([
      innerJoin(_db.moves, _db.moves.id.equalsExp(_db.pokemonMoves.moveId)),
    ])..where(_db.pokemonMoves.pokemonId.equals(id))).get();
    final learnedIn = {
      for (final r in moveRows) r.readTable(_db.pokemonMoves).versionGroupId,
    };
    final versionRows =
        await (_db.select(_db.versionGroups)
              ..where((v) => v.id.isIn(learnedIn))
              ..orderBy([(v) => OrderingTerm.asc(v.sortOrder)]))
            .get();
    final speciesId = row.speciesId ?? row.id;
    final varietyRows = await _local.varietiesOf(speciesId);
    final evolutionRows = row.evolutionChainId == null
        ? <EvolutionRow>[]
        : await (_db.select(
            _db.evolutions,
          )..where((e) => e.chainId.equals(row.evolutionChainId!))).get();
    final efficacy = await typeEfficacy();
    final summaryMeta = await _local.meta(summaryResource(id));
    final detailMeta = await _local.meta(detailResource(id));

    return PokemonDetail(
      summary: summary,
      height: row.height,
      weight: row.weight,
      flavorEs: row.flavorEs,
      flavorEn: row.flavorEn,
      eggGroups: row.eggGroups == null || row.eggGroups!.isEmpty
          ? const []
          : row.eggGroups!.split(','),
      captureRate: row.captureRate,
      isLegendary: row.isLegendary,
      isMythical: row.isMythical,
      shinyArtworkUrl: row.shinyArtworkUrl,
      abilities: [
        for (final r in abilityRows)
          () {
            final a = r.readTable(_db.abilities);
            return PokemonAbility(
              ability: Ability(
                id: a.id,
                slug: a.name,
                nameEs: a.nameEs,
                nameEn: a.nameEn,
              ),
              isHidden: r.readTable(_db.pokemonAbilities).isHidden,
              effectEs: a.effectEs,
              effectEn: a.effectEn,
            );
          }(),
      ],
      moves: [
        for (final r in moveRows)
          ?() {
            final m = r.readTable(_db.moves);
            final learned = r.readTable(_db.pokemonMoves);
            final method = MoveLearnMethod.fromId(learned.methodId);
            if (method == null) return null;
            return PokemonMove(
              id: m.id,
              slug: m.name,
              versionGroupId: learned.versionGroupId,
              method: method,
              level: learned.level,
              power: m.power,
              accuracy: m.accuracy,
              pp: m.pp,
              typeId: m.typeId,
              damageClass: damageClassFromId(m.damageClassId),
            );
          }(),
      ],
      versionGroups: [
        for (final v in versionRows)
          VersionGroup(
            id: v.id,
            slug: v.name,
            generationId: v.generationId,
            order: v.sortOrder,
          ),
      ],
      varieties: [
        for (final v in varietyRows)
          PokemonVariety(
            id: v.id,
            isDefault: v.isDefault,
            formNameEs: v.formNameEs,
            formNameEn: v.formNameEn,
          ),
      ],
      speciesId: speciesId,
      evolution: buildEvolutionTree(evolutionRows),
      matchups: computeMatchups(
        defenderTypes: summary.types,
        allTypes: types.values.toList(),
        efficacy: efficacy,
      ),
      lastSyncedAt: detailMeta?.lastSyncedAt ?? summaryMeta?.lastSyncedAt,
      isTampered:
          summaryMeta?.status == 'stale' || detailMeta?.status == 'stale',
    );
  }

  @override
  Future<Map<(int, int), int>> typeEfficacy() async => {
    for (final e in await _db.select(_db.typeEfficacy).get())
      (e.attackTypeId, e.targetTypeId): e.factor,
  };

  @override
  Future<bool> toggleFavorite(int pokemonId) =>
      _local.toggleFavorite(pokemonId);

  @override
  Future<List<PokemonSummary>> playablePokemon({
    bool requireDetail = false,
  }) async {
    final types = await _typesById();
    final rows = await _local.playable(requireDetail: requireDetail);
    return [for (final row in rows) summaryFromRow(row, types)];
  }

  @override
  Future<CatalogQuery> loadSavedQuery() async {
    final raw = await _local.readSetting(_queryKey);
    if (raw == null) return const CatalogQuery();
    try {
      return CatalogQuery.fromJson(
        (jsonDecode(raw) as Map).cast<String, Object?>(),
      );
    } on FormatException {
      return const CatalogQuery();
    }
  }

  @override
  Future<void> saveQuery(CatalogQuery query) =>
      _local.writeSetting(_queryKey, jsonEncode(query.toJson()));
}
