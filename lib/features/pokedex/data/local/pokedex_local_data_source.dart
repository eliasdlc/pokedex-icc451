import 'dart:convert';
import 'dart:isolate';

import 'package:drift/drift.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/catalog_query.dart';
import '../mappers/record_hashes.dart';
import '../remote/dtos.dart';

/// Fila del catálogo con sus tipos y si es favorito, en una sola consulta.
typedef CatalogRow = ({PokemonRow pokemon, List<int> typeIds, bool isFavorite});

/// Único acceso a la base. Cada lote va en una transacción: si la app muere a
/// mitad, SQLite lo deshace entero.
class PokedexLocalDataSource {
  PokedexLocalDataSource(this.db, {DateTime Function()? clock})
    : _now = clock ?? DateTime.now;

  final AppDatabase db;
  final DateTime Function() _now;

  /// Upsert por id: repetir la sincronización nunca duplica. Si el hash no
  /// cambió y la fila no fue alterada, solo renueva la vigencia.
  Future<({int written, int unchanged})> upsertSummaries(
    List<PokemonSummaryDto> items,
  ) => db.transaction(() => _writeSummaries(items, _now()));

  /// Cuerpo de [upsertSummaries] sin transacción propia: el detalle lo
  /// reutiliza dentro de la suya para guardar las formas de la especie.
  Future<({int written, int unchanged})> _writeSummaries(
    List<PokemonSummaryDto> items,
    DateTime now,
  ) async {
    var written = 0;
    var unchanged = 0;
    {
      final metas =
          await (db.select(db.syncMeta)..where(
                (m) => m.resource.isIn(items.map((e) => summaryResource(e.id))),
              ))
              .get();
      final metaByResource = {for (final m in metas) m.resource: m};
      final existing = {
        for (final row in await (db.select(
          db.pokemon,
        )..where((p) => p.id.isIn(items.map((e) => e.id)))).get())
          row.id,
      };
      for (final dto in items) {
        final types = [...dto.types]..sort((a, b) => a.slot.compareTo(b.slot));
        final stats = [
          for (final name in PokemonSummaryDto.statNames) dto.stats[name]!,
        ];
        final hash = summaryHash(
          id: dto.id,
          slug: dto.slug,
          nameEs: dto.nameEs,
          nameEn: dto.nameEn,
          generationId: dto.generationId,
          stats: stats,
          typeIdsBySlot: [for (final t in types) t.typeId],
        );
        final meta = metaByResource[summaryResource(dto.id)];
        // "Sin cambios" exige las tres cosas: la fila existe, el hash remoto es
        // el guardado y nadie la marcó como alterada.
        if (existing.contains(dto.id) &&
            meta != null &&
            meta.contentHash == hash &&
            meta.status == 'ok') {
          unchanged++;
          await _touchMeta(summaryResource(dto.id), hash, now);
          continue;
        }
        await db
            .into(db.pokemon)
            .insert(
              PokemonCompanion.insert(
                id: Value(dto.id),
                name: dto.slug,
                nameEs: dto.nameEs,
                nameEn: dto.nameEn,
                nameJa: Value(dto.nameJa),
                speciesId: Value(dto.speciesId),
                isDefault: Value(dto.isDefault),
                formNameEs: Value(dto.formNameEs),
                formNameEn: Value(dto.formNameEn),
                generationId: dto.generationId,
                evolutionChainId: Value(dto.evolutionChainId),
                hp: stats[0],
                attack: stats[1],
                defense: stats[2],
                specialAttack: stats[3],
                specialDefense: stats[4],
                speed: stats[5],
                statTotal: stats.fold(0, (a, b) => a + b),
                spriteUrl: Value(dto.spriteUrl),
                artworkUrl: Value(dto.artworkUrl),
              ),
              // Solo actualiza columnas de resumen: el detalle y las rutas de
              // imagen ya guardadas se conservan.
              onConflict: DoUpdate(
                (_) => PokemonCompanion(
                  name: Value(dto.slug),
                  nameEs: Value(dto.nameEs),
                  nameEn: Value(dto.nameEn),
                  nameJa: Value(dto.nameJa),
                  speciesId: Value(dto.speciesId),
                  isDefault: Value(dto.isDefault),
                  formNameEs: Value(dto.formNameEs),
                  formNameEn: Value(dto.formNameEn),
                  generationId: Value(dto.generationId),
                  evolutionChainId: Value(dto.evolutionChainId),
                  hp: Value(stats[0]),
                  attack: Value(stats[1]),
                  defense: Value(stats[2]),
                  specialAttack: Value(stats[3]),
                  specialDefense: Value(stats[4]),
                  speed: Value(stats[5]),
                  statTotal: Value(stats.fold(0, (a, b) => a + b)),
                  spriteUrl: Value(dto.spriteUrl),
                  artworkUrl: Value(dto.artworkUrl),
                ),
              ),
            );
        await (db.delete(
          db.pokemonTypes,
        )..where((t) => t.pokemonId.equals(dto.id))).go();
        await db.batch((b) {
          b.insertAll(db.pokemonTypes, [
            for (final t in types)
              PokemonTypesCompanion.insert(
                pokemonId: dto.id,
                typeId: t.typeId,
                slot: t.slot,
              ),
          ]);
          b.insertAll(db.pokemonAbilities, [
            for (final a in dto.abilities)
              PokemonAbilitiesCompanion.insert(
                pokemonId: dto.id,
                abilityId: a.abilityId,
                isHidden: a.isHidden,
              ),
          ], mode: InsertMode.insertOrReplace);
        });
        await _touchMeta(summaryResource(dto.id), hash, now);
        written++;
      }
    }
    return (written: written, unchanged: unchanged);
  }

