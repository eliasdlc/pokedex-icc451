import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../app/theme/type_palette.dart';
import '../../../../shared/l10n_x.dart';
import '../../../../shared/pixel_scale.dart';
import '../../../../shared/widgets/pokeball_mark.dart';
import '../../../../shared/widgets/pokemon_image.dart';
import '../../../../shared/widgets/type_chip.dart';
import '../../domain/entities/pokemon_summary.dart';

/// Tarjeta de lista (Figma "Tarjeta Pokémon v3"): un panel redondeado del color
/// de su primer tipo con el número, el nombre y los tipos a la izquierda, y el
/// sprite a la derecha asomando por encima del borde superior.
///
/// Mide [height] (120): 104 del panel más 16 de aire arriba para el sprite. El
/// sprite es mayor que esa caja y se sale de ella por arriba, así que la lista
/// que use esta tarjeta debe construirse con `Clip.none` y dejar [gap] entre
/// tarjetas para que un sprite no choque con la tarjeta de arriba.
class PokemonListCard extends StatelessWidget {
  const PokemonListCard({
    super.key,
    required this.pokemon,
    required this.onTap,
  });

  final PokemonSummary pokemon;
  final VoidCallback onTap;

  static const height = 120.0;

  static const gap = 12.0;

  static const extent = height + gap;

  static const _panelTop = 16.0;

  /// Alto de la tarjeta con el texto del sistema actual: [height] a 100 %, y
  /// más cuando el texto crece (RNF-ACC-04), medido con las mismas fuentes
  /// que dibuja la tarjeta. Reserva una línea de nombre y dos filas de tipos.
  static double heightOf(BuildContext context) {
    if (!_scaled(context)) return height;
    final scaler = MediaQuery.textScalerOf(context);
    final text = context.text;
    double line(TextStyle? style) {
      final painter = TextPainter(
        text: TextSpan(text: 'Ág', style: style),
        textScaler: scaler,
        textDirection: TextDirection.ltr,
      )..layout();
      final h = painter.height;
      painter.dispose();
      return h;
    }

    final chip = math.max(20.0, line(_typeLabelStyle)) + 6;
    final content =
        _contentTop +
        line(_numberStyle(text)) +
        _numberToName +
        line(_nameStyle(text)) +
        _nameToTypes +
        2 * chip +
        6 +
        _contentBottom;
    return math.max(height, _panelTop + content);
  }

  /// Lo que ocupa en una lista de alto fijo: tarjeta más aire.
  static double extentOf(BuildContext context) => heightOf(context) + gap;

  static const _spriteMax = 160.0;

  static const _artworkSize = 128.0;

  static const _spriteCenterFromRight = 75.0;
  static const _spriteCenterY = 56.0;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final slug = pokemon.types.first.slug;
    final hue = typeColor(slug);
    final ink = onType(slug);
    final name = pokemon.localizedName(context.languageCode);
    final isPixelArt =
        pokemon.spriteFile != null || pokemon.artworkFile == null;
    final spriteSize = isPixelArt
        ? pixelSpriteSize(
            MediaQuery.devicePixelRatioOf(context),
            maxLogical: _spriteMax,
          )
        : _artworkSize;

    final cardHeight = heightOf(context);

    return Semantics(
      button: true,
      label: '$name ${pokemon.nationalNumber}',
      excludeSemantics: true,
      onTap: onTap,
      child: SizedBox(
        height: cardHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: _panelTop,
              left: 0,
              right: 0,
              height: cardHeight - _panelTop,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: hue,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: t.shadow.isEmpty
                      ? null
                      : [
                          BoxShadow(
                            color: hue.withValues(alpha: 0.32),
                            blurRadius: 22,
                            spreadRadius: -8,
                            offset: const Offset(0, 10),
                          ),
                        ],
                ),
                child: Material(
                  type: MaterialType.transparency,
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(24),
                  child: InkWell(
                    onTap: onTap,
                    child: _PanelContent(
                      pokemon: pokemon,
                      name: name,
                      ink: ink,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: _spriteCenterY - spriteSize / 2,
              right: _spriteCenterFromRight - spriteSize / 2,
              width: spriteSize,
              height: spriteSize,
              child: IgnorePointer(
                child: Hero(
                  tag: 'pokemon-${pokemon.id}',
                  child: PokemonImage(
                    artworkFile: pokemon.artworkFile,
                    spriteFile: pokemon.spriteFile,
                    networkUrl: pokemon.spriteUrl,
                    preferSprite: true,
                    pixelArt: isPixelArt,
                    size: spriteSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Medidas y estilos que comparten el dibujo y PokemonListCard.heightOf: a
// 100 % suman las posiciones del Figma (número en 12, nombre en 30, tipos en 68).
const _contentTop = 12.0;
const _contentBottom = 10.0;
const _numberToName = 1.2;
const _nameToTypes = 12.0;
const _typeLabelStyle = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  fontSize: 12,
);

TextStyle? _numberStyle(TextTheme text) => text.labelMedium?.copyWith(
  fontWeight: FontWeight.w600,
  letterSpacing: 0.48,
);

TextStyle? _nameStyle(TextTheme text) =>
    text.titleLarge?.copyWith(letterSpacing: -0.2, height: 1.3);

bool _scaled(BuildContext context) =>
    MediaQuery.textScalerOf(context).scale(10) > 10;

class _PanelContent extends StatelessWidget {
  const _PanelContent({
    required this.pokemon,
    required this.name,
    required this.ink,
  });

  final PokemonSummary pokemon;
  final String name;
  final Color ink;

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final number = pokemon.id.toString().padLeft(3, '0');
    return Stack(
      children: [
        Positioned(
          right: -21,
          top: -30,
          child: PokeballMark(color: ink.withValues(alpha: 0.12), size: 156),
        ),
        Positioned(
          right: 15,
          top: 22,
          child: ExcludeSemantics(
            child: Text(
              number,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 60,
                height: 1.2,
                letterSpacing: -1.2,
                color: ink.withValues(alpha: 0.13),
              ),
            ),
          ),
        ),
        Positioned(
          right: 25,
          top: 86,
          width: 100,
          height: 14,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withValues(alpha: 0.12),
            ),
          ),
        ),
        // Número, nombre y tipos en columna: a 100 % caen en las mismas
        // posiciones del Figma (12, 30 y 68); con el texto del sistema más
        // grande empujan hacia abajo y la tarjeta crece (PokemonListCard.heightOf).
        Positioned(
          left: 20,
          top: _contentTop,
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Nº $number',
                    style: _numberStyle(text)
                        ?.copyWith(color: ink.withValues(alpha: 0.85)),
                  ),
                  if (pokemon.isFavorite) ...[
                    const SizedBox(width: 12),
                    Icon(Icons.favorite_rounded, size: 14, color: ink),
                  ],
                ],
              ),
              const SizedBox(height: _numberToName),
              SizedBox(
                width: 192,
                // Con texto grande el nombre se encoge lo justo para caber
                // entero en su línea: ni "Charman…" ni "Bulbasau / r".
                child: _scaled(context)
                    ? FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          name,
                          maxLines: 1,
                          style: _nameStyle(text)?.copyWith(color: ink),
                        ),
                      )
                    : Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: _nameStyle(text)?.copyWith(color: ink),
                      ),
              ),
              const SizedBox(height: _nameToTypes),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final type in pokemon.types)
                    TypeChip(type, compact: true, style: TypeChipStyle.glass),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
