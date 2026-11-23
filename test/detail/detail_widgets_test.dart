import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/app/theme/type_palette.dart';
import 'package:pokedex/features/pokedex/domain/entities/art_sources.dart';
import 'package:pokedex/features/pokedex/presentation/detail/art_mode_switch.dart';
import 'package:pokedex/features/pokedex/presentation/detail/detail_tabs.dart';
import 'package:pokedex/features/pokedex/presentation/detail/share_card.dart';
import 'package:pokedex/features/pokedex/presentation/widgets/collectible_card.dart';

import 'detail_fixtures.dart';

void both(String name, Future<void> Function(WidgetTester, Brightness) body) {
  for (final b in Brightness.values) {
    testWidgets('$name (${b.name})', (tester) => body(tester, b));
  }
}

void main() {
  final noArt = mediaFileProvider.overrideWith((ref, req) async => null);

  group('DetailTabs', () {
    both('cambia de pestaña y cada una mide 48 de alto', (tester, b) async {
      phoneScreen(tester);
      var current = DetailTab.about;
      await tester.pumpWidget(
        host(
          b,
          Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) => DetailTabs(
                current: current,
                onSelect: (t) => setState(() => current = t),
              ),
            ),
          ),
        ),
      );
      for (final label in [
        'Sobre',
        'Estadísticas',
        'Evoluciones',
        'Movimientos',
      ]) {
        expect(find.text(label), findsOneWidget);
      }
      expect(tester.getSize(find.byType(DetailTabs)).height, 48);
      await tester.tap(find.text('Evoluciones'));
      await tester.pump();
      expect(current, DetailTab.evolutions);
      await tester.tap(find.text('Movimientos'));
      await tester.pump();
      expect(current, DetailTab.moves);
    });
  });

  group('ArtModeSwitch', () {
    both('avisa cuando el modo pedido no existe', (tester, b) async {
      phoneScreen(tester);
      const sources = ArtSources(pokemonId: 700, generationId: 6);
      ArtMode? picked;
      await tester.pumpWidget(
        host(
          b,
          Scaffold(
            body: Center(
              child: ArtModeSwitch(
                selection: sources.select(ArtMode.pixel),
                available: {
                  for (final m in ArtMode.values)
                    if (sources.has(m)) m,
                },
                onSelect: (m) => picked = m,
                inactiveInk: inkOn(typeColor('grass')),
              ),
            ),
          ),
        ),
      );
      expect(find.textContaining('No hay Pixel'), findsOneWidget);
      await tester.tap(find.text('3D'));
      expect(picked, ArtMode.model3d);
    });

    test('la tinta inactiva es blanca en tipos oscuros y oscura en claros', () {
      for (final slug in ['dark', 'dragon', 'ghost', 'fighting']) {
        expect(inkOn(typeColor(slug)), Colors.white, reason: slug);
      }
      for (final slug in [
        'electric',
        'ice',
        'rock',
        'fairy',
        'normal',
        'grass',
        'water',
      ]) {
        expect(inkOn(typeColor(slug)), isNot(Colors.white), reason: slug);
      }
    });
  });

  group('CollectibleCard', () {
    both('imprime PS, ataques con daño, debilidad y retirada', (
      tester,
      b,
    ) async {
      phoneScreen(tester);
      await tester.pumpWidget(
        host(
          b,
          Scaffold(
            body: Center(
              child: CollectibleCard(detail: bulbasaur(weightKg: 85)),
            ),
          ),
          overrides: [noArt],
          disableAnimations: true,
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Bulbasaur'), findsOneWidget);
      expect(find.text('45'), findsOneWidget);
      expect(find.text('BÁSICO'), findsOneWidget);
      // Vine Whip 45 -> 50; Tackle 40 queda fuera: no es de su tipo.
      expect(find.text('Vine Whip'), findsOneWidget);
      expect(find.text('50'), findsOneWidget);
      expect(find.text('×2'), findsOneWidget);
      expect(find.text('001/1025'), findsOneWidget);
      final size = tester.getSize(find.byType(CollectibleCard));
      expect(size.width / size.height, closeTo(63 / 88, 0.001));
      expect(
        find.descendant(
          of: find.byType(CollectibleCard),
          matching: find.byType(ShaderMask),
        ),
        findsNothing,
      );
    });

    testWidgets('la legendaria lleva brillo holográfico', (tester) async {
      phoneScreen(tester);
      await tester.pumpWidget(
        host(
          Brightness.light,
          Scaffold(
            body: Center(
              child: CollectibleCard(detail: bulbasaur(legendary: true)),
            ),
          ),
          overrides: [noArt],
          disableAnimations: true,
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(
        find.descendant(
          of: find.byType(CollectibleCard),
          matching: find.byType(ShaderMask),
        ),
        findsOneWidget,
      );
    });

    testWidgets('sin movimientos guardados no inventa ataques', (tester) async {
      phoneScreen(tester);
      await tester.pumpWidget(
        host(
          Brightness.light,
          Scaffold(
            body: Center(
              child: CollectibleCard(detail: bulbasaur(moves: [])),
            ),
          ),
          overrides: [noArt],
          disableAnimations: true,
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Sin movimientos descargados'), findsOneWidget);
    });
  });

  group('ShareCardScreen', () {
    both('muestra la carta, el selector y las dos acciones', (tester, b) async {
      phoneScreen(tester);
      await tester.pumpWidget(
        host(
          b,
          ShareCardScreen(detail: bulbasaur()),
          overrides: [noArt],
          disableAnimations: true,
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Tu carta'), findsOneWidget);
      expect(find.byType(CollectibleCard), findsOneWidget);
      expect(find.text('Compartir como imagen'), findsOneWidget);
      expect(find.text('Guardar imagen'), findsOneWidget);
      await tester.tap(find.text('Variocolor'));
      await tester.pump();
      expect(tester.takeException(), isNull);
    });

    testWidgets('sin ilustración variocolor no ofrece el selector', (
      tester,
    ) async {
      phoneScreen(tester);
      await tester.pumpWidget(
        host(
          Brightness.light,
          ShareCardScreen(detail: bulbasaur(shinyUrl: null)),
          overrides: [noArt],
          disableAnimations: true,
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Variocolor'), findsNothing);
    });
  });
}
