import 'package:flutter/widgets.dart';

/// El indicador global vive por encima del Navigator (en MaterialApp.builder),
/// así que abre su hoja a través de esta llave.
final rootNavigatorKey = GlobalKey<NavigatorState>();
