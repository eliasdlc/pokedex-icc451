import 'package:flutter/material.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../shared/l10n_x.dart';

class InfoNotice extends StatelessWidget {
  const InfoNotice({super.key, required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(Radii.block),
      ),
      child: Text(
        text,
        style: context.text.bodySmall?.copyWith(color: color, height: 1.5),
      ),
    );
  }
}

/// "PokéAPI no está respondiendo": hay red pero la API no contesta. Se ve
/// encima de la lista, que sigue mostrando lo guardado.
class ApiDownCard extends StatelessWidget {
  const ApiDownCard({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final l10n = context.l10n;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      decoration: BoxDecoration(
        color: t.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(Radii.surface),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.navegacionApiDownTitle,
            style: context.text.titleSmall?.copyWith(
              color: t.warning,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Text(l10n.navegacionApiDownBody, style: context.text.bodySmall),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
              ),
              onPressed: onRetry,
              child: Text(
                l10n.retryNow,
                style: context.text.labelLarge?.copyWith(color: t.acTexto),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
