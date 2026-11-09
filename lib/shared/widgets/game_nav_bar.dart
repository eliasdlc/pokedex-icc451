import 'package:flutter/material.dart';

import '../../app/theme/app_tokens.dart';
import '../l10n_x.dart';
import 'game_window.dart';
import 'pixel_icon.dart';

enum NavTab { pokedex, regions, play, favorites, profile }

class GameNavBar extends StatelessWidget {
  const GameNavBar({super.key, required this.current, required this.onSelect});

  final NavTab current;
  final ValueChanged<NavTab> onSelect;

  static const _height = 92.0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final labels = {
      NavTab.pokedex: l10n.navPokedex,
      NavTab.regions: l10n.regionsTitle,
      NavTab.play: l10n.navPlay,
      NavTab.favorites: l10n.navFavorites,
      NavTab.profile: l10n.baseNavProfile,
    };
    Widget tab(NavTab which, PixelIconKind icon) => Expanded(
      child: _NavTabButton(
        label: labels[which]!,
        icon: icon,
        selected: current == which,
        onTap: () => onSelect(which),
      ),
    );
    return SafeArea(
      top: false,
      child: MediaQuery.withClampedTextScaling(
        maxScaleFactor: 1.2,
        child: SizedBox(
          height: _height,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 12,
                right: 12,
                bottom: 6,
                height: 64,
                child: GameWindow(
                  radius: 22,
                  elevated: true,
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Row(
                    children: [
                      tab(NavTab.pokedex, PixelIconKind.pokedex),
                      tab(NavTab.regions, PixelIconKind.regions),
                      // Hueco del botón central, que se dibuja encima.
                      const Spacer(),
                      tab(NavTab.favorites, PixelIconKind.favorites),
                      tab(NavTab.profile, PixelIconKind.profile),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: _PlayButton(
                  label: labels[NavTab.play]!,
                  selected: current == NavTab.play,
                  onTap: () => onSelect(NavTab.play),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavTabButton extends StatelessWidget {
  const _NavTabButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final PixelIconKind icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            width: 66,
            height: 54,
            decoration: BoxDecoration(
              color: selected ? t.acTinte : null,
              borderRadius: BorderRadius.circular(16),
              border: selected ? Border.all(color: t.ac, width: 2) : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PixelIcon(kind: icon, active: selected),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: context.gameTextSmall.copyWith(
                    height: 15 / 13,
                    color: selected ? t.ink : t.mute,
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

class _PlayButton extends StatelessWidget {
  const _PlayButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: 72,
          height: 84,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? t.acTinte : t.sf,
                  border: Border.all(
                    color: selected ? t.ac : t.marco,
                    width: 3,
                  ),
                  boxShadow: t.shadow,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Filete interior, como en las ventanas.
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: t.marco2, width: 2),
                          ),
                        ),
                      ),
                    ),
                    const PixelIcon(kind: PixelIconKind.play, scale: 3),
                  ],
                ),
              ),
              Positioned(
                top: 63,
                child: Text(
                  label,
                  maxLines: 1,
                  style: context.gameTextSmall.copyWith(
                    height: 16 / 13,
                    color: selected ? t.ink : t.mute,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
