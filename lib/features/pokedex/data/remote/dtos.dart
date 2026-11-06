import 'package:collection/collection.dart';

import '../../../../core/error/failures.dart';

// DTO: la forma exacta de la respuesta GraphQL. Viven solo en la capa de
// datos; los mapeadores los convierten en filas de Drift. Validar aquí evita
// que un registro roto llegue a la base.

typedef Json = Map<String, Object?>;

const _languageEs = 7;
const _languageEn = 9;

const _languageJa = 1;

T _req<T>(Json json, String key) {
  final value = json[key];
  if (value is T) return value;
  throw InvalidDataFailure('Campo "$key" ausente o con tipo inesperado');
}

List<Json> _list(Json json, String key) =>
    (json[key] as List<Object?>? ?? const []).cast<Json>();

({String? es, String? en, String? ja}) _pickLanguages(
  List<Json> rows,
  String field,
) {
  String? es;
  String? en;
  String? ja;
  for (final row in rows) {
    final lang = row['language_id'];
    final text = row[field] as String?;
    if (text == null || text.trim().isEmpty) continue;
    if (lang == _languageEs) es ??= text;
    if (lang == _languageEn) en ??= text;
    if (lang == _languageJa) ja ??= text;
  }
  return (es: es, en: en, ja: ja);
}

Json? _preferredEvolution(List<Json> options) {
  if (options.isEmpty) return null;
  bool has(Json e, String key) => e[key] != null;
  return options.firstWhereOrNull((e) => has(e, 'item')) ??
      options.firstWhereOrNull((e) => has(e, 'min_level')) ??
      options.firstWhereOrNull((e) => has(e, 'min_happiness')) ??
      options.firstWhereOrNull(
        (e) => (e['evolutiontrigger'] as Json?)?['name'] == 'trade',
      ) ??
      options.first;
}

T? _tryParse<T>(T Function() parse) {
  try {
    return parse();
  } on InvalidDataFailure {
    return null;
  }
}

String _cleanText(String text) => text.replaceAll(RegExp(r'\s+'), ' ').trim();

String _titleCase(String slug) => slug
    .split('-')
    .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
    .join(' ');

String? _spriteUrl(Json json, String alias) {
  final rows = _list(json, alias);
  if (rows.isEmpty) return null;
  final value = rows.first['sprites'];
  return value is String && value.startsWith('http') ? value : null;
}

class PokemonSummaryDto {
  PokemonSummaryDto({
    required this.id,
    required this.slug,
    required this.nameEs,
    required this.nameEn,
    required this.nameJa,
    required this.speciesId,
    required this.isDefault,
    required this.formNameEs,
    required this.formNameEn,
    required this.generationId,
    required this.evolutionChainId,
    required this.types,
    required this.stats,
    required this.abilities,
    required this.spriteUrl,
    required this.artworkUrl,
  });

  final int id;
  final String slug;
  final String nameEs;
  final String nameEn;

  /// Nombre en katakana; null si PokéAPI no lo trae.
  final String? nameJa;
  final int speciesId;

  /// `false` en las formas alternativas (Raichu de Alola).
  final bool isDefault;
  final String? formNameEs;
  final String? formNameEn;
  final int generationId;
  final int? evolutionChainId;
  final List<({int typeId, int slot})> types;
  final Map<String, int> stats;
  final List<({int abilityId, bool isHidden})> abilities;
  final String? spriteUrl;
  final String? artworkUrl;

  static const statNames = [
    'hp',
    'attack',
    'defense',
    'special-attack',
    'special-defense',
    'speed',
  ];

  factory PokemonSummaryDto.fromJson(Json json) {
    final id = _req<int>(json, 'id');
    final slug = _req<String>(json, 'name');
    final species = _req<Json>(json, 'pokemonspecy');
    final names = _pickLanguages(_list(species, 'pokemonspeciesnames'), 'name');
    final forms = _list(json, 'pokemonforms');
    final formNames = forms.isEmpty
        ? (es: null, en: null, ja: null)
        : _pickLanguages(_list(forms.first, 'pokemonformnames'), 'name');
    final types = [
      for (final t in _list(json, 'pokemontypes'))
        (typeId: _req<int>(t, 'type_id'), slot: _req<int>(t, 'slot')),
    ];
    final stats = {
      for (final s in _list(json, 'pokemonstats'))
        _req<String>(_req<Json>(s, 'stat'), 'name'): _req<int>(s, 'base_stat'),
    };
    if (types.isEmpty) throw InvalidDataFailure('Pokémon $id sin tipos');
    if (!statNames.every(stats.containsKey)) {
      throw InvalidDataFailure('Pokémon $id con estadísticas incompletas');
    }
    final fallback = _titleCase(slug);
    return PokemonSummaryDto(
      id: id,
      slug: slug,
      nameEs: names.es ?? names.en ?? fallback,
      nameEn: names.en ?? fallback,
      nameJa: names.ja,
      speciesId: json['pokemon_species_id'] as int? ?? id,
      isDefault: json['is_default'] as bool? ?? true,
      formNameEs: formNames.es ?? formNames.en,
      formNameEn: formNames.en,
      generationId: _req<int>(species, 'generation_id'),
      evolutionChainId: species['evolution_chain_id'] as int?,
      types: types,
      stats: stats,
      abilities: [
        for (final a in _list(json, 'pokemonabilities'))
          (
            abilityId: _req<int>(a, 'ability_id'),
            isHidden: _req<bool>(a, 'is_hidden'),
          ),
      ],
      spriteUrl: _spriteUrl(json, 'sprite'),
      artworkUrl: _spriteUrl(json, 'artwork'),
    );
  }
}

