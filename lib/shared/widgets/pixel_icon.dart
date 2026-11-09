import 'package:flutter/material.dart';

enum PixelIconKind { pokedex, regions, play, favorites, profile }

class PixelIcon extends StatelessWidget {
  const PixelIcon({
    super.key,
    required this.kind,
    this.active = true,
    this.scale = 2,
    this.semanticLabel,
  }) : assert(scale >= 1, 'La escala es un entero de 1 o más');

  final PixelIconKind kind;

  final bool active;

  final int scale;
  final String? semanticLabel;

  static const _grid = 16;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icons/${kind.name}_${active ? 'color' : 'gray'}.png',
      width: _grid * scale.toDouble(),
      height: _grid * scale.toDouble(),
      filterQuality: FilterQuality.none,
      fit: BoxFit.fill,
      isAntiAlias: false,
      semanticLabel: semanticLabel,
      excludeFromSemantics: semanticLabel == null,
    );
  }
}