  Future<void> upsertDetail(PokemonDetailDto dto) async {
    final now = _now();
    final eggGroups = dto.eggGroups.join(',');
    await db.transaction(() async {
      // Primero las formas de la especie (incluida esta): así la fila existe
      // aunque sea una forma que el catálogo nunca trajo.
      await _writeSummaries(dto.varieties, now);
      await (db.update(db.pokemon)..where((p) => p.id.equals(dto.id))).write(
        PokemonCompanion(
          hasDetail: const Value(true),
          height: Value(dto.height),
          weight: Value(dto.weight),
          flavorEs: Value(dto.flavorEs),
          flavorEn: Value(dto.flavorEn),
          eggGroups: Value(eggGroups),
          captureRate: Value(dto.captureRate),
          isLegendary: Value(dto.isLegendary),
          isMythical: Value(dto.isMythical),
          shinyArtworkUrl: Value(dto.shinyArtworkUrl),
          evolutionChainId: Value(dto.evolutionChainId),
        ),
      );
      await (db.delete(
        db.pokemonMoves,
      )..where((m) => m.pokemonId.equals(dto.id))).go();
      await db.batch((b) {
        b.insertAll(db.abilities, [
          for (final a in dto.abilities)
            AbilitiesCompanion.insert(
              id: Value(a.id),
              name: a.slug,
              nameEs: a.nameEs,
              nameEn: a.nameEn,
              effectEs: Value(a.effectEs),
              effectEn: Value(a.effectEn),
            ),
        ], mode: InsertMode.insertOrReplace);
        b.insertAll(db.pokemonAbilities, [
          for (final a in dto.abilities)
            PokemonAbilitiesCompanion.insert(
              pokemonId: dto.id,
              abilityId: a.id,
              isHidden: a.isHidden,
            ),
        ], mode: InsertMode.insertOrReplace);
        b.insertAll(db.moves, [
          for (final m in dto.moves)
            MovesCompanion.insert(
              id: Value(m.id),
              name: m.slug,
              power: Value(m.power),
              accuracy: Value(m.accuracy),
              pp: Value(m.pp),
              typeId: m.typeId,
              damageClassId: m.damageClassId,
            ),
        ], mode: InsertMode.insertOrReplace);
        b.insertAll(db.pokemonMoves, [
          for (final l in dto.learnset)
            PokemonMovesCompanion.insert(
              pokemonId: dto.id,
              moveId: l.moveId,
              versionGroupId: l.versionGroupId,
              methodId: l.methodId,
              level: l.level,
            ),
        ], mode: InsertMode.insertOrIgnore);
        if (dto.evolutionChainId != null) {
          b.insertAll(db.evolutions, [
            for (final e in dto.evolutions)
              EvolutionsCompanion.insert(
                speciesId: Value(e.speciesId),
                chainId: dto.evolutionChainId!,
                fromSpeciesId: Value(e.fromSpeciesId),
                name: e.slug,
                trigger: Value(e.trigger),
                minLevel: Value(e.minLevel),
                item: Value(e.item),
                minHappiness: Value(e.minHappiness),
                timeOfDay: Value(e.timeOfDay),
              ),
          ], mode: InsertMode.insertOrReplace);
        }
      });
      final hash = detailHash(
        height: dto.height,
        weight: dto.weight,
        flavorEs: dto.flavorEs,
        flavorEn: dto.flavorEn,
        eggGroups: eggGroups,
        captureRate: dto.captureRate,
        isLegendary: dto.isLegendary,
        isMythical: dto.isMythical,
      );
      await _touchMeta(detailResource(dto.id), hash, now);
    });
  }

