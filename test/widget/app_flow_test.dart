import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/app.dart';
import 'package:pokedex/core/connectivity/connectivity_state.dart';
import 'package:pokedex/features/pokedex/data/local/pokedex_local_data_source.dart';
import 'package:pokedex/features/pokedex/data/sync/sync_engine.dart';
import 'package:pokedex/shared/widgets/pokedex_key.dart';

import '../support/fakes.dart';
import '../support/test_app.dart';

/// Offline first: la base se siembra con una sincronización real y la app abre sin servicio.
void main() {
  testWidgets(
    'sin conexión: onboarding, catálogo local, búsqueda, indicador y ficha',
    (tester) async {
      tester.platformDispatcher.localesTestValue = const [Locale('es')];
      addTearDown(tester.platformDispatcher.clearLocalesTestValue);
      final env = testOverrides(
        total: 30,
        availability: ServiceAvailability.offline,
      );

      await tester.runAsync(() async {
        final seeder = SyncEngine(
          remote: env.remote,
          local: PokedexLocalDataSource(env.db),
          connectivity: FakeConnectivity(ServiceAvailability.online),
          images: FakeImages(),
          sleep: (_) async {},
        );
        await seeder.refresh();
        await seeder.dispose();
        // Poke 12 vive en Catálogo y Favoritos a la vez (IndexedStack): duplicaba la etiqueta del Hero.
        await PokedexLocalDataSource(env.db).toggleFavorite(12);
      });

      Future<void> settle() async {
        for (var i = 0; i < 6; i++) {
          await tester.runAsync(
            () => Future<void>.delayed(const Duration(milliseconds: 60)),
          );
          await tester.pump(const Duration(milliseconds: 50));
        }
      }

      await tester.pumpWidget(
        ProviderScope(overrides: env.overrides, child: const PokedexApp()),
      );
      await settle();
      expect(find.text('Todos los Pokémon en un solo lugar'), findsOneWidget);

      for (var i = 0; i < 3; i++) {
        await tester.tap(find.byType(PokedexKey));
        await tester.pump(const Duration(milliseconds: 400));
        await tester.pump(const Duration(milliseconds: 400));
      }
      await settle();

      // La cabecera dice el estado primero y después el conteo guardado.
      expect(find.textContaining('Sin conexión'), findsOneWidget);
      expect(find.text('Poke 1'), findsOneWidget);
      expect(find.text('30 Pokémon'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'poke 12');
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('30 Pokémon'), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 400));
      await settle();
      expect(find.text('1 Pokémon'), findsOneWidget);
      expect(find.text('Poke 12'), findsOneWidget);

      await tester.tap(find.text('Poke 12'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await settle();
      expect(tester.takeException(), isNull);
      expect(find.text('Nº 0012'), findsOneWidget);
      expect(find.text('Estadísticas'), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await settle();
    },
  );
}
