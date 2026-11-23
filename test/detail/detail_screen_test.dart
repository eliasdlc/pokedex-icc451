import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/core/media/media_cache.dart';
import 'package:pokedex/features/pokedex/presentation/detail/cry_player.dart';
import 'package:pokedex/features/pokedex/presentation/detail/detail_providers.dart';
import 'package:pokedex/features/pokedex/presentation/detail/detail_screen.dart';

import 'detail_fixtures.dart';

class FakeCryPlayer implements CryPlayer {
  final played = <File>[];

  @override
  Future<void> play(File file) async => played.add(file);

  @override
  Future<void> dispose() async {}
}

class FakeSettings extends SettingsController {
  FakeSettings(this._settings);
  final AppSettings _settings;

  @override
  Future<AppSettings> build() async => _settings;
}

void main() {
  final cryFile = File('/tmp/no-existe/1.ogg');

  Future<FakeCryPlayer> openDetail(
    WidgetTester tester, {
    bool cryOnOpen = true,
    bool reduceMotion = false,
    bool systemReduce = false,
    bool hasCry = true,
    Brightness brightness = Brightness.light,
    bool favorite = false,
  }) async {
    final player = FakeCryPlayer();
    phoneScreen(tester);
    await tester.pumpWidget(
      host(
        brightness,
        const DetailScreen(pokemonId: 1),
        disableAnimations: systemReduce,
        overrides: [
          detailProvider(
            1,
          ).overrideWith((ref) => Stream.value(bulbasaur(favorite: favorite))),
          settingsProvider.overrideWith(
            () => FakeSettings(
              AppSettings(cryOnOpen: cryOnOpen, reduceMotion: reduceMotion),
            ),
          ),
          mediaFileProvider.overrideWith(
            (ref, req) async =>
                req.kind == MediaKind.cries && hasCry ? cryFile : null,
          ),
          cryPlayerProvider.overrideWithValue(player),
        ],
      ),
    );
    // El hero oscila sin fin: se avanza por tiempo, no con pumpAndSettle.
    for (var i = 0; i < 4; i++) {
      await tester.pump(const Duration(milliseconds: 200));
    }
    return player;
  }

  Future<void> close(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
  }

  group('grito al abrir', () {
    testWidgets('suena una vez al abrir si está activado', (tester) async {
      final player = await openDetail(tester);
      expect(player.played, [cryFile]);
      await close(tester);
    });

    testWidgets('no suena si el ajuste está apagado', (tester) async {
      final player = await openDetail(tester, cryOnOpen: false);
      expect(player.played, isEmpty);
      await close(tester);
    });

    testWidgets('no suena con movimiento reducido (ajuste o sistema)', (
      tester,
    ) async {
      var player = await openDetail(tester, reduceMotion: true);
      expect(player.played, isEmpty);
      await close(tester);
      player = await openDetail(tester, systemReduce: true);
      expect(player.played, isEmpty);
      await close(tester);
    });

    testWidgets('no vuelve a sonar al reconstruir ni al cambiar de pestaña', (
      tester,
    ) async {
      final player = await openDetail(tester);
      await tester.tap(find.text('Estadísticas'));
      await tester.pump(const Duration(milliseconds: 300));
      await tester.tap(find.text('Sobre'));
      await tester.pump(const Duration(milliseconds: 300));
      await tester.tap(find.text('Movimientos'));
      await tester.pump(const Duration(milliseconds: 300));
      expect(player.played, hasLength(1));
      await close(tester);
    });

    testWidgets('el altavoz lo repite', (tester) async {
      final player = await openDetail(tester);
      await tester.tap(find.bySemanticsLabel('Escuchar el grito'));
      await tester.pump(const Duration(milliseconds: 100));
      expect(player.played, hasLength(2));
      await close(tester);
    });

    testWidgets('sin archivo de grito no suena y el altavoz queda apagado', (
      tester,
    ) async {
      final player = await openDetail(tester, hasCry: false);
      expect(player.played, isEmpty);
      expect(find.bySemanticsLabel('Grito no disponible'), findsOneWidget);
      await tester.tap(find.bySemanticsLabel('Grito no disponible'));
      await tester.pump(const Duration(milliseconds: 100));
      expect(player.played, isEmpty);
      await close(tester);
    });
  });

  group('cabecera y pestañas', () {
    for (final b in Brightness.values) {
      testWidgets('muestra nombre, número, japonés y tipos (${b.name})', (
        tester,
      ) async {
        await openDetail(tester, brightness: b);
        expect(find.text('Bulbasaur'), findsOneWidget);
        expect(find.text('Nº 0001'), findsOneWidget);
        expect(find.text('フシギダネ'), findsOneWidget);
        expect(find.text('Planta'), findsOneWidget);
        expect(find.text('Veneno'), findsOneWidget);
        expect(find.textContaining('Espesura'), findsOneWidget);
        expect(find.textContaining('(oculta)'), findsOneWidget);
        expect(tester.takeException(), isNull);
        await close(tester);
      });
    }

    testWidgets('con nombre japonés vacío no dibuja la franja', (tester) async {
      phoneScreen(tester);
      await tester.pumpWidget(
        host(
          Brightness.light,
          const DetailScreen(pokemonId: 1),
          disableAnimations: true,
          overrides: [
            detailProvider(1)
                .overrideWith((ref) => Stream.value(bulbasaur(nameJa: null))),
            settingsProvider.overrideWith(
              () => FakeSettings(const AppSettings(cryOnOpen: false)),
            ),
            mediaFileProvider.overrideWith((ref, req) async => null),
            cryPlayerProvider.overrideWithValue(FakeCryPlayer()),
          ],
        ),
      );
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.text('フシギダネ'), findsNothing);
      await close(tester);
    });

    testWidgets('las cuatro pestañas cambian el contenido', (tester) async {
      await openDetail(tester);
      await tester.tap(find.text('Estadísticas'));
      await tester.pump(const Duration(milliseconds: 700));
      expect(find.text('Estadísticas base'), findsOneWidget);
      expect(find.text('Total'), findsOneWidget);
      // 45 + 49 + 49 + 65 + 65 + 45 = 318 de 1530 = 21 %.
      expect(find.text('318'), findsOneWidget);
      expect(find.text('21 %'), findsOneWidget);

      await tester.tap(find.text('Evoluciones'));
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.textContaining('×2'), findsWidgets);
      expect(find.text('No evoluciona'), findsOneWidget);

      await tester.tap(find.text('Movimientos'));
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Tackle'), findsOneWidget);
      expect(find.text('Tamaño'), findsOneWidget);
      await close(tester);
    });
  });

  group('arte por generación', () {
    bool isActive(WidgetTester tester, String label) {
      final box = tester.widget<Container>(
        find
            .ancestor(of: find.text(label), matching: find.byType(Container))
            .first,
      );
      return (box.decoration as BoxDecoration?)?.color == Colors.white;
    }

    testWidgets('la Gen 1 abre en Pixel', (tester) async {
      await openDetail(tester);
      expect(isActive(tester, 'Pixel'), isTrue);
      expect(isActive(tester, '3D'), isFalse);
      await tester.tap(find.text('Ilustración'));
      await tester.pump(const Duration(milliseconds: 300));
      expect(isActive(tester, 'Ilustración'), isTrue);
      await close(tester);
    });

    testWidgets('Pixel no existe pasado el 649: la nota lo dice', (
      tester,
    ) async {
      phoneScreen(tester);
      await tester.pumpWidget(
        host(
          Brightness.light,
          const DetailScreen(pokemonId: 700),
          disableAnimations: true,
          overrides: [
            detailProvider(700).overrideWith(
              (ref) => Stream.value(bulbasaur(id: 700, generationId: 6)),
            ),
            settingsProvider.overrideWith(
              () => FakeSettings(const AppSettings(cryOnOpen: false)),
            ),
            mediaFileProvider.overrideWith((ref, req) async => null),
            cryPlayerProvider.overrideWithValue(FakeCryPlayer()),
          ],
        ),
      );
      await tester.pump(const Duration(milliseconds: 200));
      expect(isActive(tester, '3D'), isTrue);
      expect(find.textContaining('No hay'), findsNothing);
      await tester.tap(find.text('Pixel'));
      await tester.pump(const Duration(milliseconds: 300));
      expect(
        find.text('No hay Pixel para este Pokémon: se muestra Ilustración.'),
        findsOneWidget,
      );
      await close(tester);
    });
  });
}
