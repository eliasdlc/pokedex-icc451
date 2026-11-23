import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/home_shell.dart';
import 'package:pokedex/app/theme/type_palette.dart';
import 'package:pokedex/core/connectivity/connectivity_state.dart';
import 'package:pokedex/features/pokedex/domain/entities/catalog_query.dart';
import 'package:pokedex/features/pokedex/presentation/catalog/catalog_header.dart';
import 'package:pokedex/features/pokedex/presentation/widgets/pokemon_list_card.dart';
import 'package:pokedex/shared/widgets/pokemon_image.dart';

import '../support/fake_pokedex.dart';
import '../support/phone_host.dart';

final _water = fakeTypes[0];
final _electric = fakeTypes[1];
final _grass = fakeTypes[3];

FakePokedexRepository _repository() => FakePokedexRepository([
  fakePokemon(1, 'Bulbasaur', [_grass]),
  fakePokemon(25, 'Pikachu', [_electric], isFavorite: true),
  fakePokemon(7, 'Squirtle', [_water]),
  fakePokemon(152, 'Chikorita', [_grass], generationId: 2),
]);

Future<void> _pumpShell(
  WidgetTester tester,
  FakePokedexRepository repository, {
  SyncState sync = const SyncState(localCount: 4, remoteTotal: 4),
  ServiceAvailability availability = ServiceAvailability.online,
}) async {
  usePhoneSurface(tester);
  await tester.pumpWidget(
    phoneHost(
      const HomeShell(),
      overrides: fakePokedexOverrides(
        repository,
        sync: sync,
        availability: availability,
      ),
    ),
  );
  await settle(tester);
}

Finder _inSheet(String text) =>
    find.descendant(of: find.byType(BottomSheet), matching: find.text(text));

