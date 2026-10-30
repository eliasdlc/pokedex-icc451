import 'package:flutter/foundation.dart';

import '../config/app_config.dart';

class ApiFailureSimulator extends ValueNotifier<bool> {
  ApiFailureSimulator() : super(AppConfig.simulateApiDownFromBuild);

  bool get isApiDown => value;
  set isApiDown(bool down) => value = down;
}
