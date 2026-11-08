import 'package:flutter/material.dart';

import '../../app/theme/app_tokens.dart';
import '../../app/theme/type_palette.dart';
import '../../features/pokedex/domain/entities/poke_type.dart';
import '../l10n_x.dart';
import 'type_icon_paths.dart';

class TypeIcon extends StatelessWidget {
  const TypeIcon({super.key, required this.slug, this.size = 24, this.color});

  final String slug;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: CustomPaint(
        size: Size.square(size),
        painter: _TypeIconPainter(slug, color ?? Colors.white),
      ),
    );
  }
}

class _TypeIconPainter extends CustomPainter {
  const _TypeIconPainter(this.slug, this.color);
  final String slug;
  final Color color;

  static final _paths = <String, Path>{};

  static Path? _pathFor(String slug) {
    final cached = _paths[slug];
    if (cached != null) return cached;
    final data = typeIconPaths[slug];
    if (data == null) return null;
    return _paths[slug] = _parse(data);
  }

  /// Lee el subconjunto de comandos que usan los iconos: M, L, C y Z.
  static Path _parse(String data) {
    final path = Path()..fillType = PathFillType.evenOdd;
    final tokens = RegExp(r'[MLCZ]|-?\d+(?:\.\d+)?').allMatches(data);
    final items = [for (final m in tokens) m.group(0)!];
    var i = 0;
    double next() => double.parse(items[i++]);
    while (i < items.length) {
      switch (items[i++]) {
        case 'M':
          path.moveTo(next(), next());
        case 'L':
          path.lineTo(next(), next());
        case 'C':
          path.cubicTo(next(), next(), next(), next(), next(), next());
        case 'Z':
          path.close();
      }
    }
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final path = _pathFor(slug);
    if (path == null) return;
    canvas.scale(size.width / 512, size.height / 512);
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_TypeIconPainter old) =>
      old.slug != slug || old.color != color;
}

enum TypeChipStyle { solid, glass }

class TypeChip extends StatelessWidget {
  const TypeChip(
    this.type, {
    super.key,
    this.compact = false,
    this.style = TypeChipStyle.solid,
    this.selected,
    this.onTap,
  });

  final PokeType type;

  final bool compact;
  final TypeChipStyle style;

  final bool? selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final slug = type.slug;
    final fore = onType(slug);
    final small = compact;
    final isSelected = selected ?? false;
    final glass = style == TypeChipStyle.glass;

    final circle = small ? 20.0 : 28.0;
    final glyph = small ? 12.0 : 16.0;
    final label = Text(
      type.localizedName(context.languageCode),
      maxLines: 1,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: small ? 12 : 14,
        color: fore,
      ),
    );

    final chip = AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      padding: EdgeInsets.fromLTRB(3, 3, small ? 10 : 16, 3),
      decoration: BoxDecoration(
        color: glass ? fore.withValues(alpha: 0.22) : typeColor(slug),
        borderRadius: BorderRadius.circular(Radii.pill),
        border: isSelected ? Border.all(color: t.acTexto, width: 2) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: circle,
            height: circle,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: glass ? null : Colors.white,
              shape: BoxShape.circle,
            ),
            child: TypeIcon(
              slug: slug,
              size: glyph,
              color: glass ? fore : typeColor(slug),
            ),
          ),
          SizedBox(width: small ? 5 : 8),
          label,
          if (isSelected) ...[
            const SizedBox(width: 4),
            Icon(Icons.check_rounded, size: small ? 14 : 18, color: fore),
          ],
        ],
      ),
    );
    if (onTap == null) return chip;
    return Semantics(
      button: true,
      selected: isSelected,
      child: InkWell(
        borderRadius: BorderRadius.circular(Radii.pill),
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Center(widthFactor: 1, child: chip),
        ),
      ),
    );
  }
}
