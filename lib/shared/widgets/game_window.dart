import 'package:flutter/material.dart';

import '../../app/theme/app_tokens.dart';

class GameWindow extends StatelessWidget {
  const GameWindow({
    super.key,
    required this.child,
    this.radius = 14,
    this.padding = EdgeInsets.zero,
    this.elevated = false,
  });

  final Widget child;

  final double radius;
  final EdgeInsetsGeometry padding;

  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      decoration: BoxDecoration(
        color: t.sf,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: t.marco, width: 3),
        boxShadow: elevated ? t.shadow : null,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius - 4),
                  border: Border.all(color: t.marco2, width: 2),
                ),
              ),
            ),
          ),
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }
}
