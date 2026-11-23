import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../app/theme/app_tokens.dart';
import '../../app/theme/shell_tokens.dart';
import '../l10n_x.dart';

enum NavTab { pokedex, regions, play, favorites, profile }

/// Solo iconos: cada destino lleva su nombre como etiqueta semántica y tooltip.
/// Flota sobre el contenido: las listas dejan `Gaps.navClearance` de relleno inferior.
class PokeballNavbar extends StatelessWidget {
  const PokeballNavbar({
    super.key,
    required this.current,
    required this.onSelect,
  });

  final NavTab current;
  final ValueChanged<NavTab> onSelect;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final shell = context.shell;
    final l10n = context.l10n;
    final labels = {
      NavTab.pokedex: l10n.navPokedex,
      NavTab.regions: l10n.regionsTitle,
      NavTab.play: l10n.navPlay,
      NavTab.favorites: l10n.navFavorites,
      NavTab.profile: l10n.baseNavProfile,
    };
    final bottom = math.max(18.0, MediaQuery.viewPaddingOf(context).bottom);
    Widget tab(NavTab which) => _Destination(
      label: labels[which]!,
      selected: current == which,
      onTap: () => onSelect(which),
      child: SizedBox.square(
        dimension: 28,
        child: CustomPaint(
          painter: _NavIconPainter(
            which,
            color: current == which,
            mute: t.mute,
            ink: t.ink,
          ),
        ),
      ),
    );
    return SizedBox(
      height: 78 + bottom,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Velo de dos franjas: el contenido se apaga antes de llegar a la píldora.
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 4,
            child: ColoredBox(color: t.bg.withValues(alpha: 0.4)),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 4,
            height: 4,
            child: ColoredBox(color: t.bg.withValues(alpha: 0.8)),
          ),
          Positioned.fill(top: 8, child: ColoredBox(color: t.bg)),
          Positioned(
            left: 12,
            right: 12,
            top: 10,
            height: 64,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: shell.rojo,
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            top: 14,
            height: 64,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: t.sf,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: t.ln),
                boxShadow: [
                  if (t.shadow.isNotEmpty)
                    const BoxShadow(
                      color: Color(0x24000000),
                      blurRadius: 16,
                      offset: Offset(0, 6),
                    ),
                ],
              ),
              child: Row(
                children: [
                  tab(NavTab.pokedex),
                  tab(NavTab.regions),
                  const Spacer(),
                  tab(NavTab.favorites),
                  tab(NavTab.profile),
                ],
              ),
            ),
          ),
          Positioned(
            top: 2,
            left: 0,
            right: 0,
            child: Center(
              child: _PlayButton(
                label: labels[NavTab.play]!,
                selected: current == NavTab.play,
                onTap: () => onSelect(NavTab.play),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Destination extends StatelessWidget {
  const _Destination({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.child,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      excludeFromSemantics: true,
      child: Semantics(
        button: true,
        selected: selected,
        label: label,
        excludeSemantics: true,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: SizedBox(
            width: 70,
            height: 64,
            child: Stack(
              alignment: Alignment.center,
              children: [
                child,
                if (selected)
                  const Positioned(bottom: 7, child: _ActiveLight()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActiveLight extends StatelessWidget {
  const _ActiveLight();

  @override
  Widget build(BuildContext context) => Container(
    width: 5,
    height: 5,
    decoration: BoxDecoration(
      color: context.shell.rojo,
      shape: BoxShape.circle,
    ),
  );
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
    final shell = context.shell;
    return Tooltip(
      message: label,
      excludeFromSemantics: true,
      child: Semantics(
        button: true,
        selected: selected,
        label: label,
        excludeSemantics: true,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: SizedBox(
            width: 60,
            height: 72,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: shell.rojo,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    width: 52,
                    height: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: t.sf,
                      shape: BoxShape.circle,
                    ),
                    child: const SizedBox.square(
                      dimension: 36,
                      child: CustomPaint(
                        painter: _NavIconPainter(NavTab.play, color: true),
                      ),
                    ),
                  ),
                ),
                if (selected)
                  const Positioned(bottom: 3, child: _ActiveLight()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Los iconos del navbar en su caja de 28 de Figma. La versión a color es la
/// pestaña activa; la de línea, en `mute`, las demás. La Pokébola siempre va a color.
class _NavIconPainter extends CustomPainter {
  const _NavIconPainter(this.tab, {required this.color, this.mute, this.ink});

  final NavTab tab;
  final bool color;
  final Color? mute;

  /// Contorno de la versión a color. Va con el tema: el `_ink` fijo desaparece
  /// sobre la barra oscura y el perfil, que casi no tiene relleno, se pierde.
  final Color? ink;

  // Colores propios de los iconos, iguales en los dos temas.
  static const _ink = Color(0xFF1B1B25);
  static const _red = Color(0xFFDC3038);
  static const _white = Color(0xFFFFFFFF);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 28);
    final line = color ? ink ?? _ink : mute!;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = line;
    void fill(Path path, Color fill) =>
        canvas.drawPath(path, Paint()..color = fill);
    void both(Path path, Color? fillColor) {
      if (color && fillColor != null) fill(path, fillColor);
      canvas.drawPath(path, stroke);
    }

    Path circle(double x, double y, double r) =>
        Path()..addOval(Rect.fromCircle(center: Offset(x, y), radius: r));

    switch (tab) {
      case NavTab.pokedex:
        both(
          Path()..addRRect(
            RRect.fromLTRBR(4, 3, 24, 25, const Radius.circular(4.5)),
          ),
          _red,
        );
        both(circle(10, 9.5, 3), const Color(0xFF4AA8F0));
        fill(circle(16.5, 8, 1.2), color ? const Color(0xFFFFD43B) : line);
        fill(circle(20, 8, 1.2), color ? const Color(0xFF6BD67A) : line);
        both(
          Path()..addRRect(
            RRect.fromLTRBR(8, 15, 20, 22, const Radius.circular(1.5)),
          ),
          const Color(0xFFD6ECB0),
        );
      case NavTab.regions:
        both(
          Path()
            ..moveTo(3, 8)
            ..lineTo(10, 5)
            ..lineTo(18, 8)
            ..lineTo(25, 5)
            ..lineTo(25, 21)
            ..lineTo(18, 24)
            ..lineTo(10, 21)
            ..lineTo(3, 24)
            ..close(),
          const Color(0xFFBFE5A8),
        );
        canvas.drawPath(
          Path()
            ..moveTo(10, 5)
            ..lineTo(10, 21)
            ..moveTo(18, 8)
            ..lineTo(18, 24),
          stroke,
        );
        fill(
          Path()
            ..moveTo(14, 9)
            ..cubicTo(12.5, 9, 11.4, 10.1, 11.4, 11.6)
            ..cubicTo(11.4, 13.5, 14, 16.5, 14, 16.5)
            ..cubicTo(14, 16.5, 16.6, 13.5, 16.6, 11.6)
            ..cubicTo(16.6, 10.1, 15.5, 9, 14, 9)
            ..close(),
          color ? _red : line,
        );
      case NavTab.favorites:
        both(
          Path()
            ..moveTo(14, 23.5)
            ..cubicTo(6, 18, 3.5, 13.5, 3.5, 10)
            ..cubicTo(3.5, 6.8, 6, 4.5, 9, 4.5)
            ..cubicTo(11.2, 4.5, 13, 5.7, 14, 7.6)
            ..cubicTo(15, 5.7, 16.8, 4.5, 19, 4.5)
            ..cubicTo(22, 4.5, 24.5, 6.8, 24.5, 10)
            ..cubicTo(24.5, 13.5, 22, 18, 14, 23.5)
            ..close(),
          _red,
        );
        if (color) {
          canvas.drawPath(
            Path()
              ..moveTo(8.2, 8.6)
              ..cubicTo(9, 7.5, 10.1, 7, 11.3, 7.2),
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.6
              ..strokeCap = StrokeCap.round
              ..color = _white,
          );
        }
      case NavTab.profile:
        both(
          Path()
            ..moveTo(5.5, 24.5)
            ..cubicTo(5.5, 20.1, 9.3, 17.5, 14, 17.5)
            ..cubicTo(18.7, 17.5, 22.5, 20.1, 22.5, 24.5)
            ..close(),
          const Color(0xFF2F6FE0),
        );
        final head = circle(14, 10.5, 4.6);
        if (color) {
          fill(head, const Color(0xFFF6C9A0));
          canvas.save();
          canvas.clipRect(const Rect.fromLTRB(0, 0, 28, 9.6));
          fill(head, _red);
          canvas.restore();
        }
        canvas.drawPath(head, stroke);
        canvas.drawLine(
          Offset(color ? 18.6 : 9.4, 9.6),
          const Offset(22.6, 9.6),
          stroke,
        );
      case NavTab.play:
        final outer = circle(14, 14, 10.5);
        fill(outer, _white);
        fill(
          Path()
            ..moveTo(3.5, 14)
            ..arcTo(
              Rect.fromCircle(center: const Offset(14, 14), radius: 10.5),
              math.pi,
              math.pi,
              false,
            )
            ..close(),
          _red,
        );
        canvas.drawPath(outer, stroke);
        canvas.drawLine(const Offset(3.5, 14), const Offset(24.5, 14), stroke);
        final inner = circle(14, 14, 3.4);
        fill(inner, _white);
        canvas.drawPath(inner, stroke);
    }
  }

  @override
  bool shouldRepaint(_NavIconPainter old) =>
      old.tab != tab ||
      old.color != color ||
      old.mute != mute ||
      old.ink != ink;
}
