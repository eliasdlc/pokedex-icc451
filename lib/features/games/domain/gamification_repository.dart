import 'achievements.dart';

class TriviaScore {
  const TriviaScore({
    required this.score,
    required this.correct,
    required this.total,
    required this.bestStreak,
    required this.duration,
    required this.playedAt,
  });
  final int score;
  final int correct;
  final int total;
  final int bestStreak;
  final Duration duration;
  final DateTime playedAt;
}

class BattleStats {
  const BattleStats({required this.played, required this.won});
  final int played;
  final int won;
}

/// Datos propios del usuario: nunca viajan a la API.
abstract interface class GamificationRepository {
  Future<void> saveTriviaScore(TriviaScore score);
  Stream<List<TriviaScore>> watchRanking({int limit = 10});
  Stream<List<AchievementProgress>> watchAchievements();

  /// Devuelve true si el logro era nuevo.
  Future<bool> unlock(Achievement achievement);
  Future<void> saveBattle({
    required int playerId,
    required int rivalId,
    required bool won,
    required int turns,
  });
  Stream<BattleStats> watchBattleStats();
}
