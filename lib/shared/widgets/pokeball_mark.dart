import 'package:flutter/material.dart';

class PokeballMark extends StatelessWidget {
  const PokeballMark({super.key, required this.color, this.size = 96});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: CustomPaint(
        size: Size.square(size),
        painter: _PokeballPainter(color),
      ),
    );
  }
}

class _PokeballPainter extends CustomPainter {
  const _PokeballPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final unit = size.width / 100;
    final center = size.center(Offset.zero);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8 * unit;
    canvas.drawCircle(center, 46 * unit, paint);
    final gap = 20 * unit;
    canvas.drawLine(
      Offset(4 * unit, center.dy),
      Offset(center.dx - gap, center.dy),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx + gap, center.dy),
      Offset(96 * unit, center.dy),
      paint,
    );
    canvas.drawCircle(center, 15 * unit, paint);
    canvas.drawCircle(center, 6 * unit, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_PokeballPainter old) => old.color != color;
}