  Future<void> upsertStatic(StaticDataDto dto) async {
    await db.transaction(() async {
      await db.batch((b) {
        b.insertAll(db.pokeTypes, [
          for (final t in dto.types)
            PokeTypesCompanion.insert(
              id: Value(t.id),
              name: t.slug,
              nameEs: t.nameEs,
              nameEn: t.nameEn,
            ),
        ], mode: InsertMode.insertOrReplace);
        b.insertAll(db.typeEfficacy, [
          for (final e in dto.efficacy)
            TypeEfficacyCompanion.insert(
              attackTypeId: e.attack,
              targetTypeId: e.target,
              factor: e.factor,
            ),
        ], mode: InsertMode.insertOrReplace);
        b.insertAll(db.versionGroups, [
          for (final v in dto.versionGroups)
            VersionGroupsCompanion.insert(
              id: Value(v.id),
              name: v.slug,
              generationId: v.generationId,
              sortOrder: v.order,
            ),
        ], mode: InsertMode.insertOrReplace);
        b.insertAll(db.generations, [
          for (final g in dto.generations)
            GenerationsCompanion.insert(
              id: Value(g.id),
              name: g.slug,
              regionName: g.region,
            ),
        ], mode: InsertMode.insertOrReplace);
        // insertOrIgnore: no pisa los efectos que ya trajo un detalle.
        b.insertAll(db.abilities, [
          for (final a in dto.abilities)
            AbilitiesCompanion.insert(
              id: Value(a.id),
              name: a.slug,
              nameEs: a.nameEs,
              nameEn: a.nameEn,
            ),
        ], mode: InsertMode.insertOrIgnore);
      });
      await _touchMeta(staticResource, null, _now());
    });
  }

  Future<void> _touchMeta(String resource, String? hash, DateTime now) => db
      .into(db.syncMeta)
      .insertOnConflictUpdate(
        SyncMetaCompanion.insert(
          resource: resource,
          lastSyncedAt: Value(now),
          contentHash: Value(hash),
          status: const Value('ok'),
          attempts: const Value(0),
          lastError: const Value(null),
        ),
      );

  Future<void> recordFailure(String resource, String error) async {
    final existing = await (db.select(
      db.syncMeta,
    )..where((m) => m.resource.equals(resource))).getSingleOrNull();
    await db
        .into(db.syncMeta)
        .insertOnConflictUpdate(
          SyncMetaCompanion.insert(
            resource: resource,
            lastSyncedAt: Value(existing?.lastSyncedAt),
            contentHash: Value(existing?.contentHash),
            status: const Value('error'),
            attempts: Value((existing?.attempts ?? 0) + 1),
            lastError: Value(error),
          ),
        );
  }

  Future<void> markStale(Iterable<String> resources) async {
    if (resources.isEmpty) return;
    await (db.update(db.syncMeta)..where((m) => m.resource.isIn(resources)))
        .write(const SyncMetaCompanion(status: Value('stale')));
  }

  Future<void> setImageFiles(
    Map<int, ({String? sprite, String? artwork})> files,
  ) async {
    if (files.isEmpty) return;
    await db.batch((b) {
      for (final MapEntry(key: id, value: f) in files.entries) {
        b.update(
          db.pokemon,
          PokemonCompanion(
            spriteFile: f.sprite == null
                ? const Value.absent()
                : Value(f.sprite),
            artworkFile: f.artwork == null
                ? const Value.absent()
                : Value(f.artwork),
          ),
          where: (p) => p.id.equals(id),
        );
      }
    });
  }

