import '../../domain/entities/poke_type.dart';
import '../../domain/entities/pokemon_detail.dart';

enum CardStage { basic, stage1, stage2 }

class CardAttack {
  const CardAttack({
    required this.name,
    required this.damage,
    required this.typeSlug,
    required this.cost,
    required this.damageClass,
    required this.accuracy,
  });
  final String name;
  final int? damage;
  final String typeSlug;
  final int cost;
  final DamageClass damageClass;
  final int? accuracy;
}

/// Presentación pura, sin Flutter: se prueba sin pintar.
/// Holográfica: solo legendario o singular, lo único parecido a una rareza que guarda la base.
class CardFacts {
  const CardFacts({
    required this.hp,
    required this.stage,
    required this.attacks,
    required this.weakness,
    required this.weaknessMultiplier,
    required this.resistance,
    required this.retreat,
    required this.holo,
    required this.typeSlug,
  });

  final int hp;
  final CardStage stage;
  final List<CardAttack> attacks;
  final PokeType? weakness;
  final double? weaknessMultiplier;
  final PokeType? resistance;
  final int retreat;
  final bool holo;

  final String typeSlug;

  /// Cada movimiento solo guarda el id de su tipo.
  factory CardFacts.from(PokemonDetail d, Map<int, PokeType> typesById) {
    final s = d.summary;
    return CardFacts(
      hp: s.stats.hp,
      stage: stageOf(d.evolution, d.speciesId ?? s.id),
      attacks: pickAttacks(d, typesById),
      weakness: d.matchups.weaknesses.isEmpty
          ? null
          : _strongest(d.matchups.weaknesses),
      weaknessMultiplier: d.matchups.weaknesses.isEmpty
          ? null
          : d.matchups.weaknesses.values.reduce((a, b) => a > b ? a : b),
      resistance: d.matchups.resistances.isEmpty
          ? null
          : d.matchups.resistances.keys.first,
      retreat: retreatCost(d.weightKg),
      holo: d.isLegendary || d.isMythical,
      typeSlug: s.types.first.slug,
    );
  }

  static PokeType _strongest(Map<PokeType, double> weaknesses) =>
      (weaknesses.entries.toList()..sort((a, b) => b.value.compareTo(a.value)))
          .first
          .key;

  static int roundDamage(int power) => (power / 10).round() * 10;

  /// 1 + peso / 40 hacia abajo, con tope de 4.
  static int retreatCost(double? weightKg) {
    if (weightKg == null) return 1;
    return (1 + weightKg ~/ 40).clamp(1, 4);
  }

  /// Una energía cada 50 de daño, de 1 a 4.
  static int energyCost(int? damage) =>
      damage == null ? 1 : (damage / 50).ceil().clamp(1, 4);

  static CardStage stageOf(EvolutionNode? root, int speciesId) {
    int? depth(EvolutionNode node, int level) {
      if (node.speciesId == speciesId) return level;
      for (final child in node.children) {
        final found = depth(child, level + 1);
        if (found != null) return found;
      }
      return null;
    }

    final level = root == null ? null : depth(root, 0);
    return switch (level) {
      1 => CardStage.stage1,
      2 || 3 => CardStage.stage2,
      _ => CardStage.basic,
    };
  }

  static List<CardAttack> pickAttacks(
    PokemonDetail d,
    Map<int, PokeType> typesById,
  ) {
    CardAttack attack(PokemonMove m, {required bool withDamage}) {
      final damage = withDamage ? roundDamage(m.power!) : null;
      return CardAttack(
        name: m.displayName,
        damage: damage,
        typeSlug: typesById[m.typeId]?.slug ?? 'normal',
        cost: energyCost(damage),
        damageClass: m.damageClass,
        accuracy: m.accuracy,
      );
    }

    final ownTypes = {for (final t in d.summary.types) t.id};
    // Un movimiento aparece una vez por versión y método: se deja uno.
    final byId = <int, PokemonMove>{};
    for (final m in d.moves) {
      if ((m.power ?? 0) > 0) byId.putIfAbsent(m.id, () => m);
    }
    final ranked = byId.values.toList()
      ..sort((a, b) {
        final stab = (ownTypes.contains(b.typeId) ? 1 : 0).compareTo(
          ownTypes.contains(a.typeId) ? 1 : 0,
        );
        if (stab != 0) return stab;
        final power = b.power!.compareTo(a.power!);
        return power != 0 ? power : a.slug.compareTo(b.slug);
      });
    if (ranked.isNotEmpty) {
      final top = ranked.take(2).toList()
        ..sort((a, b) => a.power!.compareTo(b.power!));
      return [for (final m in top) attack(m, withDamage: true)];
    }
    if (d.moves.isEmpty) return const [];
    return [attack(d.moves.first, withDamage: false)];
  }
}