class AbilityDetailDto {
  AbilityDetailDto({
    required this.id,
    required this.slug,
    required this.nameEs,
    required this.nameEn,
    required this.effectEs,
    required this.effectEn,
    required this.isHidden,
  });
  final int id;
  final String slug;
  final String nameEs;
  final String nameEn;
  final String? effectEs;
  final String? effectEn;
  final bool isHidden;
}

class MoveDto {
  MoveDto({
    required this.id,
    required this.slug,
    required this.power,
    required this.accuracy,
    required this.pp,
    required this.typeId,
    required this.damageClassId,
  });

  factory MoveDto.fromJson(Json json) => MoveDto(
    id: _req<int>(json, 'id'),
    slug: _req<String>(json, 'name'),
    power: json['power'] as int?,
    accuracy: json['accuracy'] as int?,
    pp: json['pp'] as int?,
    typeId: _req<int>(json, 'type_id'),
    damageClassId: json['move_damage_class_id'] as int? ?? 1,
  );

  final int id;
  final String slug;
  final int? power;
  final int? accuracy;
  final int? pp;
  final int typeId;
  final int damageClassId;
}

typedef LearnedMoveDto = ({
  int moveId,
  int versionGroupId,
  int methodId,
  int level,
});

class EvolutionDto {
  EvolutionDto({
    required this.speciesId,
    required this.slug,
    required this.fromSpeciesId,
    required this.trigger,
    required this.minLevel,
    required this.item,
    required this.minHappiness,
    required this.timeOfDay,
  });
  final int speciesId;
  final String slug;
  final int? fromSpeciesId;
  final String? trigger;
  final int? minLevel;
  final String? item;
  final int? minHappiness;
  final String? timeOfDay;
}

class PokemonDetailDto {
  PokemonDetailDto({
    required this.id,
    required this.height,
    required this.weight,
    required this.shinyArtworkUrl,
    required this.flavorEs,
    required this.flavorEn,
    required this.eggGroups,
    required this.captureRate,
    required this.isLegendary,
    required this.isMythical,
    required this.abilities,
    required this.moves,
    required this.learnset,
    required this.varieties,
    required this.evolutionChainId,
    required this.evolutions,
  });

  final int id;
  final int height;
  final int weight;
  final String? shinyArtworkUrl;
  final String? flavorEs;
  final String? flavorEn;
  final List<String> eggGroups;
  final int? captureRate;
  final bool isLegendary;
  final bool isMythical;
  final List<AbilityDetailDto> abilities;
  final List<MoveDto> moves;
  final List<LearnedMoveDto> learnset;

  /// Todas las formas de la especie, incluida la por defecto.
  final List<PokemonSummaryDto> varieties;
  final int? evolutionChainId;
  final List<EvolutionDto> evolutions;

