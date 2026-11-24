import 'package:flutter/material.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../app/theme/type_palette.dart';
import '../../../../shared/l10n_x.dart';
import '../../../../shared/widgets/type_chip.dart';

class GameCard extends StatelessWidget {
  const GameCard({
    super.key,
    required this.typeSlug,
    required this.title,
    required this.body,
    required this.onTap,
  });

  final String typeSlug;
  final String title;
  final String body;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final color = typeColor(typeSlug);
    final ink = inkOn(color);
    return Semantics(
      button: true,
      label: '$title. $body',
      excludeSemantics: true,
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 150),
            child: Stack(
              children: [
                Positioned(
                  right: -40,
                  top: -14,
                  child: TypeIcon(
                    slug: typeSlug,
                    size: 180,
                    color: ink.withValues(alpha: 0.16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.text.titleLarge?.copyWith(
                          color: ink,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 170,
                        child: Text(
                          body,
                          style: context.text.bodySmall?.copyWith(
                            color: ink.withValues(alpha: 0.9),
                            fontSize: 13,
                            height: 19 / 13,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: t.sf,
                          borderRadius: BorderRadius.circular(Radii.pill),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14, 6, 10, 6),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                context.l10n.gamesEnter,
                                style: context.text.labelLarge?.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(Icons.chevron_right, size: 16, color: t.ink),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
