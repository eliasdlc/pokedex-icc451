import 'dart:ui' show Tristate;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/app/theme/app_theme.dart';
import 'package:pokedex/app/theme/app_tokens.dart';
import 'package:pokedex/app/theme/type_palette.dart';
import 'package:pokedex/core/connectivity/connectivity_state.dart';
import 'package:pokedex/features/pokedex/domain/entities/poke_type.dart';
import 'package:pokedex/l10n/gen/app_localizations.dart';
import 'package:pokedex/shared/widgets/game_dialog_box.dart';
import 'package:pokedex/shared/widgets/game_window.dart';
import 'package:pokedex/shared/widgets/pixel_icon.dart';
import 'package:pokedex/shared/widgets/pokeball_navbar.dart';
import 'package:pokedex/shared/widgets/pokedex_header.dart';
import 'package:pokedex/shared/widgets/pokedex_key.dart';
import 'package:pokedex/shared/widgets/pokedex_switch.dart';
import 'package:pokedex/shared/widgets/pokemon_image.dart';
import 'package:pokedex/shared/widgets/state_message.dart';
import 'package:pokedex/shared/widgets/type_chip.dart';

Widget _host(
  Brightness brightness,
  Widget child, {
  Widget? bottom,
  PreferredSizeWidget? top,
  IndicatorStatus status = IndicatorStatus.online,
}) => ProviderScope(
  overrides: [
    indicatorProvider.overrideWithValue(
      IndicatorView(
        status: status,
        origin: DataOrigin.liveAndLocal,
        lastSyncedAt: null,
        isPartial: false,
        localCount: 10,
        remoteTotal: 1025,
      ),
    ),
  ],
  child: MaterialApp(
    theme: buildTheme(brightness),
    locale: const Locale('es'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      appBar: top,
      body: Center(child: child),
      bottomNavigationBar: bottom,
    ),
  ),
);

void _both(String name, Future<void> Function(WidgetTester, Brightness) body) {
  for (final b in Brightness.values) {
    testWidgets('$name (${b.name})', (tester) => body(tester, b));
  }
}

const _fire = PokeType(id: 10, slug: 'fire', nameEs: 'Fuego', nameEn: 'Fire');