  /// [json] es el Pokémon; [moves] viene de la raíz `move` de la misma
  /// respuesta.
  factory PokemonDetailDto.fromJson(Json json, {List<Json> moves = const []}) {
    final id = _req<int>(json, 'id');
    final species = _req<Json>(json, 'pokemonspecy');
    final flavor = _pickLanguages(
      _list(species, 'pokemonspeciesflavortexts'),
      'flavor_text',
    );
    final chain = species['evolutionchain'] as Json?;
    return PokemonDetailDto(
      id: id,
      height: _req<int>(json, 'height'),
      weight: _req<int>(json, 'weight'),
      shinyArtworkUrl: _spriteUrl(json, 'shiny'),
      flavorEs: flavor.es == null ? null : _cleanText(flavor.es!),
      flavorEn: flavor.en == null ? null : _cleanText(flavor.en!),
      eggGroups: [
        for (final g in _list(species, 'pokemonegggroups'))
          _req<String>(_req<Json>(g, 'egggroup'), 'name'),
      ],
      captureRate: species['capture_rate'] as int?,
      isLegendary: species['is_legendary'] as bool? ?? false,
      isMythical: species['is_mythical'] as bool? ?? false,
      abilities: [
        for (final row in _list(json, 'pokemonabilities'))
          () {
            final ability = _req<Json>(row, 'ability');
            final slug = _req<String>(ability, 'name');
            final names = _pickLanguages(
              _list(ability, 'abilitynames'),
              'name',
            );
            final effects = _pickLanguages(
              _list(ability, 'abilityflavortexts'),
              'flavor_text',
            );
            return AbilityDetailDto(
              id: _req<int>(ability, 'id'),
              slug: slug,
              nameEs: names.es ?? names.en ?? _titleCase(slug),
              nameEn: names.en ?? _titleCase(slug),
              effectEs: effects.es == null ? null : _cleanText(effects.es!),
              effectEn: effects.en == null ? null : _cleanText(effects.en!),
              isHidden: _req<bool>(row, 'is_hidden'),
            );
          }(),
      ],
      moves: [for (final m in moves) MoveDto.fromJson(m)],
      learnset: [
        for (final row in _list(json, 'pokemonmoves'))
          (
            moveId: _req<int>(row, 'move_id'),
            versionGroupId: _req<int>(row, 'version_group_id'),
            methodId: _req<int>(row, 'move_learn_method_id'),
            level: row['level'] as int? ?? 0,
          ),
      ],
      varieties: [
        for (final v in _list(species, 'varieties'))
          ?_tryParse(() => PokemonSummaryDto.fromJson(v)),
      ],
      evolutionChainId: chain?['id'] as int?,
      evolutions: [
        for (final node
            in chain == null ? <Json>[] : _list(chain, 'pokemonspecies'))
          () {
            final evo = _preferredEvolution(_list(node, 'pokemonevolutions'));
            final time = evo?['time_of_day'] as String?;
            return EvolutionDto(
              speciesId: _req<int>(node, 'id'),
              slug: _req<String>(node, 'name'),
              fromSpeciesId: node['evolves_from_species_id'] as int?,
              trigger: (evo?['evolutiontrigger'] as Json?)?['name'] as String?,
              minLevel: evo?['min_level'] as int?,
              item: (evo?['item'] as Json?)?['name'] as String?,
              minHappiness: evo?['min_happiness'] as int?,
              timeOfDay: time == null || time.isEmpty ? null : time,
            );
          }(),
      ],
    );
  }
}

class StaticDataDto {
  StaticDataDto({
    required this.types,
    required this.efficacy,
    required this.generations,
    required this.versionGroups,
    required this.abilities,
  });

  final List<({int id, String slug, String nameEs, String nameEn})> types;
  final List<({int attack, int target, int factor})> efficacy;
  final List<({int id, String slug, String region})> generations;
  final List<({int id, String slug, int generationId, int order})>
  versionGroups;
  final List<({int id, String slug, String nameEs, String nameEn})> abilities;

  factory StaticDataDto.fromJson(Json json) {
    ({int id, String slug, String nameEs, String nameEn}) named(
      Json row,
      String namesKey,
    ) {
      final slug = _req<String>(row, 'name');
      final names = _pickLanguages(_list(row, namesKey), 'name');
      return (
        id: _req<int>(row, 'id'),
        slug: slug,
        nameEs: names.es ?? names.en ?? _titleCase(slug),
        nameEn: names.en ?? _titleCase(slug),
      );
    }

    final dto = StaticDataDto(
      types: [for (final t in _list(json, 'type')) named(t, 'typenames')],
      efficacy: [
        for (final e in _list(json, 'typeefficacy'))
          (
            attack: _req<int>(e, 'damage_type_id'),
            target: _req<int>(e, 'target_type_id'),
            factor: _req<int>(e, 'damage_factor'),
          ),
      ],
      generations: [
        for (final g in _list(json, 'generation'))
          (
            id: _req<int>(g, 'id'),
            slug: _req<String>(g, 'name'),
            region: _req<String>(_req<Json>(g, 'region'), 'name'),
          ),
      ],
      versionGroups: [
        for (final v in _list(json, 'versiongroup'))
          (
            id: _req<int>(v, 'id'),
            slug: _req<String>(v, 'name'),
            generationId: _req<int>(v, 'generation_id'),
            order: _req<int>(v, 'order'),
          ),
      ],
      abilities: [
        for (final a in _list(json, 'ability')) named(a, 'abilitynames'),
      ],
    );
    if (dto.types.length < 18 || dto.efficacy.length < 18 * 18) {
      throw const InvalidDataFailure('Tabla de tipos incompleta');
    }
    return dto;
  }
}
