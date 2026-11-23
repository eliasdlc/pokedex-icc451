import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/app/onboarding_screen.dart';
import 'package:pokedex/shared/widgets/pokedex_key.dart';

import '../support/phone_host.dart';
import '../support/test_app.dart';

void main() {
  setUpAll(loadAppFonts);

  for (final brightness in Brightness.values) {
    testWidgets('tres páginas, un botón y Saltar solo antes de la última '
        '(${brightness.name})', (tester) async {
      usePhoneSurface(tester);
      final env = testOverrides();
      await tester.pumpWidget(
        phoneHost(
          const OnboardingScreen(),
          brightness: brightness,
          overrides: env.overrides,
        ),
      );
      await settle(tester);

      expect(find.text('Todos los Pokémon en un solo lugar'), findsOneWidget);
      expect(find.byType(PokedexKey), findsOneWidget);
      expect(find.text('Continuar'), findsOneWidget);
      expect(find.text('Saltar'), findsOneWidget);

      await tester.tap(find.text('Continuar'));
      await settle(tester);
      expect(find.text('Saltar'), findsOneWidget);
      await tester.tap(find.text('Continuar'));
      await settle(tester);

      expect(find.text('¿Listo para la aventura?'), findsOneWidget);
      expect(find.text('Empezar'), findsOneWidget);
      final skip = find.ancestor(
        of: find.text('Saltar'),
        matching: find.byType(Visibility),
      );
      expect(tester.widget<Visibility>(skip.first).visible, isFalse);
      await unmount(tester);
    });
  }

  testWidgets('Saltar en la primera página termina la bienvenida', (
    tester,
  ) async {
    usePhoneSurface(tester);
    final env = testOverrides();
    await tester.pumpWidget(
      phoneHost(const OnboardingScreen(), overrides: env.overrides),
    );
    await settle(tester);

    final container = ProviderScope.containerOf(
      tester.element(find.byType(OnboardingScreen)),
    );
    expect((await container.read(settingsProvider.future)).onboarded, isFalse);

    await tester.tap(find.text('Saltar'));
    await settle(tester);
    expect((await container.read(settingsProvider.future)).onboarded, isTrue);
    await unmount(tester);
  });
}