  Future<Set<int>> localIds() async {
    final query = db.selectOnly(db.pokemon)..addColumns([db.pokemon.id]);
    return {for (final r in await query.get()) r.read(db.pokemon.id)!};
  }

  /// Cuenta solo las formas por defecto: es lo que se compara con el total
  /// remoto para saber si el catálogo local está completo.
  Future<int> pokemonCount() async {
    final count = db.pokemon.id.count();
    final row =
        await (db.selectOnly(db.pokemon)
              ..addColumns([count])
              ..where(db.pokemon.isDefault.equals(true)))
            .getSingle();
    return row.read(count) ?? 0;
  }

  Stream<int> watchPokemonCount() {
    final count = db.pokemon.id.count();
    return (db.selectOnly(db.pokemon)
          ..addColumns([count])
          ..where(db.pokemon.isDefault.equals(true)))
        .watchSingle()
        .map((r) => r.read(count) ?? 0);
  }

  Future<SyncMetaRow?> meta(String resource) => (db.select(
    db.syncMeta,
  )..where((m) => m.resource.equals(resource))).getSingleOrNull();

  /// Recursos a revalidar: alterados (stale) o vencidos por la política TTL.
  Future<List<String>> resourcesNeedingRefresh(
    String prefix, {
    int limit = 100,
  }) async {
    final expiredBefore = _now().subtract(AppConfig.freshnessTtl);
    final rows =
        await (db.select(db.syncMeta)
              ..where(
                (m) =>
                    m.resource.like('$prefix%') &
                    (m.status.isIn(['stale', 'error']) |
                        m.lastSyncedAt.isSmallerThanValue(expiredBefore)),
              )
              ..limit(limit))
            .get();
    return [for (final r in rows) r.resource];
  }

  Future<int> countStale() async {
    final count = db.syncMeta.resource.count();
    final row =
        await (db.selectOnly(db.syncMeta)
              ..addColumns([count])
              ..where(db.syncMeta.status.equals('stale')))
            .getSingle();
    return row.read(count) ?? 0;
  }

  Future<DateTime?> lastCatalogSync() async =>
      (await meta(catalogResource))?.lastSyncedAt;

  Future<void> touchCatalog() => _touchMeta(catalogResource, null, _now());

  Future<List<PokemonRow>> pokemonMissingSprites({int limit = 40}) =>
      (db.select(db.pokemon)
            ..where((p) => p.spriteFile.isNull() & p.spriteUrl.isNotNull())
            ..orderBy([(p) => OrderingTerm.asc(p.id)])
            ..limit(limit))
          .get();

  Future<PokemonRow?> pokemonById(int id) =>
      (db.select(db.pokemon)..where((p) => p.id.equals(id))).getSingleOrNull();

  /// Las formas de una especie, la por defecto primero.
  Future<List<PokemonRow>> varietiesOf(int speciesId) =>
      (db.select(db.pokemon)
            ..where((p) => p.speciesId.equals(speciesId))
            ..orderBy([
              (p) => OrderingTerm.desc(p.isDefault),
              (p) => OrderingTerm.asc(p.id),
            ]))
          .get();

  /// Devuelve los recursos alterados a mano. Calcula en otro isolate para no
  /// trabar la interfaz; con [onlyId] revisa un solo Pokémon.
  Future<List<String>> findTamperedResources({int? onlyId}) async {
    final pokemon =
        await (db.select(db.pokemon)..where(
              (p) =>
                  onlyId == null ? const Constant(true) : p.id.equals(onlyId),
            ))
            .get();
    final types =
        await (db.select(db.pokemonTypes)
              ..where(
                (t) => onlyId == null
                    ? const Constant(true)
                    : t.pokemonId.equals(onlyId),
              )
              ..orderBy([(t) => OrderingTerm.asc(t.slot)]))
            .get();
    final metas = await db.select(db.syncMeta).get();

    final typesById = <int, List<int>>{};
    for (final t in types) {
      typesById.putIfAbsent(t.pokemonId, () => []).add(t.typeId);
    }
    final storedHash = {for (final m in metas) m.resource: m.contentHash};

    // Solo datos primitivos cruzan al otro isolate.
    final payload = [
      for (final p in pokemon)
        <Object?>[
          p.id,
          p.name,
          p.nameEs,
          p.nameEn,
          p.generationId,
          [
            p.hp,
            p.attack,
            p.defense,
            p.specialAttack,
            p.specialDefense,
            p.speed,
          ],
          typesById[p.id] ?? const <int>[],
          p.hasDetail,
          p.height,
          p.weight,
          p.flavorEs,
          p.flavorEn,
          p.eggGroups,
          p.captureRate,
          p.isLegendary,
          p.isMythical,
        ],
    ];
    final encoded = jsonEncode(payload);
    return Isolate.run(() => _compareHashes(encoded, storedHash));
  }