void main() {
  group('GameWindow', () {
    _both('pinta el marco y el filete con los tokens del tema', (
      tester,
      b,
    ) async {
      await tester.pumpWidget(
        _host(b, const GameWindow(child: SizedBox(width: 100, height: 40))),
      );
      final tokens = b == Brightness.dark ? AppTokens.dark : AppTokens.light;
      final borders = tester
          .widgetList<DecoratedBox>(
            find.descendant(
              of: find.byType(GameWindow),
              matching: find.byType(DecoratedBox),
            ),
          )
          .map((d) => d.decoration)
          .whereType<BoxDecoration>()
          .map((d) => d.border)
          .whereType<Border>()
          .map((border) => border.top.color)
          .toList();
      expect(borders, containsAll([tokens.marco, tokens.marco2]));
    });
  });

  group('GameDialogBox', () {
    _both('muestra el texto con la fuente Tiny5', (tester, b) async {
      await tester.pumpWidget(
        _host(b, const GameDialogBox(text: '¿Qué hará Charizard?')),
      );
      final text = tester.widget<Text>(find.text('¿Qué hará Charizard?'));
      expect(text.style?.fontFamily, 'Tiny5');
      expect(text.style?.shadows?.single.blurRadius, 0);
    });

    testWidgets('con onContinue es un botón y responde al toque', (
      tester,
    ) async {
      var taps = 0;
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _host(
          Brightness.light,
          GameDialogBox(text: 'Hola', onContinue: () => taps++),
        ),
      );
      await tester.tap(find.text('Hola'));
      expect(taps, 1);
      final node = tester.getSemantics(find.byType(GameDialogBox));
      expect(node.label, 'Hola');
      expect(node.hint, 'Continuar');
      handle.dispose();
    });
  });

  group('PixelIcon', () {
    _both('usa la escala entera, sin suavizado, para cada icono', (
      tester,
      b,
    ) async {
      await tester.pumpWidget(
        _host(
          b,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final kind in PixelIconKind.values)
                PixelIcon(kind: kind, scale: 3),
            ],
          ),
        ),
      );
      final images = tester.widgetList<Image>(find.byType(Image)).toList();
      expect(images, hasLength(5));
      for (final image in images) {
        expect(image.filterQuality, FilterQuality.none);
        expect(image.width, 48);
        expect(image.height, 48);
      }
    });

    testWidgets('activo usa el PNG en color; inactivo, el gris', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(
          Brightness.light,
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PixelIcon(kind: PixelIconKind.play),
              PixelIcon(kind: PixelIconKind.play, active: false),
            ],
          ),
        ),
      );
      final names = tester
          .widgetList<Image>(find.byType(Image))
          .map((i) => (i.image as AssetImage).assetName)
          .toList();
      expect(names, [
        'assets/icons/play_color.png',
        'assets/icons/play_gray.png',
      ]);
    });
  });

  group('PokeballNavbar', () {
    const labels = ['Pokédex', 'Regiones', 'Jugar', 'Favoritos', 'Perfil'];

    _both('solo íconos: cada destino se anuncia y tiene tooltip', (
      tester,
      b,
    ) async {
      final selected = <NavTab>[];
      await tester.pumpWidget(
        _host(
          b,
          const SizedBox(),
          bottom: PokeballNavbar(
            current: NavTab.favorites,
            onSelect: selected.add,
          ),
        ),
      );
      final handle = tester.ensureSemantics();
      for (final label in labels) {
        expect(find.bySemanticsLabel(label), findsOneWidget, reason: label);
        expect(find.byTooltip(label), findsOneWidget, reason: label);
        expect(find.text(label), findsNothing, reason: label);
      }
      await tester.tap(find.byTooltip('Perfil'));
      await tester.tap(find.byTooltip('Jugar'));
      expect(selected, [NavTab.profile, NavTab.play]);
      handle.dispose();
    });

    testWidgets('solo la pestaña activa queda seleccionada', (tester) async {
      for (final current in NavTab.values) {
        await tester.pumpWidget(
          _host(
            Brightness.light,
            const SizedBox(),
            bottom: PokeballNavbar(current: current, onSelect: (_) {}),
          ),
        );
        final handle = tester.ensureSemantics();
        for (final (i, label) in labels.indexed) {
          final node = tester.getSemantics(find.bySemanticsLabel(label));
          expect(
            node.flagsCollection.isSelected,
            i == current.index ? Tristate.isTrue : Tristate.isFalse,
            reason: '$label con ${current.name} activa',
          );
        }
        handle.dispose();
      }
    });

    testWidgets('cada objetivo táctil mide al menos 48x48', (tester) async {
      await tester.pumpWidget(
        _host(
          Brightness.light,
          const SizedBox(),
          bottom: PokeballNavbar(current: NavTab.pokedex, onSelect: (_) {}),
        ),
      );
      for (final label in labels) {
        final box = tester.getSize(find.byTooltip(label));
        expect(box.width, greaterThanOrEqualTo(48), reason: label);
        expect(box.height, greaterThanOrEqualTo(48), reason: label);
      }
    });
  });

  group('PokedexHeader', () {
    _both('completa: placa, LCD con título y estado, luces que se anuncian', (
      tester,
      b,
    ) async {
      await tester.pumpWidget(
        _host(b, const SizedBox(), top: const PokedexHeader(title: 'Pokédex')),
      );
      final handle = tester.ensureSemantics();
      expect(find.text('Pokédex'), findsOneWidget);
      expect(find.text('En línea'), findsOneWidget);
      expect(
        find.bySemanticsLabel(RegExp('Estado de conexión: En línea')),
        findsOneWidget,
      );
      expect(
        tester.getSize(find.byType(PokedexHeader)).height,
        PokedexHeader.height,
      );
      handle.dispose();
    });

    testWidgets('la línea 2 une el estado y el dato con una coma', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(
          Brightness.light,
          const SizedBox(),
          status: IndicatorStatus.offline,
          top: const PokedexHeader(title: 'Pokédex', detail: '10 de 1025'),
        ),
      );
      expect(find.text('Sin conexión, 10 de 1025'), findsOneWidget);
    });

    testWidgets('en línea, el estado va primero y el dato después', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(
          Brightness.light,
          const SizedBox(),
          top: const PokedexHeader(title: 'Pokédex', detail: '10 de 1025'),
        ),
      );
      expect(find.text('En línea, 10 de 1025'), findsOneWidget);
      expect(find.byIcon(Icons.wifi_rounded), findsOneWidget);
    });

    testWidgets('el lente es Atrás: se anuncia y vuelve', (tester) async {
      var backs = 0;
      await tester.pumpWidget(
        _host(
          Brightness.light,
          const SizedBox(),
          top: PokedexHeader(title: 'Detalle', onBack: () => backs++),
        ),
      );
      final back = MaterialLocalizations.of(
        tester.element(find.byType(PokedexHeader)),
      ).backButtonTooltip;
      await tester.tap(find.byTooltip(back));
      expect(backs, 1);
      expect(tester.getSize(find.byTooltip(back)), const Size(48, 48));
    });

    testWidgets('sin ruta anterior el lente no se anuncia como botón', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(
          Brightness.light,
          const SizedBox(),
          top: const PokedexHeader(title: 'Pokédex'),
        ),
      );
      final back = MaterialLocalizations.of(
        tester.element(find.byType(PokedexHeader)),
      ).backButtonTooltip;
      expect(find.byTooltip(back), findsNothing);
    });

    _both('flotante: lente y luces, sin título ni LCD', (tester, b) async {
      await tester.pumpWidget(
        _host(b, const SizedBox(), top: PokedexHeader.float(onBack: () {})),
      );
      final handle = tester.ensureSemantics();
      expect(find.text('En línea'), findsNothing);
      expect(
        find.bySemanticsLabel(RegExp('Estado de conexión: En línea')),
        findsOneWidget,
      );
      handle.dispose();
    });

    testWidgets('tecla de favorito: tooltip, estado seleccionado y 48', (
      tester,
    ) async {
      var taps = 0;
      await tester.pumpWidget(
        _host(
          Brightness.light,
          const SizedBox(),
          top: PokedexHeader(
            title: 'Pikachu',
            actions: [
              HeaderKey(
                icon: HeaderIcon.favorite,
                tooltip: 'Quitar de favoritos',
                active: true,
                onPressed: () => taps++,
              ),
            ],
          ),
        ),
      );
      final handle = tester.ensureSemantics();
      final key = find.byTooltip('Quitar de favoritos');
      expect(tester.getSize(key).height, greaterThanOrEqualTo(48));
      expect(
        tester
            .getSemantics(find.bySemanticsLabel('Quitar de favoritos'))
            .flagsCollection
            .isSelected,
        Tristate.isTrue,
      );
      await tester.tap(key);
      expect(taps, 1);
      handle.dispose();
    });
  });

  group('TypeChip y TypeIcon', () {
    _both('los 18 tipos pintan un chip con el nombre y el glifo', (
      tester,
      b,
    ) async {
      await tester.pumpWidget(
        _host(
          b,
          SingleChildScrollView(
            child: Column(
              children: [
                for (final (i, slug) in allTypeSlugs.indexed)
                  TypeChip(
                    PokeType(id: i, slug: slug, nameEs: slug, nameEn: slug),
                    compact: i.isEven,
                  ),
              ],
            ),
          ),
        ),
      );
      expect(find.byType(TypeIcon), findsNWidgets(18));
      for (final slug in allTypeSlugs) {
        expect(find.text(slug), findsOneWidget);
      }
    });

    test('onType: blanco solo en Dragón, Fantasma, Lucha y Siniestro', () {
      const blancos = {'dragon', 'ghost', 'fighting', 'dark'};
      for (final slug in allTypeSlugs) {
        final esperado = blancos.contains(slug)
            ? Colors.white
            : const Color(0xFF111118);
        expect(onType(slug), esperado, reason: slug);
      }
      expect(allTypeSlugs, hasLength(18));
    });

    testWidgets(
      'la variante de vidrio usa relleno translúcido, no desenfoque',
      (tester) async {
        await tester.pumpWidget(
          _host(
            Brightness.light,
            const TypeChip(_fire, compact: true, style: TypeChipStyle.glass),
          ),
        );
        expect(find.byType(BackdropFilter), findsNothing);
        final box = tester.widget<AnimatedContainer>(
          find.byType(AnimatedContainer),
        );
        final color = (box.decoration as BoxDecoration).color!;
        expect(color.a, lessThan(0.5));
      },
    );

    testWidgets('seleccionable: botón con estado seleccionado y 48 de alto', (
      tester,
    ) async {
      var taps = 0;
      await tester.pumpWidget(
        _host(
          Brightness.light,
          TypeChip(_fire, selected: true, onTap: () => taps++),
        ),
      );
      await tester.tap(find.text('Fuego'));
      expect(taps, 1);
      expect(find.byIcon(Icons.check_rounded), findsOneWidget);
      expect(
        tester.getSize(find.byType(InkWell)).height,
        greaterThanOrEqualTo(48),
      );
    });
  });

  group('PokedexKey', () {
    _both('tecla en Tiny5 con canto de 4 y 56 de alto en total', (
      tester,
      b,
    ) async {
      var taps = 0;
      await tester.pumpWidget(
        _host(b, PokedexKey(label: 'Continuar', onPressed: () => taps++)),
      );
      final text = tester.widget<Text>(find.text('Continuar'));
      expect(text.style?.fontFamily, 'Tiny5');
      expect(text.style?.fontSize, 18);
      expect(tester.getSize(find.byType(PokedexKey)).height, 56);
      await tester.tap(find.byType(PokedexKey));
      expect(taps, 1);
    });

    testWidgets('al presionarla baja hasta tapar el canto', (tester) async {
      await tester.pumpWidget(
        _host(
          Brightness.light,
          PokedexKey(label: 'Continuar', onPressed: () {}),
        ),
      );
      final cap = find.byType(AnimatedContainer);
      final rest = tester.getTopLeft(cap).dy;
      final gesture = await tester.startGesture(tester.getCenter(cap));
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.getTopLeft(cap).dy, rest + PokedexKey.depth);
      await gesture.up();
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.getTopLeft(cap).dy, rest);
    });

    testWidgets('sin onPressed se anuncia deshabilitada y no responde', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(
          Brightness.light,
          const PokedexKey(label: 'Reintentar', onPressed: null),
        ),
      );
      final handle = tester.ensureSemantics();
      final node = tester.getSemantics(find.bySemanticsLabel('Reintentar'));
      expect(node.flagsCollection.isButton, isTrue);
      expect(node.flagsCollection.isEnabled, Tristate.isFalse);
      handle.dispose();
    });
  });

  group('PokedexSwitch', () {
    _both('encendido: relleno de acento y la perilla a la derecha', (
      tester,
      b,
    ) async {
      await tester.pumpWidget(_host(b, const PokedexSwitch(value: true)));
      await tester.pumpAndSettle();
      final tokens = Theme.of(tester.element(find.byType(PokedexSwitch)))
          .extension<AppTokens>()!;
      final track = tester.widget<AnimatedContainer>(
        find.byType(AnimatedContainer),
      );
      expect((track.decoration! as BoxDecoration).color, tokens.ac);
      expect(
        tester.widget<AnimatedAlign>(find.byType(AnimatedAlign)).alignment,
        Alignment.centerRight,
      );
      expect(tester.getSize(find.byType(PokedexSwitch)), const Size(48, 48));
    });

    testWidgets('apagado: la perilla a la izquierda, sin semántica propia', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(Brightness.light, const PokedexSwitch(value: false)),
      );
      expect(
        tester.widget<AnimatedAlign>(find.byType(AnimatedAlign)).alignment,
        Alignment.centerLeft,
      );
      expect(
        find.descendant(
          of: find.byType(PokedexSwitch),
          matching: find.byType(ExcludeSemantics),
        ),
        findsOneWidget,
      );
    });
  });

  group('StateMessage', () {
    _both('muestra título, texto y una acción', (tester, b) async {
      var taps = 0;
      await tester.pumpWidget(
        _host(
          b,
          StateMessage(
            icon: Icons.cloud_off_rounded,
            title: 'Sin conexión',
            body: 'No hay datos guardados.',
            actionLabel: 'Reintentar',
            action: () => taps++,
          ),
        ),
      );
      expect(find.text('Sin conexión'), findsOneWidget);
      await tester.tap(find.text('Reintentar'));
      expect(taps, 1);
    });
  });

  group('PokemonImage', () {
    _both('pixelArt amplía sin suavizado y limita la decodificación', (
      tester,
      b,
    ) async {
      await tester.pumpWidget(
        _host(
          b,
          const PokemonImage(
            artworkFile: null,
            spriteFile: null,
            networkUrl: 'http://localhost/sprite.png',
            size: 96,
            pixelArt: true,
          ),
        ),
      );
      final image = tester.widget<Image>(find.byType(Image));
      expect(image.filterQuality, FilterQuality.none);
      expect(image.image, isA<ResizeImage>());
    });
  });
}
