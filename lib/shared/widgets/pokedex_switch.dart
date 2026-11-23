import 'package:flutter/material.dart';

import '../../app/theme/app_tokens.dart';
import '../../app/theme/shell_tokens.dart';

/// Interruptor de la carcasa: solo dibuja; la fila que lo contiene lleva el toque y la semántica.
class PokedexSwitch extends StatelessWidget {
  const PokedexSwitch({super.key, required this.value});

  final bool value;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final shell = context.shell;
    return ExcludeSemantics(
      child: SizedBox(
        width: 48,
        height: 48,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: 40,
            height: 24,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: value ? t.ac : t.ln,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: value ? shell.trazo : shell.contorno,
                width: 2,
              ),
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 120),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: t.on,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const SizedBox.square(dimension: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
