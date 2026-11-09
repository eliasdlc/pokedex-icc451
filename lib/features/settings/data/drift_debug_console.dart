import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/debug_console.dart';

class DriftDebugConsole implements DebugConsole {
  DriftDebugConsole(this._db);
  final AppDatabase _db;

  @override
  Future<({List<String> rows, int? changed})> run(String statement) async {
    if (statement.toLowerCase().startsWith('select')) {
      final rows = await _db.customSelect(statement).get();
      return (
        rows: [for (final r in rows.take(20)) r.data.toString()],
        changed: null,
      );
    }
    // `updates` avisa a Drift qué tablas cambiaron: las pantallas abiertas se
    // repintan con el dato alterado, como si fuera un cambio real.
    final changed = await _db.customUpdate(
      statement,
      updates: {_db.pokemon, _db.pokemonTypes, _db.favorites, _db.syncMeta},
    );
    return (rows: const <String>[], changed: changed);
  }

  @override
  Stream<List<SyncRecord>> watchSyncRecords({int limit = 25}) =>
      (_db.select(_db.syncMeta)
            ..orderBy([(m) => OrderingTerm.desc(m.lastSyncedAt)])
            ..limit(limit))
          .watch()
          .map(
            (rows) => [
              for (final m in rows)
                SyncRecord(
                  resource: m.resource,
                  status: m.status,
                  lastSyncedAt: m.lastSyncedAt,
                ),
            ],
          );
}
