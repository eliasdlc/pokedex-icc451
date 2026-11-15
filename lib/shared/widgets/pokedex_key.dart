import 'package:flutter/material.dart';

import '../../app/theme/app_tokens.dart';
import '../../app/theme/shell_tokens.dart';

enum PokedexKeyKind { primary, outline, destructive }

/// El botón de la app con forma de tecla de la Pokédex: al tocarla baja hasta tapar su sombra.
/// `onPressed` en null la deja deshabilitada.
class PokedexKey extends StatefulWidget {
  const PokedexKey({
    super.key,
    required String this.label,
    required this.onPressed,
    this.kind = PokedexKeyKind.primary,
  }) : fill = null,
       outline = null,
       child = null,
       semanticLabel = null,
       height = 52;

  /// Tecla con color y contenido propios: las respuestas de la trivia y los ataques.
  const PokedexKey.custom({
    super.key,
    required Color this.fill,
    required Color this.outline,
    required Widget this.child,
    required String this.semanticLabel,
    required this.onPressed,
    this.height = 52,
  }) : label = null,
       kind = PokedexKeyKind.primary;

  final String? label;
  final VoidCallback? onPressed;
  final PokedexKeyKind kind;
  final Color? fill;
  final Color? outline;
  final Widget? child;
  final String? semanticLabel;
  final double height;

  static const depth = 4.0;

  @override
  State<PokedexKey> createState() => _PokedexKeyState();
}

class _PokedexKeyState extends State<PokedexKey> {
  bool _pressed = false;

  void _press(bool value) {
    if (widget.onPressed != null) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final shell = context.shell;
    final enabled = widget.onPressed != null;
    final custom = widget.child != null;
    final (fill, outline, ink) = custom
        ? (widget.fill!, widget.outline!, t.ink)
        : !enabled
        ? (t.sf2, t.mute, t.mute)
        : switch (widget.kind) {
            PokedexKeyKind.primary => (t.ac, shell.trazo, t.on),
            PokedexKeyKind.outline => (t.sf2, shell.contorno, t.ink),
            PokedexKeyKind.destructive => (t.danger, shell.trazo, t.on),
          };
    final raised = (enabled || custom) && !_pressed;
    final down = raised ? 0.0 : PokedexKey.depth;
    return Semantics(
      button: true,
      enabled: enabled,
      label: widget.semanticLabel ?? widget.label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onPressed,
        onTapDown: (_) => _press(true),
        onTapUp: (_) => _press(false),
        onTapCancel: () => _press(false),
        child: Padding(
          padding: EdgeInsets.only(top: down, bottom: PokedexKey.depth - down),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 60),
            height: widget.height,
            padding: EdgeInsets.symmetric(horizontal: custom ? 12 : 24),
            decoration: BoxDecoration(
              color: fill,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: outline, width: 2),
              boxShadow: [
                if (raised)
                  BoxShadow(
                    color: shell.trazo,
                    offset: const Offset(0, PokedexKey.depth),
                  ),
              ],
            ),
            // Mide lo que su texto salvo que el padre le imponga un ancho.
            child: Center(
              widthFactor: 1,
              child:
                  widget.child ??
                  Text(
                    widget.label!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Tiny5',
                      fontSize: 18,
                      height: 1.2,
                      color: ink,
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
