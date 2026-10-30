import 'dart:async';

import 'package:flutter/foundation.dart';

/* Retrasa una acción hasta que el usuario deja de escribir durante [delay].
Cada llamada cancela la anterior: solo corre la última. */
class Debouncer {
  Debouncer(this.delay);
  final Duration delay;
  Timer? _timer;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() => _timer?.cancel();
}
