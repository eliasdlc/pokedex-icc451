import 'package:flutter/material.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../app/theme/type_palette.dart';
import '../../../../shared/l10n_x.dart';
import '../../../../shared/widgets/pokedex_key.dart';
import '../../../../shared/widgets/pokemon_image.dart';
import '../../../pokedex/domain/entities/pokemon_summary.dart';
import '../../domain/achievements.dart';
import '../../domain/gamification_repository.dart';
import '../games_providers.dart';
import 'ranking_row.dart';

class TriviaResultView extends StatelessWidget {
  const TriviaResultView({
    super.key,
    required this.lastPokemon,
    required this.score,
    required this.correct,
    required this.total,
    required this.newAchievements,
    required this.ranking,
    required this.playedAt,
    required this.onPlayAgain,
    required this.onExit,
  });

  final PokemonSummary lastPokemon;
  final int score;
  final int correct;
  final int total;

  final List<Achievement> newAchievements;
  final List<TriviaScore> ranking;

  final DateTime? playedAt;
  final VoidCallback onPlayAgain;
  final VoidCallback onExit;

  bool _isThisRound(TriviaScore s) =>
      playedAt != null &&
      s.playedAt.difference(playedAt!).abs() < const Duration(seconds: 2) &&
      s.score == score;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final l10n = context.l10n;
    final width = MediaQuery.sizeOf(context).width;
    final slug = lastPokemon.types.isEmpty
        ? 'normal'
        : lastPokemon.types.first.slug;
    return ListView(
      padding: const EdgeInsets.only(bottom: Gaps.section),
      children: [
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.paddingOf(context).top + Gaps.section,
            bottom: 40,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: typeColor(slug),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(width / 2, 64),
            ),
          ),
          child: PokemonImage(
            artworkFile: lastPokemon.artworkFile,
            spriteFile: lastPokemon.spriteFile,
            networkUrl: null,
            size: 150,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            Gaps.screen,
            Gaps.section,
            Gaps.screen,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(
                header: true,
                child: Text(
                  l10n.triviaFinished,
                  textAlign: TextAlign.center,
                  style: context.text.headlineMedium,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  Text(
                    l10n.gamesTriviaFinalScore(score),
                    style: context.text.titleSmall?.copyWith(color: t.body),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: t.sf2,
                      borderRadius: BorderRadius.circular(Radii.pill),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Text(
                        l10n.triviaResult(correct, total),
                        style: context.text.labelLarge,
                      ),
                    ),
                  ),
                ],
              ),
              if (newAchievements.isNotEmpty) ...[
                const SizedBox(height: Gaps.section),
                Text(
                  l10n.gamesTriviaNewAchievements,
                  style: context.text.titleMedium,
                ),
                const SizedBox(height: Gaps.sibling),
                LayoutBuilder(
                  builder: (context, box) {
                    final cardWidth = (box.maxWidth - 24) / 3;
                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        for (final a in newAchievements)
                          _AchievementCard(width: cardWidth, achievement: a),
                      ],
                    );
                  },
                ),
              ],
              if (ranking.isNotEmpty) ...[
                const SizedBox(height: Gaps.section),
                Text(
                  l10n.gamesTriviaRankingTitle,
                  style: context.text.titleMedium,
                ),
                const SizedBox(height: 8),
                for (final (i, s) in ranking.indexed)
                  RankingRow(
                    position: i + 1,
                    score: s,
                    highlighted: _isThisRound(s),
                  ),
              ],
              const SizedBox(height: Gaps.section),
              PokedexKey(label: l10n.playAgain, onPressed: onPlayAgain),
              const SizedBox(height: 8),
              PokedexKey(
                label: l10n.gamesBack,
                kind: PokedexKeyKind.outline,
                onPressed: onExit,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AchievementCard extends StatelessWidget {
  const _AchievementCard({required this.width, required this.achievement});

  final double width;
  final Achievement achievement;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final name = achievementName(context.l10n, achievement);
    return Semantics(
      container: true,
      label: name,
      excludeSemantics: true,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        decoration: BoxDecoration(
          color: t.sf,
          borderRadius: BorderRadius.circular(Radii.surface),
          border: Border.all(color: t.ln),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: t.acTinte,
                shape: BoxShape.circle,
              ),
              child: Icon(
                achievementIcon(achievement),
                size: 22,
                color: t.acTexto,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: context.text.labelLarge?.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
