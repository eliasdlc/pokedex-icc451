/// Logros solo locales, como favoritos y puntuación.
enum Achievement {
  firstCorrect,
  streak5,
  perfectRound,
  score1000,
  firstBattleWin,
  fiveBattleWins,
  collector10,
  typeMaster,
}

class AchievementProgress {
  const AchievementProgress(this.achievement, this.unlockedAt);
  final Achievement achievement;
  final DateTime? unlockedAt;
  bool get unlocked => unlockedAt != null;
}