  /// Búsqueda, filtros y orden corren en SQLite: igual con o sin red.
  ({String where, List<Variable<Object>> args}) _whereFor(CatalogQuery q) {
    // Las formas alternativas se ven desde la ficha de su especie.
    final clauses = <String>['p.is_default = 1'];
    final args = <Variable<Object>>[];
    final search = q.search.trim().toLowerCase();
    if (search.isNotEmpty) {
      final number = int.tryParse(search.replaceAll('#', ''));
      if (number != null) {
        clauses.add('p.id = ?');
        args.add(Variable.withInt(number));
      } else {
        clauses.add(
          '(lower(p.name_es) LIKE ? OR lower(p.name_en) LIKE ? OR p.name LIKE ?)',
        );
        final like = '%$search%';
        args.addAll([
          Variable.withString(like),
          Variable.withString(like),
          Variable.withString(like),
        ]);
      }
    }
    // Varios tipos = el Pokémon debe tenerlos todos (útil para tipos dobles).
    for (final typeId in q.typeIds) {
      clauses.add(
        'EXISTS (SELECT 1 FROM pokemon_types t WHERE t.pokemon_id = p.id AND t.type_id = ?)',
      );
      args.add(Variable.withInt(typeId));
    }
    if (q.generationId != null) {
      clauses.add('p.generation_id = ?');
      args.add(Variable.withInt(q.generationId!));
    }
    if (q.abilityId != null) {
      clauses.add(
        'EXISTS (SELECT 1 FROM pokemon_abilities a WHERE a.pokemon_id = p.id AND a.ability_id = ?)',
      );
      args.add(Variable.withInt(q.abilityId!));
    }
    if (q.favoritesOnly) {
      clauses.add(
        'EXISTS (SELECT 1 FROM favorites f WHERE f.pokemon_id = p.id)',
      );
    }
    return (where: clauses.join(' AND '), args: args);
  }

  static String _orderFor(CatalogQuery q, String languageCode) {
    final column = switch (q.sort) {
      CatalogSort.number => 'p.id',
      CatalogSort.name =>
        languageCode == 'es'
            ? 'p.name_es COLLATE NOCASE'
            : 'p.name_en COLLATE NOCASE',
      CatalogSort.total => 'p.stat_total',
      CatalogSort.attack => 'p.attack',
      CatalogSort.defense => 'p.defense',
      CatalogSort.speed => 'p.speed',
    };
    return '$column ${q.ascending ? 'ASC' : 'DESC'}, p.id ASC';
  }

  Stream<List<CatalogRow>> watchCatalog(
    CatalogQuery q, {
    required int limit,
    required String languageCode,
  }) {
    final filter = _whereFor(q);
    return db
        .customSelect(
          'SELECT p.*, '
          '(SELECT group_concat(type_id) FROM '
          '(SELECT type_id FROM pokemon_types WHERE pokemon_id = p.id ORDER BY slot)) AS type_ids, '
          'EXISTS (SELECT 1 FROM favorites f WHERE f.pokemon_id = p.id) AS is_favorite '
          'FROM pokemon p WHERE ${filter.where} '
          'ORDER BY ${_orderFor(q, languageCode)} LIMIT ?',
          variables: [...filter.args, Variable.withInt(limit)],
          readsFrom: {
            db.pokemon,
            db.pokemonTypes,
            db.favorites,
            db.pokemonAbilities,
          },
        )
        .watch()
        .map((rows) => [for (final row in rows) _catalogRow(row)]);
  }

  Stream<int> watchCatalogCount(CatalogQuery q) {
    final filter = _whereFor(q);
    return db
        .customSelect(
          'SELECT COUNT(*) AS c FROM pokemon p WHERE ${filter.where}',
          variables: filter.args,
          readsFrom: {
            db.pokemon,
            db.pokemonTypes,
            db.favorites,
            db.pokemonAbilities,
          },
        )
        .watchSingle()
        .map((row) => row.read<int>('c'));
  }

