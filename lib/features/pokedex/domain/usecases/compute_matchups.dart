import '../entities/poke_type.dart';
import '../entities/pokemon_detail.dart';

/// Regla de negocio pura: multiplica la efectividad de cada tipo atacante
/// contra cada tipo del defensor. Ejemplo: Agua contra Fuego/Roca = 2 x 2 = 4.
TypeMatchups computeMatchups({
  required List<PokeType> defenderTypes,
  required List<PokeType> allTypes,
  required Map<(int, int), int> efficacy,
}) {
  final result = <PokeType, double>{};
  for (final attacker in allTypes) {
    var multiplier = 1.0;
    for (final defender in defenderTypes) {
      multiplier *= (efficacy[(attacker.id, defender.id)] ?? 100) / 100;
    }
    result[attacker] = multiplier;
  }
  return TypeMatchups(result);
}
