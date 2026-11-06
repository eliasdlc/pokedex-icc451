import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/connectivity/connectivity_state.dart';
import 'package:pokedex/core/network/api_failure_simulator.dart';
import 'package:pokedex/core/network/connectivity_monitor.dart';

/// Red falsa: la prueba decide qué responde `checkConnectivity`.
class _FakeNetwork implements Connectivity {
  List<ConnectivityResult> now = [ConnectivityResult.wifi];
  final changes = StreamController<List<ConnectivityResult>>.broadcast();

  @override
  Future<List<ConnectivityResult>> checkConnectivity() async => now;

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged => changes.stream;
}

void main() {
  late _FakeNetwork network;
  late ConnectivityMonitor monitor;

  setUp(() async {
    network = _FakeNetwork();
    monitor = ConnectivityMonitor(
      probe: () async => true,
      simulator: ApiFailureSimulator(),
      connectivity: network,
      offlineGrace: const Duration(milliseconds: 50),
    );
    monitor.start();
    await monitor.recheck();
  });

  tearDown(() => monitor.dispose());

  test('IND-06 un corte breve no pasa el indicador a Sin conexión', () async {
    final seen = <ServiceAvailability>[];
    final sub = monitor.watch().skip(1).listen(seen.add);
    network.now = [ConnectivityResult.none];
    final check = monitor.recheck();
    // La red vuelve dentro de la gracia.
    network.now = [ConnectivityResult.wifi];
    expect(await check, ServiceAvailability.online);
    expect(seen, isEmpty);
    await sub.cancel();
  });

  test('una pérdida que dura más que la gracia sí se anuncia', () async {
    network.now = [ConnectivityResult.none];
    expect(await monitor.recheck(), ServiceAvailability.offline);
    expect(monitor.current, ServiceAvailability.offline);
  });
}
