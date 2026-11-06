import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/connectivity/connectivity_state.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/pokedex/data/local/pokedex_local_data_source.dart';
import 'package:pokedex/features/pokedex/data/remote/dtos.dart';
import 'package:pokedex/features/pokedex/data/repositories/pokedex_repository_impl.dart';
import 'package:pokedex/features/pokedex/data/sync/sync_engine.dart';
import 'package:pokedex/features/pokedex/domain/entities/catalog_query.dart';

import '../support/fakes.dart';

/// Nombre japonés: del JSON de PokéAPI hasta la entidad, y la migración 2 a 3.
void main() {
  Json speciesJson({required List<Json> names}) => {
    'id': 25,
    'name': 'pikachu',
    'pokemon_species_id': 25,
    'is_default': true,
    'pokemonforms': <Json>[],
    'pokemonspecy': {
      'generation_id': 1,
      'evolution_chain_id': 10,
      'pokemonspeciesnames': names,
    },
    'pokemontypes': [
      {'slot': 1, 'type_id': 13},
    ],
    'pokemonstats': [
      for (final name in PokemonSummaryDto.statNames)
        {
          'base_stat': 40,
          'stat': {'name': name},
        },
    ],
    'pokemonabilities': <Json>[],
  };

  group('DTO', () {
    test('toma el katakana del idioma ja-hrkt (id 1)', () {
      final dto = PokemonSummaryDto.fromJson(
        speciesJson(
          names: [
            {'name': 'ピカチュウ', 'language_id': 1},
            {'name': 'Pikachu', 'language_id': 7},
            {'name': 'Pikachu', 'language_id': 9},
          ],
        ),
      );
      expect(dto.nameJa, 'ピカチュウ');
      expect(dto.nameEs, 'Pikachu');
    });

    test('sin nombre japonés queda null, sin inventar uno', () {
      final dto = PokemonSummaryDto.fromJson(
        speciesJson(
          names: [
            {'name': 'Pikachu', 'language_id': 9},
          ],
        ),
      );
      expect(dto.nameJa, isNull);
    });
  });

  test(
    'la sincronización lo guarda y llega a la entidad del catálogo',
    () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final local = PokedexLocalDataSource(db);
      final remote = FakeRemote(5);
      final engine = SyncEngine(
        remote: remote,
        local: local,
        connectivity: FakeConnectivity(ServiceAvailability.online),
        images: FakeImages(),
        sleep: (_) async {},
      );
      addTearDown(engine.dispose);

      await engine.refresh();

      expect((await local.pokemonById(3))!.nameJa, 'ポケ3');
      final repository = PokedexRepositoryImpl(local, languageCode: () => 'es');
      final catalog = await repository
          .watchCatalog(const CatalogQuery(), limit: 10)
          .first;
      expect(catalog.map((s) => s.nameJa), contains('ポケ3'));
    },
  );

  group('migración de la versión 2 a la 3', () {
    late Directory temp;
    late File file;

    setUp(() {
      temp = Directory.systemTemp.createTempSync('migracion_v3');
      file = File('${temp.path}/pokedex.sqlite');
    });
    tearDown(() => temp.deleteSync(recursive: true));

    /// Arma una base como la dejaba la versión 2: la actual sin `name_ja` y
    /// con `user_version = 2`.
    Future<void> baseVersion2() async {
      final db = AppDatabase(NativeDatabase(file));
      final local = PokedexLocalDataSource(db);
      await local.upsertSummaries([fakeSummary(25, nameJa: 'ピカチュウ')]);
      await db
          .into(db.favorites)
          .insert(
            FavoritesCompanion.insert(
              pokemonId: const Value(25),
              addedAt: DateTime(2026, 11, 1),
            ),
          );
      await db.customStatement('ALTER TABLE pokemon DROP COLUMN name_ja');
      await db.customStatement('PRAGMA user_version = 2');
      await db.close();
    }

    test(
      'agrega la columna vacía y deja el catálogo para volver a pedirse',
      () async {
        await baseVersion2();

        final db = AppDatabase(NativeDatabase(file));
        addTearDown(db.close);
        final local = PokedexLocalDataSource(db);

        final row = await local.pokemonById(25);
        expect(row, isNotNull, reason: 'la fila existente se conserva');
        expect(row!.nameJa, isNull);
        expect(row.nameEs, 'Poke 25');

        final meta = await local.meta('pokemon:25');
        expect(meta!.contentHash, isNull);
        expect(await local.resourcesNeedingRefresh('pokemon:'), ['pokemon:25']);

        // Los datos del usuario no se tocan.
        expect(await db.select(db.favorites).get(), hasLength(1));
      },
    );

    test('la revalidación siguiente llena el nombre japonés', () async {
      await baseVersion2();

      final db = AppDatabase(NativeDatabase(file));
      addTearDown(db.close);
      final local = PokedexLocalDataSource(db);
      final remote = FakeRemote(30);
      final engine = SyncEngine(
        remote: remote,
        local: local,
        connectivity: FakeConnectivity(ServiceAvailability.online),
        images: FakeImages(),
        sleep: (_) async {},
      );
      addTearDown(engine.dispose);

      await engine.refresh();

      expect((await local.pokemonById(25))!.nameJa, 'ポケ25');
      expect(await local.countStale(), 0);
      // La huella nueva ya está guardada: el siguiente refresh no reescribe.
      expect((await local.meta('pokemon:25'))!.contentHash, isNotNull);
    });
  });
}
