import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/di/providers.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../domain/gamification_repository.dart';
import '../domain/achievements.dart';

final rankingProvider = StreamProvider<List<TriviaScore>>(
  (ref) => ref.watch(gamificationRepositoryProvider).watchRanking(),
);

final achievementsProvider = StreamProvider<List<AchievementProgress>>(
  (ref) => ref.watch(gamificationRepositoryProvider).watchAchievements(),
);

final battleStatsProvider = StreamProvider<BattleStats>(
  (ref) => ref.watch(gamificationRepositoryProvider).watchBattleStats(),
);

final reduceMotionSettingProvider = Provider<bool>(
  (ref) =>
      ref.watch(settingsProvider.select((s) => s.value?.reduceMotion ?? false)),
);

/// Adornos de movimiento apagados si el sistema o el ajuste de la app lo piden.
bool shouldReduceMotion(BuildContext context, WidgetRef ref) =>
    MediaQuery.disableAnimationsOf(context) ||
    ref.watch(reduceMotionSettingProvider);

String achievementName(AppLocalizations l10n, Achievement a) => switch (a) {
  Achievement.firstCorrect => l10n.ach_firstCorrect,
  Achievement.streak5 => l10n.ach_streak5,
  Achievement.perfectRound => l10n.ach_perfectRound,
  Achievement.score1000 => l10n.ach_score1000,
  Achievement.firstBattleWin => l10n.ach_firstBattleWin,
  Achievement.fiveBattleWins => l10n.ach_fiveBattleWins,
  Achievement.collector10 => l10n.ach_collector10,
  Achievement.typeMaster => l10n.ach_typeMaster,
};

IconData achievementIcon(Achievement a) => switch (a) {
  Achievement.firstCorrect => Icons.check_circle_outline,
  Achievement.streak5 => Icons.local_fire_department_outlined,
  Achievement.perfectRound => Icons.military_tech_outlined,
  Achievement.score1000 => Icons.emoji_events_outlined,
  Achievement.firstBattleWin => Icons.sports_kabaddi_outlined,
  Achievement.fiveBattleWins => Icons.shield_outlined,
  Achievement.collector10 => Icons.favorite_border,
  Achievement.typeMaster => Icons.bolt_outlined,
};

/// Devuelve true si el logro era nuevo.
Future<bool> unlockAndAnnounce(
  WidgetRef ref,
  ScaffoldMessengerState messenger,
  AppLocalizations l10n,
  Achievement a,
) async {
  final isNew = await ref.read(gamificationRepositoryProvider).unlock(a);
  if (isNew) {
    messenger.showSnackBar(
      SnackBar(content: Text(l10n.newAchievement(achievementName(l10n, a)))),
    );
  }
  return isNew;
}
