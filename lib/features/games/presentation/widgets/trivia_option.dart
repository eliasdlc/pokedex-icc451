import 'package:flutter/material.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../app/theme/shell_tokens.dart';
import '../../../../shared/widgets/pokedex_key.dart';

enum TriviaOptionState { idle, correct, wrong, dimmed }

/// Cada respuesta es una tecla. El resultado nunca va solo en color: acierto y
/// error añaden un icono.
class TriviaOption extends StatelessWidget {
  const TriviaOption({
    super.key,
    required this.label,
    required this.state,
    required this.onTap,
  });

  final String label;
  final TriviaOptionState state;

  /// null: la opción ya no se puede tocar (se respondió o se acabó el tiempo).
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final shell = context.shell;
    final (fill, outline, ink, icon) = switch (state) {
      TriviaOptionState.idle => (t.sf2, shell.contorno, t.ink, null),
      TriviaOptionState.correct => (
        Color.alphaBlend(t.success.withValues(alpha: 0.16), t.sf),
        t.success,
        t.ink,
        Icons.check_circle,
      ),
      TriviaOptionState.wrong => (
        Color.alphaBlend(t.ac.withValues(alpha: 0.16), t.sf),
        t.ac,
        t.ink,
        Icons.cancel,
      ),
      TriviaOptionState.dimmed => (t.sf2, t.ln2, t.mute, null),
    };
    return PokedexKey.custom(
      fill: fill,
      outline: outline,
      semanticLabel: label,
      onPressed: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Un nombre largo se encoge en vez de cortarse, para poder leerlo.
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'Tiny5',
                  fontSize: 18,
                  height: 1.2,
                  color: ink,
                ),
              ),
            ),
          ),
          if (icon != null) ...[
            const SizedBox(width: 6),
            Icon(icon, size: 20, color: outline),
          ],
        ],
      ),
    );
  }
}
