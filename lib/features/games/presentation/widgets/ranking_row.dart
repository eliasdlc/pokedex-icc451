import 'package:flutter/material.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../shared/l10n_x.dart';
import '../../domain/gamification_repository.dart';

class RankingRow extends StatelessWidget {
  const RankingRow({
    super.key,
    required this.position,
    required this.score,
    this.highlighted = false,
  });

  final int position;
  final TriviaScore score;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final l10n = context.l10n;
    final label =
        '${l10n.triviaResult(score.correct, score.total)}, '
        '${timeAgo(l10n, score.playedAt)}';
    return Semantics(
      container: true,
      label: '$position. $label, ${l10n.gamesTriviaPoints(score.score)}',
      excludeSemantics: true,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: highlighted ? t.acTinte : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              child: Text(
                '$position',
                style: context.text.labelLarge?.copyWith(
                  color: highlighted ? t.acTexto : t.mute,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.text.bodyMedium?.copyWith(color: t.ink),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${score.score}',
              style: context.text.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
