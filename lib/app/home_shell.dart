import 'package:flutter/material.dart';

import '../features/pokedex/presentation/catalog/catalog_screen.dart';

/// TEMPORAL hasta la fase 4.8: allí se reemplaza entero por el shell con las
/// cinco pestañas y la barra de juego. Por ahora solo monta el catálogo, para
/// poder correr la app y probar la ficha (4.5) en el emulador.
class HomeShell extends StatelessWidget {
  const HomeShell({super.key});

  @override
  Widget build(BuildContext context) => const CatalogScreen();
}
