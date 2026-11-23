import 'package:flutter/material.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../shared/l10n_x.dart';
import '../../domain/entities/art_sources.dart';

class ArtModeSwitch extends StatelessWidget {
  const ArtModeSwitch({
    super.key,
    required this.selection,
    required this.available,
    required this.onSelect,
    required this.inactiveInk,
  });

  final ArtSelection selection;

  final Set<ArtMode> available;
  final ValueChanged<ArtMode> onSelect;
  final Color inactiveInk;

  static String label(BuildContext context, ArtMode mode) => switch (mode) {
    ArtMode.pixel => context.l10n.detailArtPixel,
    ArtMode.illustration => context.l10n.detailArtIllustration,
    ArtMode.model3d => context.l10n.detailArt3d,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 258,
          height: 48,
          child: Stack(
            children: [
              Positioned.fill(
                top: 6,
                bottom: 6,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(Radii.pill),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Row(
                  children: [
                    for (final mode in ArtMode.values)
                      Expanded(
                        child: _Option(mode: mode, switcher: this),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: selection.usedFallback
              ? Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: _FallbackNote(selection: selection),
                )
              : const SizedBox(width: 258),
        ),
      ],
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({required this.mode, required this.switcher});
  final ArtMode mode;
  final ArtModeSwitch switcher;

  @override
  Widget build(BuildContext context) {
    final active = switcher.selection.shown == mode;
    final exists = switcher.available.contains(mode);
    return Semantics(
      button: true,
      selected: active,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => switcher.onSelect(mode),
        child: Container(
          // 48 - 2 x 9 = 30: la opción visible mide 30, la píldora 36.
          margin: const EdgeInsets.symmetric(vertical: 9),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? Colors.white : null,
            borderRadius: BorderRadius.circular(Radii.pill),
          ),
          child: Text(
            ArtModeSwitch.label(context, mode),
            maxLines: 1,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: active
                  ? const Color(0xFF111118)
                  : switcher.inactiveInk.withValues(alpha: exists ? 1 : 0.55),
            ),
          ),
        ),
      ),
    );
  }
}

class _FallbackNote extends StatelessWidget {
  const _FallbackNote({required this.selection});
  final ArtSelection selection;

  @override
  Widget build(BuildContext context) {
    final text = context.l10n.detailArtFallback(
      ArtModeSwitch.label(context, selection.requested),
      ArtModeSwitch.label(context, selection.shown),
    );
    return Semantics(
      liveRegion: true,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.32),
          borderRadius: BorderRadius.circular(Radii.pill),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
