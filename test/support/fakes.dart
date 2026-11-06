import 'dart:async';

import 'package:pokedex/core/connectivity/connectivity_state.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/features/pokedex/data/images/image_store.dart';
import 'package:pokedex/features/pokedex/data/remote/dtos.dart';
import 'package:pokedex/features/pokedex/data/remote/pokeapi_remote_data_source.dart';

PokemonSummaryDto fakeSummary(
  int id, {
  String? nameEn,
  String? nameJa,
  int hp = 50,
  List<int> types = const [12],
  int? speciesId,
  String? formName,
}) => PokemonSummaryDto(
  id: id,
  slug: 'poke-$id',
  nameEs: 'Poke $id',
  nameEn: nameEn ?? 'Poke $id',
  nameJa: nameJa ?? 'ポケ$id',
  speciesId: speciesId ?? id,
  isDefault: speciesId == null,
  formNameEs: formName,
  formNameEn: formName,
  generationId: 1 + id % 3,
  evolutionChainId: id,
  types: [for (final (i, t) in types.indexed) (typeId: t, slot: i + 1)],
  stats: {
    'hp': hp,
    'attack': 60,
    'defense': 55,
    'special-attack': 70,
    'special-defense': 65,
    'speed': 80,
  },
  abilities: [(abilityId: 1, isHidden: false)],
  spriteUrl: 'https://img/sprite/$id.png',
  artworkUrl: 'https://img/art/$id.png',
);

/// API falsa: guarda cuántas veces la llamaron y puede "caerse" a voluntad.
class FakeRemote implements PokeApiRemoteDataSource {
  FakeRemote(this.total);
  int total;
  bool down = false;
  final calls = <String>[];
  final overrides = <int, PokemonSummaryDto>{};

  /// Formas alternativas por especie, para probar el selector de formas.
  final forms = <int, List<PokemonSummaryDto>>{};

  void _check() {
    if (down) throw const ServiceUnavailableFailure('caída simulada');
  }

  @override
  int lastDiscarded = 0;

  @override
  Future<bool> probe() async => !down;

  @override
  Future<List<int>> fetchCatalogIds() async {
    calls.add('ids');
    _check();
    return [for (var i = 1; i <= total; i++) i];
  }

  @override
  Future<List<PokemonSummaryDto>> fetchByIds(List<int> ids) async {
    calls.add('byIds:${ids.length}');
    _check();
    return [for (final id in ids) overrides[id] ?? fakeSummary(id)];
  }

  @override
  Future<PokemonDetailDto> fetchDetail(int id) async {
    calls.add('detail:$id');
    _check();
    return PokemonDetailDto(
      id: id,
      height: 7,
      weight: 69,
      shinyArtworkUrl: null,
      flavorEs: 'Descripción $id',
      flavorEn: 'Description $id',
      eggGroups: const ['monster'],
      captureRate: 45,
      isLegendary: false,
      isMythical: false,
      abilities: [
        AbilityDetailDto(
          id: 1,
          slug: 'overgrow',
          nameEs: 'Espesura',
          nameEn: 'Overgrow',
          effectEs: 'Potencia ataques planta.',
          effectEn: 'Powers up Grass moves.',
          isHidden: false,
        ),
      ],
      moves: [
        MoveDto(
          id: 33,
          slug: 'tackle',
          power: 40,
          accuracy: 100,
          pp: 35,
          typeId: 1,
          damageClassId: 2,
        ),
        MoveDto(
          id: 85,
          slug: 'thunderbolt',
          power: 90,
          accuracy: 100,
          pp: 15,
          typeId: 13,
          damageClassId: 3,
        ),
      ],
      // Placaje por nivel en dos versiones; Rayo por MT solo en la 25.
      learnset: const [
        (moveId: 33, versionGroupId: 1, methodId: 1, level: 1),
        (moveId: 33, versionGroupId: 25, methodId: 1, level: 5),
        (moveId: 85, versionGroupId: 25, methodId: 4, level: 0),
      ],
      varieties: [overrides[id] ?? fakeSummary(id), ...?forms[id]],
      evolutionChainId: id,
      evolutions: [
        EvolutionDto(
          speciesId: id,
          slug: 'poke-$id',
          fromSpeciesId: null,
          trigger: null,
          minLevel: null,
          item: null,
          minHappiness: null,
          timeOfDay: null,
        ),
      ],
    );
  }

  @override
  Future<StaticDataDto> fetchStaticData() async {
    calls.add('static');
    _check();
    return StaticDataDto(
      types: [
        for (var i = 1; i <= 18; i++)
          (id: i, slug: 't$i', nameEs: 'Tipo $i', nameEn: 'Type $i'),
      ],
      efficacy: [
        for (var a = 1; a <= 18; a++)
          for (var t = 1; t <= 18; t++)
            (attack: a, target: t, factor: a == 11 && t == 10 ? 200 : 100),
      ],
      generations: [(id: 1, slug: 'generation-i', region: 'kanto')],
      versionGroups: const [
        (id: 1, slug: 'red-blue', generationId: 1, order: 3),
        (id: 25, slug: 'scarlet-violet', generationId: 9, order: 27),
      ],
      abilities: [
        (id: 1, slug: 'overgrow', nameEs: 'Espesura', nameEn: 'Overgrow'),
      ],
    );
  }
}

class FakeConnectivity implements ConnectivityService {
  FakeConnectivity(this._current, {this.remote});
  ServiceAvailability _current;
  final FakeRemote? remote;
  final _controller = StreamController<ServiceAvailability>.broadcast();

  @override
  ServiceAvailability get current => _current;

  set availability(ServiceAvailability value) {
    _current = value;
    _controller.add(value);
  }

  @override
  Stream<ServiceAvailability> watch() async* {
    yield _current;
    yield* _controller.stream;
  }

  @override
  Future<ServiceAvailability> recheck() async => _current;

  @override
  void reportServiceFailure() {
    if (_current == ServiceAvailability.online) {
      availability = ServiceAvailability.serviceUnavailable;
    }
  }
}

class FakeImages implements ImageStore {
  @override
  Future<String?> save(
    String url, {
    required String kind,
    required int pokemonId,
  }) async => '/fake/$kind/$pokemonId.png';
}
