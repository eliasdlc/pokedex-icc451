import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokedex/domain/entities/pokemon_detail.dart';
import 'package:pokedex/features/pokedex/presentation/detail/card_facts.dart';

import 'detail_fixtures.dart';

void main() {
  final types = {
    for (final t in [normal, grass, poison, fire]) t.id: t,
  };

  group('reglas de la carta', () {
    test('el daño es la potencia redondeada a 10', () {
      expect(CardFacts.roundDamage(40), 40);
      expect(CardFacts.roundDamage(45), 50);
      expect(CardFacts.roundDamage(94), 90);
      expect(CardFacts.roundDamage(120), 120);
    });

    test('la retirada es 1 + peso / 40 hacia abajo, con tope de 4', () {
      expect(CardFacts.retreatCost(null), 1);
      expect(CardFacts.retreatCost(6.9), 1);
      expect(CardFacts.retreatCost(39.9), 1);
      expect(CardFacts.retreatCost(40), 2);
      expect(CardFacts.retreatCost(85), 3);
      expect(CardFacts.retreatCost(950), 4);
    });

    test('el coste en energías crece con el daño, de 1 a 4', () {
      expect(CardFacts.energyCost(null), 1);
      expect(CardFacts.energyCost(40), 1);
      expect(CardFacts.energyCost(90), 2);
      expect(CardFacts.energyCost(300), 4);
    });

    test('la etapa sale de la posición en la cadena evolutiva', () {
      const leaf = EvolutionNode(
        speciesId: 3,
        slug: 'venusaur',
        condition: null,
        children: [],
      );
      const mid = EvolutionNode(
        speciesId: 2,
        slug: 'ivysaur',
        condition: null,
        children: [leaf],
      );
      const root = EvolutionNode(
        speciesId: 1,
        slug: 'bulbasaur',
        condition: null,
        children: [mid],
      );
      expect(CardFacts.stageOf(root, 1), CardStage.basic);
      expect(CardFacts.stageOf(root, 2), CardStage.stage1);
      expect(CardFacts.stageOf(root, 3), CardStage.stage2);
      expect(CardFacts.stageOf(null, 1), CardStage.basic);
      expect(CardFacts.stageOf(root, 999), CardStage.basic);
    });
  });

  group('ataques', () {
    test(
      'elige los dos con potencia, los de su tipo primero, el débil arriba',
      () {
        final d = bulbasaur(
          moves: [
            move(1, 'hyper-beam', power: 150),
            move(2, 'razor-leaf', power: 55, typeId: 12),
            move(3, 'vine-whip', power: 45, typeId: 12),
            move(4, 'growl'),
          ],
        );
        final attacks = CardFacts.from(d, types).attacks;
        expect([for (final a in attacks) a.name], ['Vine Whip', 'Razor Leaf']);
        expect([for (final a in attacks) a.damage], [50, 60]);
        expect(attacks.first.typeSlug, 'grass');
      },
    );

    test('un movimiento repetido en varias versiones cuenta una vez', () {
      final d = bulbasaur(
        moves: [
          move(2, 'razor-leaf', power: 55, typeId: 12, versionGroupId: 1),
          move(2, 'razor-leaf', power: 55, typeId: 12, versionGroupId: 2),
          move(3, 'vine-whip', power: 45, typeId: 12),
        ],
      );
      expect(CardFacts.from(d, types).attacks, hasLength(2));
    });

    test('sin movimientos con potencia usa el primero, sin daño', () {
      final d = bulbasaur(moves: [move(45, 'growl'), move(74, 'growth')]);
      final attacks = CardFacts.from(d, types).attacks;
      expect(attacks, hasLength(1));
      expect(attacks.single.name, 'Growl');
      expect(attacks.single.damage, isNull);
    });

    test('sin movimientos guardados no inventa ataques', () {
      expect(CardFacts.from(bulbasaur(moves: []), types).attacks, isEmpty);
    });
  });

  group('datos de la carta', () {
    test('PS, debilidad, resistencia y retirada salen del detalle', () {
      final facts = CardFacts.from(bulbasaur(weightKg: 85), types);
      expect(facts.hp, 45);
      expect(facts.weakness, fire);
      expect(facts.weaknessMultiplier, 2);
      expect(facts.resistance, grass);
      expect(facts.retreat, 3);
      expect(facts.typeSlug, 'grass');
    });

    test('holográfica solo si es legendario o singular', () {
      expect(CardFacts.from(bulbasaur(), types).holo, isFalse);
      expect(CardFacts.from(bulbasaur(legendary: true), types).holo, isTrue);
      expect(CardFacts.from(bulbasaur(mythical: true), types).holo, isTrue);
    });
  });
}