void main() {
  setUpAll(loadAppFonts);

  for (final brightness in Brightness.values) {
    group('tarjeta de lista (${brightness.name})', () {
      testWidgets('el sprite es grande y asoma por encima del panel', (
        tester,
      ) async {
        usePhoneSurface(tester);
        await tester.pumpWidget(
          phoneHost(
            brightness: brightness,
            Scaffold(
              body: Center(
                child: PokemonListCard(
                  pokemon: fakePokemon(25, 'Pikachu', [_electric]),
                  onTap: () {},
                ),
              ),
            ),
          ),
        );
        final card = tester.getRect(find.byType(PokemonListCard));
        final sprite = tester.getRect(find.byType(PokemonImage));
        final panelTop = card.top + 16;
        expect(sprite.width, greaterThanOrEqualTo(128));
        expect(sprite.width, lessThanOrEqualTo(160));
        expect(sprite.top, lessThan(card.top));
        expect(sprite.top, lessThan(panelTop));
        // Factor entero sobre los 96 px de origen.
        expect(
          sprite.width * 2 / 96,
          closeTo((sprite.width * 2 / 96).roundToDouble(), 1e-9),
        );
        expect(
          tester.widget<PokemonImage>(find.byType(PokemonImage)).pixelArt,
          isTrue,
        );
      });

      testWidgets('tinta oscura en tipos claros, blanca en el resto', (
        tester,
      ) async {
        var taps = 0;
        await tester.pumpWidget(
          phoneHost(
            brightness: brightness,
            Scaffold(
              body: Column(
                children: [
                  PokemonListCard(
                    pokemon: fakePokemon(25, 'Pikachu', [_electric]),
                    onTap: () => taps++,
                  ),
                  PokemonListCard(
                    pokemon: fakePokemon(1, 'Bulbasaur', [
                      _grass,
                    ], isFavorite: true),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        );

        Color nameColor(String name) =>
            tester.widget<Text>(find.text(name)).style!.color!;
        expect(nameColor('Pikachu'), onType('electric'));
        expect(nameColor('Bulbasaur'), onType('grass'));
        expect(find.text('Nº 025'), findsOneWidget);
        expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);

        await tester.tap(find.text('Pikachu'));
        expect(taps, 1);
        expect(tester.takeException(), isNull);
      });
    });
  }

  group('catálogo', () {
    testWidgets('título, buscador y las dos píldoras de filtro', (
      tester,
    ) async {
      await _pumpShell(tester, _repository());
      expect(find.text('Todos los tipos'), findsOneWidget);
      expect(find.text('Menor número'), findsOneWidget);
      expect(find.text('Bulbasaur'), findsOneWidget);
      expect(find.text('4 Pokémon'), findsOneWidget);
      await unmount(tester);
    });

    testWidgets('hoja de tipo: elegir, aplicar y limpiar', (tester) async {
      final repo = _repository();
      await _pumpShell(tester, repo);

      await tester.tap(find.text('Todos los tipos'));
      await settle(tester);
      expect(find.text('Selecciona el tipo'), findsOneWidget);
      await tester.tap(_inSheet('Eléctrico'));
      await settle(tester);
      expect(find.text('Bulbasaur'), findsOneWidget);

      await tester.tap(find.text('Aplicar filtro'));
      await settle(tester);
      expect(find.text('Bulbasaur'), findsNothing);
      expect(find.text('Pikachu'), findsOneWidget);
      final pill = find.descendant(
        of: find.byType(FilterPill),
        matching: find.text('Eléctrico'),
      );
      expect(pill, findsOneWidget);
      expect(repo.saved.typeIds, {_electric.id});

      await tester.tap(pill);
      await settle(tester);
      await tester.tap(find.text('Limpiar'));
      await settle(tester);
      await tester.tap(find.text('Aplicar filtro'));
      await settle(tester);
      expect(repo.saved.typeIds, isEmpty);
      expect(find.text('Bulbasaur'), findsOneWidget);
      await unmount(tester);
    });

    testWidgets('hoja de orden: Z-A, generación, región y el conteo', (
      tester,
    ) async {
      final repo = _repository();
      await _pumpShell(
        tester,
        repo,
        sync: const SyncState(localCount: 4, remoteTotal: 1025),
      );

      await tester.tap(find.text('Menor número'));
      await settle(tester);
      expect(find.text('Ordenar por'), findsOneWidget);
      expect(
        find.textContaining('hay 4 de 1025 guardados', skipOffstage: false),
        findsOneWidget,
      );
      expect(find.text('Ver 4 Pokémon'), findsOneWidget);

      await tester.tap(_inSheet('Z-A'));
      await tester.tap(_inSheet('Johto'));
      await settle(tester);
      expect(find.text('Ver 1 Pokémon'), findsOneWidget);
      expect(repo.saved, const CatalogQuery());

      await tester.tap(find.text('Ver 1 Pokémon'));
      await settle(tester);
      expect(repo.saved.sort, CatalogSort.name);
      expect(repo.saved.ascending, isFalse);
      expect(repo.saved.generationId, 2);
      expect(find.text('Chikorita'), findsOneWidget);
      expect(find.text('Z-A'), findsOneWidget);
      await unmount(tester);
    });

    testWidgets('la búsqueda espera al debounce', (tester) async {
      final repo = _repository();
      await _pumpShell(tester, repo);
      await tester.enterText(find.byType(TextField), 'pika');
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Bulbasaur'), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 400));
      await settle(tester);
      expect(find.text('Bulbasaur'), findsNothing);
      expect(find.text('Pikachu'), findsOneWidget);
      await unmount(tester);
    });

    testWidgets('sin datos y sin conexión: dos acciones y controles apagados', (
      tester,
    ) async {
      final sync = FakeSyncService();
      usePhoneSurface(tester);
      await tester.pumpWidget(
        phoneHost(
          const HomeShell(),
          overrides: fakePokedexOverrides(
            FakePokedexRepository([]),
            sync: const SyncState(),
            availability: ServiceAvailability.offline,
            syncService: sync,
          ),
        ),
      );
      await settle(tester);

      expect(find.text('Tu Pokédex todavía está vacía'), findsOneWidget);
      expect(find.text('Revisar mi conexión'), findsOneWidget);
      expect(tester.widget<TextField>(find.byType(TextField)).enabled, isFalse);
      await tester.tap(find.text('Reintentar'));
      expect(sync.refreshes, 1);
      await unmount(tester);
    });

    testWidgets('PokéAPI no responde: tarjeta de aviso con la lista guardada', (
      tester,
    ) async {
      final sync = FakeSyncService();
      usePhoneSurface(tester);
      await tester.pumpWidget(
        phoneHost(
          const HomeShell(),
          overrides: fakePokedexOverrides(
            _repository(),
            availability: ServiceAvailability.serviceUnavailable,
            syncService: sync,
          ),
        ),
      );
      await settle(tester);

      expect(find.text('PokéAPI no está respondiendo'), findsOneWidget);
      expect(find.text('Bulbasaur'), findsOneWidget);
      await tester.tap(find.text('Reintentar ahora'));
      expect(sync.refreshes, 1);
      await unmount(tester);
    });
  });
}