  CatalogRow _catalogRow(QueryRow row) {
    final typeIds = (row.readNullable<String>('type_ids') ?? '')
        .split(',')
        .where((s) => s.isNotEmpty)
        .map(int.parse)
        .toList();
    return (
      pokemon: db.pokemon.map(row.data),
      typeIds: typeIds,
      isFavorite: row.read<bool>('is_favorite'),
    );
  }

  Stream<List<CatalogRow>> watchFavorites() => db
      .customSelect(
        'SELECT p.*, '
        '(SELECT group_concat(type_id) FROM '
        '(SELECT type_id FROM pokemon_types WHERE pokemon_id = p.id ORDER BY slot)) AS type_ids, '
        '1 AS is_favorite '
        'FROM favorites f JOIN pokemon p ON p.id = f.pokemon_id ORDER BY f.added_at DESC',
        readsFrom: {db.pokemon, db.pokemonTypes, db.favorites},
      )
      .watch()
      .map((rows) => [for (final row in rows) _catalogRow(row)]);

  Future<List<CatalogRow>> playable({required bool requireDetail}) async {
    final rows = await db
        .customSelect(
          'SELECT p.*, '
          '(SELECT group_concat(type_id) FROM '
          '(SELECT type_id FROM pokemon_types WHERE pokemon_id = p.id ORDER BY slot)) AS type_ids, '
          'EXISTS (SELECT 1 FROM favorites f WHERE f.pokemon_id = p.id) AS is_favorite '
          'FROM pokemon p WHERE p.is_default = 1 '
          'AND (p.sprite_file IS NOT NULL OR p.artwork_file IS NOT NULL)'
          '${requireDetail ? ' AND p.has_detail = 1' : ''}',
        )
        .get();
    return [for (final row in rows) _catalogRow(row)];
  }

  Future<bool> toggleFavorite(int pokemonId) => db.transaction(() async {
    final deleted = await (db.delete(
      db.favorites,
    )..where((f) => f.pokemonId.equals(pokemonId))).go();
    if (deleted > 0) return false;
    await db
        .into(db.favorites)
        .insert(
          FavoritesCompanion.insert(
            pokemonId: Value(pokemonId),
            addedAt: _now(),
          ),
        );
    return true;
  });

  Future<String?> readSetting(String key) async => (await (db.select(
    db.appSettings,
  )..where((s) => s.key.equals(key))).getSingleOrNull())?.value;

  Stream<String?> watchSetting(String key) =>
      (db.select(db.appSettings)..where((s) => s.key.equals(key)))
          .watchSingleOrNull()
          .map((row) => row?.value);

  Future<void> writeSetting(String key, String value) => db
      .into(db.appSettings)
      .insertOnConflictUpdate(
        AppSettingsCompanion.insert(key: key, value: value),
      );
}

/// Corre dentro del isolate: no puede tocar la base, solo calcula.
List<String> _compareHashes(String encodedRows, Map<String, String?> stored) {
  final rows = (jsonDecode(encodedRows) as List<Object?>).cast<List<Object?>>();
  final tampered = <String>[];
  for (final r in rows) {
    final id = r[0]! as int;
    final summary = summaryHash(
      id: id,
      slug: r[1]! as String,
      nameEs: r[2]! as String,
      nameEn: r[3]! as String,
      generationId: r[4]! as int,
      stats: (r[5]! as List<Object?>).cast<int>(),
      typeIdsBySlot: (r[6]! as List<Object?>).cast<int>(),
    );
    final expected = stored[summaryResource(id)];
    if (expected != null && expected != summary) {
      tampered.add(summaryResource(id));
    }

    final hasDetail = r[7]! as bool;
    final expectedDetail = stored[detailResource(id)];
    if (hasDetail && expectedDetail != null) {
      final detail = detailHash(
        height: r[8] as int?,
        weight: r[9] as int?,
        flavorEs: r[10] as String?,
        flavorEn: r[11] as String?,
        eggGroups: r[12] as String?,
        captureRate: r[13] as int?,
        isLegendary: r[14]! as bool,
        isMythical: r[15]! as bool,
      );
      if (detail != expectedDetail) tampered.add(detailResource(id));
    }
  }
  return tampered;
}
