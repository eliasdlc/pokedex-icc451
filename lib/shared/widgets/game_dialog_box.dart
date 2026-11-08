import 'package:flutter/material.dart';

import '../../app/theme/app_tokens.dart';
import '../l10n_x.dart';
import 'game_window.dart';

class GameDialogBox extends StatelessWidget {
  const GameDialogBox({
    super.key,
    required this.text,
    this.onContinue,
    this.showArrow = true,
  });

  final String text;
  final VoidCallback? onContinue;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final box = GameWindow(
      padding: const EdgeInsets.fromLTRB(24, 20, 40, 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              text,
              style: context.gameTextLarge.copyWith(
                height: 26 / 20,
                // Sombra dura (sin desenfoque), la firma del texto de juego.
                shadows: [Shadow(color: t.marco2, offset: const Offset(2, 2))],
              ),
            ),
          ),
          if (showArrow)
            const Positioned(right: -30, bottom: -12, child: _BlinkingArrow()),
        ],
      ),
    );
    if (onContinue == null) return box;
    return Semantics(
      button: true,
      hint: context.l10n.baseContinue,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onContinue,
        child: box,
      ),
    );
  }
}

class _BlinkingArrow extends StatefulWidget {
  const _BlinkingArrow();

  @override
  State<_BlinkingArrow> createState() => _BlinkingArrowState();
}

class _BlinkingArrowState extends State<_BlinkingArrow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
      _controller.value = 1;
    } else if (!_controller.isAnimating) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: FadeTransition(
        opacity: Tween(begin: 0.25, end: 1.0).animate(_controller),
        child: CustomPaint(
          size: const Size(14, 8),
          painter: _ArrowPainter(context.tokens.acTexto),
        ),
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  const _ArrowPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_ArrowPainter old) => old.color != color;
}
