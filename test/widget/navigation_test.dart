import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/home_shell.dart';
import 'package:pokedex/app/home_tab.dart';
import 'package:pokedex/features/pokedex/presentation/widgets/pokemon_list_card.dart';
import 'package:pokedex/shared/widgets/pokeball_navbar.dart';

import '../support/fake_pokedex.dart';
import '../support/phone_host.dart';

FakePokedexRepository _repository({Set<int> favorites = const {}}) =>
    FakePokedexRepository([
      for (var i = 1; i <= 40; i++)
        fakePokemon(i, 'Poke $i', [
          fakeTypes[i % fakeTypes.length],
        ], isFavorite: favorites.contains(i)),
    ]);

void main() {
  setUpAll(loadAppFonts);

  group('navbar Pokébola', () {
    testWidgets('cinco pestañas, sin Ajustes, en la misma posición', (
      tester,
    ) async {
      usePhoneSurface(tester);
      await tester.pumpWidget(
        phoneHost(
          const HomeShell(),
          overrides: fakePokedexOverrides(_repository()),
        ),
      );
      await settle(tester);

      final nav = find.byType(PokeballNavbar);
      for (final label in [
        'Pokédex',
        'Regiones',
        'Jugar',
        'Favoritos',
        'Perfil',
      ]) {
        expect(
          find.descendant(of: nav, matching: find.bySemanticsLabel(label)),
          findsOneWidget,
          reason: label,
        );
      }
      expect(find.text('Ajustes'), findsNothing);

      final where = tester.getRect(nav);
      // Deja libre la zona del indicador de inicio (34).
      expect(where.bottom, 852);
      for (final label in ['Regiones', 'Jugar', 'Favoritos', 'Perfil']) {
        await tester.tap(
          find.descendant(of: nav, matching: find.bySemanticsLabel(label)),
        );
        await settle(tester);
        expect(tester.getRect(nav), where, reason: 'posición en $label');
      }
      await unmount(tester);
    });

    testWidgets('cada pestaña conserva su scroll', (tester) async {
      usePhoneSurface(tester);
      await tester.pumpWidget(
        phoneHost(
          const HomeShell(),
          overrides: fakePokedexOverrides(_repository(favorites: {1, 2})),
        ),
      );
      await settle(tester);

      double offset() => tester
          .state<ScrollableState>(find.byType(Scrollable).first)
          .position
          .pixels;

      await tester.drag(
        find.byType(CustomScrollView).first,
        const Offset(0, -500),
      );
      await settle(tester);
      final scrolled = offset();
      expect(scrolled, greaterThan(100));

      final container = ProviderScope.containerOf(
        tester.element(find.byType(HomeShell)),
      );
      container.read(homeTabProvider.notifier).show(NavTab.favorites.index);
      await settle(tester);
      container.read(homeTabProvider.notifier).show(NavTab.pokedex.index);
      await settle(tester);
      expect(offset(), scrolled);
      await unmount(tester);
    });

    testWidgets(
      'las tarjetas se miden por itemExtent y no recortan el sprite',
      (tester) async {
        usePhoneSurface(tester);
        await tester.pumpWidget(
          phoneHost(
            const HomeShell(),
            overrides: fakePokedexOverrides(_repository()),
          ),
        );
        await settle(tester);

        final list = tester.widget<SliverFixedExtentList>(
          find.byType(SliverFixedExtentList),
        );
        // 120 de tarjeta más 12 de separación.
        expect(list.itemExtent, PokemonListCard.extent);
        expect(PokemonListCard.extent, 132);
        final scroll = tester.widget<CustomScrollView>(
          find.byType(CustomScrollView).first,
        );
        expect(scroll.clipBehavior, Clip.none);
        await unmount(tester);
      },
    );
  });
}
