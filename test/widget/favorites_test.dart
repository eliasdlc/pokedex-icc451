import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/home_shell.dart';
import 'package:pokedex/app/home_tab.dart';
import 'package:pokedex/shared/widgets/pokeball_navbar.dart';

import '../support/fake_pokedex.dart';
import '../support/phone_host.dart';

FakePokedexRepository _repository({bool withFavorites = true}) =>
    FakePokedexRepository([
      fakePokemon(6, 'Charizard', [fakeTypes[2]], isFavorite: withFavorites),
      fakePokemon(25, 'Pikachu', [fakeTypes[1]], isFavorite: withFavorites),
      fakePokemon(94, 'Gengar', [fakeTypes[5]]),
    ]);

Future<ProviderContainer> _openFavorites(
  WidgetTester tester,
  FakePokedexRepository repository, {
  Brightness brightness = Brightness.light,
}) async {
  usePhoneSurface(tester);
  await tester.pumpWidget(
    phoneHost(
      const HomeShell(),
      brightness: brightness,
      overrides: fakePokedexOverrides(repository),
    ),
  );
  await settle(tester);
  final container = ProviderScope.containerOf(
    tester.element(find.byType(HomeShell)),
  );
  container.read(homeTabProvider.notifier).show(NavTab.favorites.index);
  await settle(tester);
  return container;
}

void main() {
  setUpAll(loadAppFonts);

  for (final brightness in Brightness.values) {
    testWidgets('deslizar quita la tarjeta y Deshacer la devuelve '
        '(${brightness.name})', (tester) async {
      final repo = _repository();
      await _openFavorites(tester, repo, brightness: brightness);
      expect(find.text('Pikachu'), findsOneWidget);
      expect(find.text('Gengar'), findsNothing);

      await tester.drag(find.text('Pikachu'), const Offset(-500, 0));
      await settle(tester);
      await settle(tester);

      expect(find.text('Pikachu'), findsNothing);
      expect(find.text('Charizard'), findsOneWidget);
      expect(find.text('Quitaste a Pikachu de favoritos'), findsOneWidget);

      final snack = tester.getRect(find.byType(SnackBar));
      final nav = tester.getRect(find.byType(PokeballNavbar));
      expect(snack.bottom, lessThanOrEqualTo(nav.top));

      await tester.tap(find.text('Deshacer'));
      await settle(tester);
      await settle(tester);
      expect(find.text('Pikachu'), findsOneWidget);
      await unmount(tester);
    });
  }

  testWidgets('quitar la última deja el estado vacío con una acción', (
    tester,
  ) async {
    final repo = FakePokedexRepository([
      fakePokemon(25, 'Pikachu', [fakeTypes[1]], isFavorite: true),
    ]);
    final container = await _openFavorites(tester, repo);

    await tester.drag(find.text('Pikachu'), const Offset(-500, 0));
    await settle(tester);
    await settle(tester);

    expect(find.text('Todavía no guardas ningún Pokémon'), findsOneWidget);
    await tester.tap(find.text('Ir a la Pokédex'));
    await settle(tester);
    expect(container.read(homeTabProvider), NavTab.pokedex.index);
    await unmount(tester);
  });

  testWidgets('sin favoritos desde el principio muestra el estado vacío', (
    tester,
  ) async {
    await _openFavorites(tester, _repository(withFavorites: false));
    expect(find.text('Todavía no guardas ningún Pokémon'), findsOneWidget);
    expect(find.text('Ir a la Pokédex'), findsOneWidget);
    await unmount(tester);
  });
}
