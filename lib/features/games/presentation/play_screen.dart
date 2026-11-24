import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/di/providers.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../shared/l10n_x.dart';
import '../../../shared/widgets/pokedex_header.dart';
import '../../pokedex/presentation/favorites/favorites_screen.dart';
import '../domain/achievements.dart';
import 'trivia_screen.dart';
import 'widgets/game_card.dart';
import 'widgets/pokedex_progress.dart';

class PlayScreen extends ConsumerWidget {
  const PlayScreen({super.key, this.onOpenCatalog});

  final VoidCallback? onOpenCatalog;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final indicator = ref.watch(indicatorProvider);
    final total = indicator.remoteTotal;
    // Fuera de build (ref.listen): build debe ser puro.
    ref.listen(favoritesProvider, (_, next) {
      if ((next.value?.length ?? 0) >= 10) {
        unawaited(
          ref
              .read(gamificationRepositoryProvider)
              .unlock(Achievement.collector10),
        );
      }
    });

    return Scaffold(
      appBar: PokedexHeader(title: l10n.playTitle),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          Gaps.screen,
          Gaps.screen,
          Gaps.screen,
          Gaps.navClearance,
        ),
        children: [
          // Sin total del catálogo (primer arranque sin red) no hay progreso que mostrar.
          if (total != null && total > 0) ...[
            PokedexProgress(
              saved: indicator.localCount,
              total: total,
              onTap: onOpenCatalog,
            ),
            const SizedBox(height: Gaps.sibling),
          ],
          GameCard(
            typeSlug: 'water',
            title: l10n.gamesTriviaCardTitle,
            body: l10n.gamesTriviaCardBody,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => const TriviaScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
