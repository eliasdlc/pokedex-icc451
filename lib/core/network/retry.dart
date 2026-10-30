import 'dart:async';
import 'dart:math';

import '../config/app_config.dart';
import '../error/failures.dart';

/* Ejecuta [action] reintentando solo los fallos transitorios, con backoff
exponencial y jitter: espera base, base*2, base*4... entre intentos, hasta
[maxAttempts] intentos (con 4, son 3 esperas).

El jitter evita que varios clientes reintenten en el mismo
milisegundo.*/
Future<T> retryWithBackoff<T>(
  Future<T> Function() action, {
  int maxAttempts = AppConfig.maxRetryAttempts,
  Duration baseDelay = AppConfig.retryBaseDelay,
  Future<void> Function(Duration) sleep = _defaultSleep,
  Random? random,
  void Function(int attempt, Failure failure)? onRetry,
}) async {
  final rng = random ?? Random();
  for (var attempt = 1; ; attempt++) {
    try {
      return await action();
    } on Failure catch (failure) {
      final canRetry = failure.isTransient && attempt < maxAttempts;
      if (!canRetry) rethrow;
      onRetry?.call(attempt, failure);
      final factor = failure is RateLimitedFailure ? 2 : 1;
      final exponential = baseDelay * pow(2, attempt - 1).toInt() * factor;
      final jitter = 0.8 + rng.nextDouble() * 0.4;
      await sleep(exponential * jitter);
    }
  }
}

Future<void> _defaultSleep(Duration d) => Future<void>.delayed(d);
