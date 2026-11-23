import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/games/presentation/play_screen.dart';
import '../features/pokedex/presentation/catalog/catalog_screen.dart';
import '../features/pokedex/presentation/favorites/favorites_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/regions/presentation/regions_screen.dart';
import '../shared/widgets/pokeball_navbar.dart';
import 'home_tab.dart';

class HomeShell extends ConsumerWidget {
  const HomeShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(homeTabProvider);
    void select(NavTab tab) =>
        ref.read(homeTabProvider.notifier).show(tab.index);
    // Mismo orden que `NavTab`: su índice es el del `IndexedStack`.
    final screens = [
      const CatalogScreen(),
      const RegionsScreen(),
      PlayScreen(onOpenCatalog: () => select(NavTab.pokedex)),
      const FavoritesScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      // La barra flota sobre el cuerpo; cada pestaña recibe su alto como
      // relleno inferior, y así un SnackBar queda encima.
      extendBody: true,
      body: IndexedStack(
        index: index,
        children: [
          // Las pestañas ocultas siguen construidas y repetirían el tag Hero.
          for (final (i, screen) in screens.indexed)
            HeroMode(enabled: i == index, child: screen),
        ],
      ),
      bottomNavigationBar: PokeballNavbar(
        current: NavTab.values[index],
        onSelect: select,
      ),
    );
  }
}
