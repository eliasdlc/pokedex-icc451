import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../app/theme/app_tokens.dart';
import '../l10n_x.dart';

/// Muestra la mejor imagen disponible, en este orden:
///   1. archivo local de la imagen oficial
///   2. archivo local del sprite (respaldo)
///   3. red (solo si hay conexión; si falla, cae al siguiente)
///   4. marcador "Imagen no disponible sin conexión"
///
/// `cacheWidth` decodifica la imagen al tamaño en que se pinta: un PNG de
/// 475 px en una tarjeta de 120 px no ocupa la memoria de 475 px (RNF de
/// uso responsable de memoria).
///
/// Con `pixelArt` (sprites de píxeles, incluidos los GIF animados) la imagen
/// se amplía sin suavizado (`FilterQuality.none`): cada píxel sigue siendo un
/// cuadrado nítido. Las ilustraciones y los renders 3D usan filtro medio.
class PokemonImage extends StatelessWidget {
  const PokemonImage({
    super.key,
    required this.artworkFile,
    required this.spriteFile,
    required this.networkUrl,
    required this.size,
    this.silhouette = false,
    this.preferSprite = false,
    this.pixelArt = false,
    this.semanticLabel,
  });

  final String? artworkFile;
  final String? spriteFile;
  final String? networkUrl;
  final double size;
  final bool silhouette;
  final bool preferSprite;
  final bool pixelArt;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final quality = pixelArt ? FilterQuality.none : FilterQuality.medium;
    final cache = (size * MediaQuery.devicePixelRatioOf(context)).round();
    final files = preferSprite
        ? [spriteFile, artworkFile]
        : [artworkFile, spriteFile];
    final local = files.whereType<String>().firstOrNull;
    final fallback = _Unavailable(size: size);

    Widget image;
    if (local != null && !kIsWeb) {
      image = Image.file(
        File(local),
        width: size,
        height: size,
        cacheWidth: cache,
        fit: BoxFit.contain,
        filterQuality: quality,
        // Al cambiar de imagen no parpadea el hueco vacío.
        gaplessPlayback: true,
        errorBuilder: (_, _, _) => fallback,
      );
    } else if (networkUrl != null) {
      image = Image.network(
        networkUrl!,
        width: size,
        height: size,
        cacheWidth: cache,
        fit: BoxFit.contain,
        filterQuality: quality,
        gaplessPlayback: true,
        errorBuilder: (_, _, _) => fallback,
      );
    } else {
      image = fallback;
    }

    if (silhouette) {
      image = ColorFiltered(
        colorFilter: ColorFilter.mode(context.tokens.ink, BlendMode.srcIn),
        child: image,
      );
    }
    return Semantics(image: true, label: semanticLabel, child: image);
  }
}

class _Unavailable extends StatelessWidget {
  const _Unavailable({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: size,
    child: Tooltip(
      message: context.l10n.imageUnavailable,
      child: Icon(
        Icons.image_not_supported_outlined,
        size: size * 0.32,
        color: context.tokens.mute,
        semanticLabel: context.l10n.imageUnavailable,
      ),
    ),
  );
}
