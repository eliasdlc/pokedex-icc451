@Tags(['live'])
library;

import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/connectivity/connectivity_state.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/core/network/api_failure_simulator.dart';
import 'package:pokedex/features/pokedex/data/local/pokedex_local_data_source.dart';
import 'package:pokedex/features/pokedex/data/remote/pokeapi_remote_data_source.dart';
import 'package:pokedex/features/pokedex/data/sync/sync_engine.dart';

import '../support/fakes.dart';

void main() {
  test('avance: sincronización real, segunda pasada sin duplicados y corrección en caliente', () async {
    final file = File('build/avance.sqlite');
    if (file.existsSync()) file.deleteSync();
    file.parent.createSync(recursive: true);
    final db = AppDatabase(NativeDatabase(file));
    final local = PokedexLocalDataSource(db);
    final engine = SyncEngine(
      remote: GraphQLPokeApiRemoteDataSource(simulator: ApiFailureSimulator()),
      local: local,
      connectivity: FakeConnectivity(ServiceAvailability.online),
      images: FakeImages(),
    );
    final sub = engine.watch().listen(
      (s) => debugPrint('[sync] ${s.activity.name} remoto=${s.remoteTotal}'),
    );

    final reloj = Stopwatch()..start();
    await engine.refresh();
    final total = await local.pokemonCount();
    debugPrint(
      'primera pasada: $total en la base, ${reloj.elapsedMilliseconds} ms',
    );
    expect(total, greaterThanOrEqualTo(1025));

    reloj.reset();
    await engine.refresh();
    debugPrint(
      'segunda pasada: ${await local.pokemonCount()} en la base, ${reloj.elapsedMilliseconds} ms',
    );
    expect(await local.pokemonCount(), total);

    await db.customStatement(
      "UPDATE pokemon SET name_es = 'HACKEADO' WHERE id = 25",
    );
    expect(await engine.checkIntegrity(), 1);
    expect((await local.pokemonById(25))!.nameEs, 'Pikachu');
    debugPrint('Pikachu corregido desde la API');

    await sub.cancel();
    await engine.dispose();
    await db.close();
  }, timeout: const Timeout(Duration(minutes: 3)));
}
