import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/achievements.dart';
import '../domain/gamification_repository.dart';

class DriftGamificationRepository implements GamificationRepository {
  DriftGamificationRepository(this._db);
  final AppDatabase _db;

  @override
  Future<void> saveTriviaScore(TriviaScore s) => _db
      .into(_db.triviaScores)
      .insert(
        TriviaScoresCompanion.insert(
          score: s.score,
          correct: s.correct,
          total: s.total,
          bestStreak: s.bestStreak,
          durationMs: s.duration.inMilliseconds,
          playedAt: s.playedAt,
        ),
      );

  @override
  Stream<List<TriviaScore>> watchRanking({int limit = 10}) =>
      (_db.select(_db.triviaScores)
            ..orderBy([
              (t) => OrderingTerm.desc(t.score),
              (t) => OrderingTerm.asc(t.durationMs),
            ])
            ..limit(limit))
          .watch()
          .map(
            (rows) => [
              for (final r in rows)
                TriviaScore(
                  score: r.score,
                  correct: r.correct,
                  total: r.total,
                  bestStreak: r.bestStreak,
                  duration: Duration(milliseconds: r.durationMs),
                  playedAt: r.playedAt,
                ),
            ],
          );

  @override
  Stream<List<AchievementProgress>> watchAchievements() =>
      _db.select(_db.achievements).watch().map((rows) {
        final unlocked = {for (final r in rows) r.id: r.unlockedAt};
        return [
          for (final a in Achievement.values)
            AchievementProgress(a, unlocked[a.name]),
        ];
      });

  @override
  Future<bool> unlock(Achievement achievement) => _db.transaction(() async {
    final existing = await (_db.select(
      _db.achievements,
    )..where((a) => a.id.equals(achievement.name))).getSingleOrNull();
    if (existing != null) return false;
    await _db
        .into(_db.achievements)
        .insert(
          AchievementsCompanion.insert(
            id: achievement.name,
            unlockedAt: DateTime.now(),
          ),
        );
    return true;
  });

  @override
  Future<void> saveBattle({
    required int playerId,
    required int rivalId,
    required bool won,
    required int turns,
  }) => _db
      .into(_db.battleRecords)
      .insert(
        BattleRecordsCompanion.insert(
          playerId: playerId,
          rivalId: rivalId,
          won: won,
          turns: turns,
          playedAt: DateTime.now(),
        ),
      );

  @override
  Stream<BattleStats> watchBattleStats() => _db
      .select(_db.battleRecords)
      .watch()
      .map(
        (rows) => BattleStats(
          played: rows.length,
          won: rows.where((r) => r.won).length,
        ),
      );
}
