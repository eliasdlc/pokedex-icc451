import 'package:flutter/material.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../shared/l10n_x.dart';

class PokedexProgress extends StatelessWidget {
  const PokedexProgress({
    super.key,
    required this.saved,
    required this.total,
    this.onTap,
  });

  final int saved;
  final int total;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final l10n = context.l10n;
    final value = l10n.gamesHubProgressValue(saved, total);
    return Semantics(
      container: true,
      button: onTap != null,
      label: '${l10n.gamesHubProgressTitle}: $value',
      excludeSemantics: true,
      child: Material(
        color: t.sf2,
        borderRadius: BorderRadius.circular(Radii.surface),
        child: InkWell(
          borderRadius: BorderRadius.circular(Radii.surface),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(Gaps.inside),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.gamesHubProgressTitle,
                      style: context.text.labelLarge,
                    ),
                    Text(
                      value,
                      style: context.text.labelLarge?.copyWith(
                        color: t.acTexto,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: SizedBox(
                    height: 8,
                    child: Stack(
                      children: [
                        Positioned.fill(child: ColoredBox(color: t.ln)),
                        FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          heightFactor: 1,
                          widthFactor: total <= 0
                              ? 0
                              : (saved / total).clamp(0.0, 1.0),
                          child: ColoredBox(color: t.ac),
                        ),
                      ],
                    ),
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
