import 'dart:math';

import '../../pokedex/domain/entities/pokemon_summary.dart';

class TriviaQuestion {
  const TriviaQuestion({required this.answer, required this.options});
  final PokemonSummary answer;
  final List<PokemonSummary> options;
}

class TriviaEngine {
  TriviaEngine({Random? random}) : _random = random ?? Random();
  final Random _random;

  static const questionsPerRound = 10;
  static const optionsPerQuestion = 4;
  static const secondsPerQuestion = 15;
  static const basePoints = 100;

  /// Mínimo de Pokémon con imagen local para jugar sin red.
  static const minimumPool = optionsPerQuestion;

  bool canPlay(List<PokemonSummary> pool) => pool.length >= minimumPool;

  List<TriviaQuestion> buildRound(List<PokemonSummary> pool) {
    final shuffled = [...pool]..shuffle(_random);
    final answers = shuffled.take(min(questionsPerRound, pool.length)).toList();
    return [
      for (final answer in answers)
        TriviaQuestion(
          answer: answer,
          options: ([
            answer,
            ...([...pool]
                  ..remove(answer)
                  ..shuffle(_random))
                .take(optionsPerQuestion - 1),
          ]..shuffle(_random)),
        ),
    ];
  }

  /// 100 por acierto, hasta 100 por rapidez y 10 por cada acierto previo de la racha.
  int pointsFor({
    required bool correct,
    required Duration remaining,
    required int streak,
  }) {
    if (!correct) return 0;
    final speedBonus =
        (remaining.inMilliseconds / (secondsPerQuestion * 1000) * basePoints)
            .round();
    return basePoints + speedBonus.clamp(0, basePoints) + streak * 10;
  }
}
