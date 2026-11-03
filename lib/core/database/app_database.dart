import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Pokemon,
    PokeTypes,
    PokemonTypes,
    TypeEfficacy,
    Generations,
    VersionGroups,
    Abilities,
    PokemonAbilities,
    Moves,
    PokemonMoves,
    Evolutions,
    Favorites,
    TriviaScores,
    Achievements,
    BattleRecords,
    SyncMeta,
    AppSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: databaseName));

  static const databaseName = 'pokedex';

  /// 2: formas, versiones de juego y movimientos por versión y método.
  /// 3: nombre japonés del Pokémon.
  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        // Columnas nuevas: SQLite las agrega sin tocar las filas existentes.
        await m.addColumn(pokemon, pokemon.speciesId);
        await m.addColumn(pokemon, pokemon.isDefault);
        await m.addColumn(pokemon, pokemon.formNameEs);
        await m.addColumn(pokemon, pokemon.formNameEn);
        await m.createIndex(idxPokemonSpecies);
        // En el esquema 1 todas las filas eran formas por defecto, y su
        // especie tiene el mismo id.
        await customStatement('UPDATE pokemon SET species_id = id');
        // La llave de pokemon_moves cambió: se recrea. Sus datos se vuelven a
        // pedir porque los detalles quedan vencidos por la política TTL.
        await m.deleteTable('pokemon_moves');
        await m.createTable(pokemonMoves);
        await m.createIndex(idxPokemonMovesVersion);
        await m.createTable(versionGroups);
        // Los datos de usuario (favoritos, trivia, logros) no se tocan.
        await customStatement(
          "DELETE FROM sync_meta WHERE resource = 'static'",
        );
        // Vencidos, no "stale": stale significa alterado a mano y mostraría
        // el aviso de datos alterados en cada ficha vieja.
        await customStatement(
          "UPDATE sync_meta SET last_synced_at = 0 WHERE resource LIKE 'detail:%'",
        );
      }
      if (from < 3) {
        // Columna nueva y vacía: SQLite no toca las filas existentes.
        await m.addColumn(pokemon, pokemon.nameJa);
        // Para llenarla hay que volver a pedir el catálogo. Sin huella y con
        // fecha vencida, la revalidación vuelve a pedir cada Pokémon y, como
        // la huella guardada ya no coincide, reescribe la fila. El vigilante
        // de integridad ignora un recurso sin huella, así que no se alarma.
        // Favoritos, trivia y logros no se tocan.
        await customStatement(
          'UPDATE sync_meta SET content_hash = NULL, last_synced_at = 0 '
          "WHERE resource LIKE 'pokemon:%'",
        );
      }
    },
    beforeOpen: (details) async {
      // WAL permite leer mientras la sincronización escribe.
      await customStatement('PRAGMA journal_mode = WAL');
    },
  );
}
