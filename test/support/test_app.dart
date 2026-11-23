import 'package:drift/native.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/core/connectivity/connectivity_state.dart';
import 'package:pokedex/core/database/app_database.dart';

import 'fakes.dart';

({
  List<Override> overrides,
  AppDatabase db,
  FakeRemote remote,
  FakeConnectivity connectivity,
})
testOverrides({
  int total = 30,
  ServiceAvailability availability = ServiceAvailability.online,
}) {
  final db = AppDatabase(NativeDatabase.memory());
  final remote = FakeRemote(total);
  final connectivity = FakeConnectivity(availability, remote: remote);
  return (
    db: db,
    remote: remote,
    connectivity: connectivity,
    overrides: [
      databaseProvider.overrideWithValue(db),
      remoteDataSourceProvider.overrideWithValue(remote),
      connectivityServiceProvider.overrideWithValue(connectivity),
      imageStoreProvider.overrideWithValue(FakeImages()),
    ],
  );
}
