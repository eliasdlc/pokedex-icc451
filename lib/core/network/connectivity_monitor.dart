import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

import '../config/app_config.dart';
import '../connectivity/connectivity_state.dart';
import 'api_failure_simulator.dart';

/// Detecta la disponibilidad REAL del servicio: tener Wi-Fi no basta, así que
/// cada cambio de red dispara una sonda contra la API.
class ConnectivityMonitor implements ConnectivityService {
  ConnectivityMonitor({
    required Future<bool> Function() probe,
    required ApiFailureSimulator simulator,
    Connectivity? connectivity,
    Duration offlineGrace = AppConfig.offlineGrace,
  }) : _probe = probe,
       _simulator = simulator,
       _connectivity = connectivity ?? Connectivity(),
       _offlineGrace = offlineGrace;

  final Future<bool> Function() _probe;
  final ApiFailureSimulator _simulator;
  final Connectivity _connectivity;
  final Duration _offlineGrace;

  final _controller = StreamController<ServiceAvailability>.broadcast();
  ServiceAvailability _current = ServiceAvailability.checking;
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  Timer? _retryTimer;
  Future<ServiceAvailability>? _inFlight;

  @override
  ServiceAvailability get current => _current;

  @override
  Stream<ServiceAvailability> watch() async* {
    yield _current;
    yield* _controller.stream;
  }

  void start() {
    _subscription = _connectivity.onConnectivityChanged.listen(
      (_) => recheck(),
    );
    _simulator.addListener(_onSimulatorChanged);
    unawaited(recheck());
  }

  void _onSimulatorChanged() => unawaited(recheck());

  @override
  Future<ServiceAvailability> recheck() =>
      // Evita sondas concurrentes: si ya hay una en curso, se reutiliza.
      _inFlight ??= _evaluate().whenComplete(() {
        _inFlight = null;
      });

  Future<bool> _hasNetwork() async {
    try {
      final results = await _connectivity.checkConnectivity();
      return results.any((r) => r != ConnectivityResult.none);
    } on Exception {
      // Algunos escritorios no exponen el estado de red: se decide por la sonda.
      return true;
    }
  }

  Future<ServiceAvailability> _evaluate() async {
    var hasNetwork = await _hasNetwork();
    if (!hasNetwork && _current == ServiceAvailability.online) {
      await Future<void>.delayed(_offlineGrace);
      hasNetwork = await _hasNetwork();
    }
    final next = !hasNetwork
        ? ServiceAvailability.offline
        : (await _probe())
        ? ServiceAvailability.online
        : ServiceAvailability.serviceUnavailable;
    _emit(next);
    return next;
  }

  @override
  void reportServiceFailure() {
    if (_current == ServiceAvailability.online) {
      _emit(ServiceAvailability.serviceUnavailable);
    }
  }

  void _emit(ServiceAvailability next) {
    _retryTimer?.cancel();
    if (next != ServiceAvailability.online) {
      // Mientras no haya servicio, vuelve a sondear cada cierto tiempo.
      debugPrint(
        'conectividad: ${next.name}, nueva sonda en '
        '${AppConfig.reconnectProbeInterval.inSeconds} s',
      );
      _retryTimer = Timer(
        AppConfig.reconnectProbeInterval,
        () => unawaited(recheck()),
      );
    }
    if (next == _current) return;
    _current = next;
    _controller.add(next);
  }

  @visibleForTesting
  void debugEmit(ServiceAvailability next) => _emit(next);

  Future<void> dispose() async {
    _retryTimer?.cancel();
    _simulator.removeListener(_onSimulatorChanged);
    await _subscription?.cancel();
    await _controller.close();
  }
}
