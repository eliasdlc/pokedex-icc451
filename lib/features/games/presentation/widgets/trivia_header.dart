import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/providers.dart';
import '../../../../app/theme/app_tokens.dart';
import '../../../../shared/l10n_x.dart';
import '../../../../shared/widgets/pokedex_header.dart';

class TriviaStatPill extends StatelessWidget {
  const TriviaStatPill({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor,
    this.semanticLabel,
  });

  final IconData icon;
  final String text;
  final Color? iconColor;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Semantics(
      container: true,
      label: semanticLabel ?? text,
      excludeSemantics: true,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: t.sf2,
          borderRadius: BorderRadius.circular(Radii.pill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: iconColor ?? t.ink),
            const SizedBox(width: 6),
            Text(
              text,
              style: context.text.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Las teclas ES y EN de la cabecera: cambian el idioma de toda la app.
class LanguageToggle extends ConsumerWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final english = context.languageCode == 'en';
    return HeaderLanguageKeys(
      english: english,
      onChanged: (value) {
        if (value == english) return;
        ref
            .read(settingsProvider.notifier)
            .setLocale(Locale(value ? 'en' : 'es'));
      },
    );
  }
}
