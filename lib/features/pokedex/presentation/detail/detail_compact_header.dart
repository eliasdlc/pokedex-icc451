import 'package:flutter/material.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../shared/l10n_x.dart';
import '../../domain/entities/art_sources.dart';
import '../../domain/entities/pokemon_summary.dart';
import 'detail_hero.dart';
import 'pokemon_art.dart';

class DetailCompactHeader extends StatelessWidget {
  const DetailCompactHeader({
    super.key,
    required this.pokemon,
    required this.number,
    required this.selection,
    required this.isFavorite,
    required this.onFavorite,
    required this.onBack,
    required this.onCry,
    required this.tabs,
  });

  final PokemonSummary pokemon;
  final String number;
  final ArtSelection selection;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onBack;
  final VoidCallback? onCry;
  final Widget tabs;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final l10n = context.l10n;
    return ColoredBox(
      color: t.bg,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 48,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DetailBarButton(
                        icon: Icons.chevron_left_rounded,
                        label: MaterialLocalizations.of(context)
                            .backButtonTooltip,
                        onTap: onBack,
                        overlay: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 52, right: 100),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: _Title(
                            pokemon: pokemon,
                            number: number,
                            selection: selection,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DetailBarButton(
                            icon: Icons.volume_up_rounded,
                            label: onCry == null
                                ? l10n.detailCryUnavailable
                                : l10n.detailCryReplay,
                            onTap: onCry,
                            overlay: false,
                          ),
                          DetailBarButton(
                            icon: isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            label: isFavorite
                                ? l10n.removeFavorite
                                : l10n.addFavorite,
                            onTap: onFavorite,
                            overlay: false,
                            color: isFavorite ? t.danger : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              tabs,
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.pokemon,
    required this.number,
    required this.selection,
  });
  final PokemonSummary pokemon;
  final String number;
  final ArtSelection selection;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Semantics(
      header: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PokemonArt(
            url: selection.url,
            size: 40,
            summary: pokemon,
            pixelArt: selection.shown == ArtMode.pixel,
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                pokemon.localizedName(context.languageCode),
                maxLines: 1,
                style: context.text.titleMedium,
              ),
              Text(
                number,
                style: context.text.bodySmall?.copyWith(color: t.mute),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
