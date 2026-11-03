import 'poke_type.dart';
import 'pokemon_summary.dart';

class PokemonAbility {
  const PokemonAbility({
    required this.ability,
    required this.isHidden,
    required this.effectEs,
    required this.effectEn,
  });
  final Ability ability;
  final bool isHidden;
  final String? effectEs;
  final String? effectEn;

  String? shortEffect(String languageCode) {
    final text = languageCode == 'es' ? effectEs ?? effectEn : effectEn;
    if (text == null) return null;
    final clean = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    return clean.length <= 140 ? clean : '${clean.substring(0, 139)}…';
  }
}

enum DamageClass { status, physical, special }

/// Cómo se aprende un movimiento. Los ids son los de PokéAPI.
enum MoveLearnMethod {
  levelUp(1),
  machine(4),
  tutor(3),
  egg(2);

  const MoveLearnMethod(this.id);
  final int id;

  static MoveLearnMethod? fromId(int id) =>
      values.where((m) => m.id == id).firstOrNull;
}

enum MoveSort { level, name }

/// Versión de los juegos donde aparece el Pokémon (Escarlata/Púrpura).
class VersionGroup {
  const VersionGroup({
    required this.id,
    required this.slug,
    required this.generationId,
    required this.order,
  });
  final int id;
  final String slug;
  final int generationId;
  final int order;

  String get displayName => slug
      .split('-')
      .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
      .join(' ');
}

/// Una forma de la especie: la normal, la de Alola, una Mega.
class PokemonVariety {
  const PokemonVariety({
    required this.id,
    required this.isDefault,
    required this.formNameEs,
    required this.formNameEn,
  });
  final int id;
  final bool isDefault;
  final String? formNameEs;
  final String? formNameEn;

  String? formName(String languageCode) =>
      languageCode == 'es' ? formNameEs ?? formNameEn : formNameEn;
}

class PokemonMove {
  const PokemonMove({
    required this.id,
    required this.slug,
    required this.versionGroupId,
    required this.method,
    required this.level,
    required this.power,
    required this.accuracy,
    required this.pp,
    required this.typeId,
    required this.damageClass,
  });
  final int id;
  final String slug;
  final int versionGroupId;
  final MoveLearnMethod method;

  /// Nivel de aprendizaje; 0 cuando el método no usa nivel (MT, huevo).
  final int level;
  final int? power;
  final int? accuracy;
  final int? pp;
  final int typeId;
  final DamageClass damageClass;

  String get displayName => slug
      .split('-')
      .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
      .join(' ');
}

/// Condición de una evolución: nivel, objeto, intercambio, amistad u hora.
class EvolutionCondition {
  const EvolutionCondition({
    required this.trigger,
    this.minLevel,
    this.item,
    this.minHappiness,
    this.timeOfDay,
  });
  final String trigger;
  final int? minLevel;
  final String? item;
  final int? minHappiness;
  final String? timeOfDay;
}

/// Árbol evolutivo con soporte de ramas.
class EvolutionNode {
  const EvolutionNode({
    required this.speciesId,
    required this.slug,
    required this.condition,
    required this.children,
  });
  final int speciesId;
  final String slug;
  final EvolutionCondition? condition;
  final List<EvolutionNode> children;

  bool get isLeaf => children.isEmpty;
}

/// Debilidades y resistencias calculadas con la tabla de efectividad local.
class TypeMatchups {
  const TypeMatchups(this.multipliers);

  /// Tipo atacante -> multiplicador sobre este Pokémon (0, 0.25 ... 4).
  final Map<PokeType, double> multipliers;

  Map<PokeType, double> get weaknesses =>
      Map.fromEntries(multipliers.entries.where((e) => e.value > 1));
  Map<PokeType, double> get resistances => Map.fromEntries(
    multipliers.entries.where((e) => e.value < 1 && e.value > 0),
  );
  List<PokeType> get immunities =>
      multipliers.entries.where((e) => e.value == 0).map((e) => e.key).toList();
}

class PokemonDetail {
  const PokemonDetail({
    required this.summary,
    required this.height,
    required this.weight,
    required this.flavorEs,
    required this.flavorEn,
    required this.eggGroups,
    required this.captureRate,
    required this.isLegendary,
    required this.isMythical,
    required this.shinyArtworkUrl,
    required this.abilities,
    required this.moves,
    this.versionGroups = const [],
    this.varieties = const [],
    this.speciesId,
    required this.evolution,
    required this.matchups,
    required this.lastSyncedAt,
    required this.isTampered,
  });

  final PokemonSummary summary;
  final int? height;
  final int? weight;
  final String? flavorEs;
  final String? flavorEn;
  final List<String> eggGroups;
  final int? captureRate;
  final bool isLegendary;
  final bool isMythical;
  final String? shinyArtworkUrl;
  final List<PokemonAbility> abilities;

  /// Todos los movimientos de todas las versiones y métodos; la ficha
  /// muestra un subconjunto con [movesFor].
  final List<PokemonMove> moves;

  final List<VersionGroup> versionGroups;

  final List<PokemonVariety> varieties;

  final int? speciesId;
  final EvolutionNode? evolution;
  final TypeMatchups matchups;
  final DateTime? lastSyncedAt;

  final bool isTampered;

  bool get isComplete => height != null;

  int? get defaultVersionGroupId =>
      versionGroups.isEmpty ? null : versionGroups.last.id;

  /// Número de Pokédex nacional: el de la especie, también en una forma
  /// (Raichu de Alola es #0026 aunque su id en PokéAPI sea 10100).
  String get nationalNumber =>
      '#${(speciesId ?? summary.id).toString().padLeft(4, '0')}';

  PokemonVariety? get currentVariety =>
      varieties.where((v) => v.id == summary.id).firstOrNull;

  List<PokemonMove> movesFor({
    required int versionGroupId,
    required MoveLearnMethod method,
    MoveSort sort = MoveSort.level,
  }) {
    final list = [
      for (final m in moves)
        if (m.versionGroupId == versionGroupId && m.method == method) m,
    ];
    list.sort(
      (a, b) => switch (sort) {
        MoveSort.level =>
          a.level != b.level
              ? a.level.compareTo(b.level)
              : a.displayName.compareTo(b.displayName),
        MoveSort.name => a.displayName.compareTo(b.displayName),
      },
    );
    return list;
  }

  double? get heightMeters => height == null ? null : height! / 10;
  double? get weightKg => weight == null ? null : weight! / 10;
}
