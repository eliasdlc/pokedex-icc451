import 'package:flutter/material.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../shared/l10n_x.dart';
import '../../../../shared/widgets/pixel_icon.dart';
import '../../../../shared/widgets/pokedex_key.dart';

/// Texto en el idioma activo y, atenuado, el otro; ofrece reintentar o ver lo guardado.
class TriviaNoDataView extends StatelessWidget {
  const TriviaNoDataView({
    super.key,
    required this.have,
    required this.needed,
    required this.onRetry,
    required this.onOpenPokedex,
  });

  final int have;
  final int needed;

  /// null mientras se reintenta: evita dos descargas a la vez.
  final VoidCallback? onRetry;
  final VoidCallback onOpenPokedex;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final l10n = context.l10n;
    final spanish = context.languageCode == 'es';
    final otherLanguage = spanish
        ? l10n.gamesNoDataEn(needed, have)
        : l10n.gamesNoDataEs(needed, have);
    return LayoutBuilder(
      builder: (context, box) => SingleChildScrollView(
        padding: const EdgeInsets.all(Gaps.screen),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: box.maxHeight - 2 * 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 180,
                    height: 28,
                    decoration: BoxDecoration(
                      color: t.sf2,
                      borderRadius: BorderRadius.circular(90),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: PixelIcon(kind: PixelIconKind.play, scale: 6),
                  ),
                ],
              ),
              const SizedBox(height: Gaps.section),
              Semantics(
                header: true,
                child: Text(
                  l10n.gamesNoDataTitle,
                  textAlign: TextAlign.center,
                  style: context.text.titleMedium,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.gamesNoDataBody(needed, have),
                textAlign: TextAlign.center,
                style: context.text.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                otherLanguage,
                textAlign: TextAlign.center,
                style: context.text.bodySmall?.copyWith(color: t.mute),
              ),
              const SizedBox(height: Gaps.section),
              SizedBox(
                width: double.infinity,
                child: PokedexKey(
                  label: l10n.gamesRetryDownload,
                  onPressed: onRetry,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: PokedexKey(
                  label: l10n.gamesViewPokedex,
                  kind: PokedexKeyKind.outline,
                  onPressed: onOpenPokedex,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
