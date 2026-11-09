import 'package:flutter/material.dart';

import '../../app/theme/app_tokens.dart';
import '../l10n_x.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onToggle,
    this.overlay = false,
  });

  final bool isFavorite;
  final VoidCallback onToggle;
  final bool overlay;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 360),
  );

  late final Animation<double> _scale = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(
        begin: 1.0,
        end: 1.3,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 35,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 1.3,
        end: 1.0,
      ).chain(CurveTween(curve: Curves.bounceOut)),
      weight: 65,
    ),
  ]).animate(_controller);

  @override
  void didUpdateWidget(FavoriteButton old) {
    super.didUpdateWidget(old);
    if (widget.isFavorite && !old.isFavorite) {
      if (MediaQuery.disableAnimationsOf(context)) return;
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final on = widget.isFavorite;
    final diameter = widget.overlay ? 40.0 : 30.0;
    final glyph = widget.overlay ? 24.0 : 16.0;
    final l10n = context.l10n;
    return Semantics(
      button: true,
      toggled: on,
      label: on ? l10n.removeFavorite : l10n.addFavorite,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onToggle,
        child: SizedBox.square(
          dimension: 48,
          child: Center(
            child: Container(
              width: diameter,
              height: diameter,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: on
                    ? Colors.white
                    : Colors.black.withValues(
                        alpha: widget.overlay ? 0.32 : 0.12,
                      ),
                border: widget.overlay
                    ? null
                    : Border.all(color: Colors.white, width: 1.5),
              ),
              child: ScaleTransition(
                scale: _scale,
                child: Icon(
                  on ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  size: glyph,
                  color: on ? AppTokens.light.danger : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
