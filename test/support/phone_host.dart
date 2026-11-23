import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/theme/app_theme.dart';
import 'package:pokedex/l10n/gen/app_localizations.dart';

/// Sin Poppins y Tiny5 la fuente de bloques desborda las píldoras.
Future<void> loadAppFonts() async {
  const families = {
    'Poppins': [
      'Poppins-Regular.ttf',
      'Poppins-Medium.ttf',
      'Poppins-SemiBold.ttf',
      'Poppins-Bold.ttf',
    ],
    'Tiny5': ['Tiny5-Regular.ttf'],
  };
  for (final MapEntry(key: family, value: files) in families.entries) {
    final loader = FontLoader(family);
    for (final file in files) {
      loader.addFont(rootBundle.load('assets/fonts/$file'));
    }
    await loader.load();
  }
}

/// 393 x 852 con barra de estado e indicador de inicio, el tamaño del diseño.
void usePhoneSurface(WidgetTester tester) {
  tester.view
    ..physicalSize = const Size(393 * 2, 852 * 2)
    ..devicePixelRatio = 2
    ..padding = const FakeViewPadding(top: 47 * 2, bottom: 34 * 2)
    ..viewPadding = const FakeViewPadding(top: 47 * 2, bottom: 34 * 2);
  addTearDown(tester.view.reset);
}

Widget phoneHost(
  Widget home, {
  Brightness brightness = Brightness.light,
  List<Override> overrides = const [],
}) => ProviderScope(
  overrides: overrides,
  child: MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: buildTheme(brightness),
    locale: const Locale('es'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  ),
);

Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 6; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 30)),
    );
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Espera a que Drift cierre sus consultas: sin eso queda un temporizador pendiente.
Future<void> unmount(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox());
  await settle(tester);
}
