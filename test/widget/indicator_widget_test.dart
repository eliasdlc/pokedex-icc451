import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/app/theme/app_theme.dart';
import 'package:pokedex/core/connectivity/connectivity_state.dart';
import 'package:pokedex/l10n/gen/app_localizations.dart';
import 'package:pokedex/shared/widgets/pokedex_header.dart';

Widget _host(IndicatorView view, {Locale locale = const Locale('es')}) =>
    ProviderScope(
      overrides: [indicatorProvider.overrideWithValue(view)],
      child: MaterialApp(
        theme: buildTheme(Brightness.dark),
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(appBar: PokedexHeader(title: 'Pokédex')),
      ),
    );

IndicatorView _view(IndicatorStatus status) => IndicatorView(
  status: status,
  origin: status == IndicatorStatus.online
      ? DataOrigin.liveAndLocal
      : DataOrigin.localOnly,
  lastSyncedAt: null,
  isPartial: false,
  localCount: 10,
  remoteTotal: 1025,
);

void main() {
  final cases = {
    IndicatorStatus.online: 'En línea',
    IndicatorStatus.offline: 'Sin conexión',
    IndicatorStatus.serviceUnavailable: 'Servicio no disponible',
    IndicatorStatus.syncing: 'Sincronizando',
  };

  for (final MapEntry(key: status, value: label) in cases.entries) {
    testWidgets(
      'las luces llevan texto en la pantalla, no solo color: $label',
      (tester) async {
        await tester.pumpWidget(_host(_view(status)));
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.text(label), findsOneWidget);
        expect(
          find.bySemanticsLabel(RegExp('Estado de conexión: $label')),
          findsOneWidget,
        );
      },
    );
  }

  testWidgets('en inglés', (tester) async {
    await tester.pumpWidget(
      _host(
        _view(IndicatorStatus.serviceUnavailable),
        locale: const Locale('en'),
      ),
    );
    await tester.pump();
    expect(find.text('Service unavailable'), findsOneWidget);
  });
}
