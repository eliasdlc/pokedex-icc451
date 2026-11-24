import 'package:flutter/material.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../shared/pixel_scale.dart';
import '../../../../shared/widgets/pokemon_image.dart';
import '../../../pokedex/domain/entities/pokemon_summary.dart';

class SilhouetteStage extends StatelessWidget {
  const SilhouetteStage({
    super.key,
    required this.pokemon,
    required this.revealed,
    this.reduceMotion = false,
  });

  final PokemonSummary pokemon;
  final bool revealed;

  final bool reduceMotion;

  static const diameter = 250.0;

  /// Una caja de 210 a 230 deja el dibujo (35 a 80 px de 96) en el 70 % del círculo
  /// sin que un Pokémon de alas abiertas se salga.
  static const _spriteMax = 230.0;

  static const _artworkSize = 200.0;

  @override
  Widget build(BuildContext context) {
    // Sin ilustración se amplía el sprite de 96 px por factor entero y sin suavizar.
    final isPixelArt = pokemon.artworkFile == null;
    final imageSize = isPixelArt
        ? pixelSpriteSize(
            MediaQuery.devicePixelRatioOf(context),
            maxLogical: _spriteMax,
          )
        : _artworkSize;
    return Container(
      width: diameter,
      height: diameter,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.tokens.sf2,
        shape: BoxShape.circle,
      ),
      child: AnimatedSwitcher(
        duration: reduceMotion
            ? Duration.zero
            : const Duration(milliseconds: 300),
        // Lo que sobra de la caja es margen transparente, no dibujo.
        child: OverflowBox(
          key: ValueKey('${pokemon.id}-$revealed'),
          maxWidth: imageSize,
          maxHeight: imageSize,
          child: PokemonImage(
            artworkFile: pokemon.artworkFile,
            spriteFile: pokemon.spriteFile,
            networkUrl: null,
            size: imageSize,
            pixelArt: isPixelArt,
            silhouette: !revealed,
          ),
        ),
      ),
    );
  }
}
