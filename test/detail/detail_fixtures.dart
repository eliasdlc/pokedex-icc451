import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/app/theme/app_theme.dart';
import 'package:pokedex/core/connectivity/connectivity_state.dart';
import 'package:pokedex/features/pokedex/domain/entities/poke_type.dart';
import 'package:pokedex/features/pokedex/domain/entities/pokemon_detail.dart';
import 'package:pokedex/features/pokedex/domain/entities/pokemon_summary.dart';
import 'package:pokedex/features/pokedex/presentation/catalog/catalog_controller.dart';
import 'package:pokedex/l10n/gen/app_localizations.dart';

const grass = PokeType(
  id: 12,
  slug: 'grass',
  nameEs: 'Planta',
  nameEn: 'Grass',
);
const poison = PokeType(
  id: 4,
  slug: 'poison',
  nameEs: 'Veneno',
  nameEn: 'Poison',
);
const fire = PokeType(id: 10, slug: 'fire', nameEs: 'Fuego', nameEn: 'Fire');
const normal = PokeType(
  id: 1,
  slug: 'normal',
  nameEs: 'Normal',
  nameEn: 'Normal',
);

PokemonMove move(
  int id,
  String slug, {
  int? power,
  int typeId = 1,
  int versionGroupId = 1,
  MoveLearnMethod method = MoveLearnMethod.levelUp,
  int level = 1,
  DamageClass damageClass = DamageClass.physical,
}) => PokemonMove(
  id: id,
  slug: slug,
  versionGroupId: versionGroupId,
  method: method,
  level: level,
  power: power,
  accuracy: 100,
  pp: 20,
  typeId: typeId,
  damageClass: damageClass,
);

PokemonDetail bulbasaur({
  int id = 1,
  int generationId = 1,
  bool legendary = false,
  bool mythical = false,
  bool favorite = false,
  String? nameJa = 'フシギダネ',
  double weightKg = 6.9,
  List<PokemonMove>? moves,
  EvolutionNode? evolution,
  String? shinyUrl = 'https://img/shiny/1.png',
}) => PokemonDetail(
  summary: PokemonSummary(
    id: id,
    slug: 'bulbasaur',
    nameEs: 'Bulbasaur',
    nameEn: 'Bulbasaur',
    nameJa: nameJa,
    generationId: generationId,
    types: const [grass, poison],
    stats: const BaseStats(
      hp: 45,
      attack: 49,
      defense: 49,
      specialAttack: 65,
      specialDefense: 65,
      speed: 45,
    ),
    spriteUrl: null,
    artworkUrl: null,
    spriteFile: null,
    artworkFile: null,
    isFavorite: favorite,
  ),
  height: 7,
  weight: (weightKg * 10).round(),
  flavorEs: 'Hay una semilla de planta en su lomo desde que nace.',
  flavorEn: 'A strange seed was planted on its back at birth.',
  eggGroups: const ['Monstruo', 'Planta'],
  captureRate: 45,
  isLegendary: legendary,
  isMythical: mythical,
  shinyArtworkUrl: shinyUrl,
  abilities: const [
    PokemonAbility(
      ability: Ability(
        id: 65,
        slug: 'overgrow',
        nameEs: 'Espesura',
        nameEn: 'Overgrow',
      ),
      isHidden: false,
      effectEs: 'Potencia los movimientos de tipo Planta.',
      effectEn: 'Powers up Grass moves.',
    ),
    PokemonAbility(
      ability: Ability(
        id: 34,
        slug: 'chlorophyll',
        nameEs: 'Clorofila',
        nameEn: 'Chlorophyll',
      ),
      isHidden: true,
      effectEs: null,
      effectEn: null,
    ),
  ],
  moves:
      moves ??
      [
        move(33, 'tackle', power: 40),
        move(22, 'vine-whip', power: 45, typeId: 12, level: 9),
        move(45, 'growl'),
      ],
  versionGroups: const [
    VersionGroup(id: 1, slug: 'red-blue', generationId: 1, order: 1),
  ],
  speciesId: id,
  evolution: evolution,
  matchups: TypeMatchups({fire: 2, grass: 0.25}),
  lastSyncedAt: null,
  isTampered: false,
);

Widget host(
  Brightness brightness,
  Widget child, {
  List<Override> overrides = const [],
  bool disableAnimations = false,
}) => ProviderScope(
  overrides: [
    indicatorProvider.overrideWithValue(
      const IndicatorView(
        status: IndicatorStatus.online,
        origin: DataOrigin.liveAndLocal,
        lastSyncedAt: null,
        isPartial: false,
        localCount: 10,
        remoteTotal: 1025,
      ),
    ),
    typesProvider.overrideWith(
      (ref) => Stream.value(const [grass, poison, fire, normal]),
    ),
    generationsProvider.overrideWith((ref) => Stream.value(const [])),
    ...overrides,
  ],
  child: MaterialApp(
    theme: buildTheme(brightness),
    locale: const Locale('es'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(disableAnimations: disableAnimations),
      child: child!,
    ),
    home: child,
  ),
);

/// Pantalla de teléfono: 393x852 lógicos a 3x.
void phoneScreen(WidgetTester tester) {
  tester.view.devicePixelRatio = 3;
  tester.view.physicalSize = const Size(393 * 3, 852 * 3);
  addTearDown(tester.view.reset);
}
