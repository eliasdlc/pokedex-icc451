import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/providers.dart';
import '../../../../core/media/media_cache.dart';
import '../../../../shared/widgets/pokeball_mark.dart';
import '../../../../shared/widgets/pokemon_image.dart';
import '../../domain/entities/pokemon_summary.dart';

class PokemonArt extends ConsumerWidget {
  const PokemonArt({
    super.key,
    required this.url,
    required this.size,
    this.summary,
    this.pixelArt = false,
  });

  final Uri url;
  final double size;

  final PokemonSummary? summary;

  final bool pixelArt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final file = ref.watch(mediaFileProvider((url: url, kind: MediaKind.art)));
    return SizedBox.square(
      dimension: size,
      child: switch (file) {
        AsyncData(:final value?) => _Picture(
          file: value,
          size: size,
          pixelArt: pixelArt,
          label: summary?.nameEn,
        ),
        AsyncLoading() => _Silhouette(summary: summary, size: size),
        _ => _fallback(),
      },
    );
  }

  Widget _fallback() {
    final s = summary;
    if (s == null) return _Silhouette(summary: null, size: size);
    return PokemonImage(
      artworkFile: s.artworkFile,
      spriteFile: s.spriteFile,
      networkUrl: s.artworkUrl ?? s.spriteUrl,
      size: size,
      pixelArt: pixelArt,
      semanticLabel: s.nameEn,
    );
  }
}

class _Picture extends StatelessWidget {
  const _Picture({
    required this.file,
    required this.size,
    required this.pixelArt,
    required this.label,
  });
  final File file;
  final double size;
  final bool pixelArt;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final cache = (size * MediaQuery.devicePixelRatioOf(context)).round();
    return Semantics(
      image: true,
      label: label,
      child: Image.file(
        file,
        width: size,
        height: size,
        cacheWidth: cache,
        fit: BoxFit.contain,
        filterQuality: pixelArt ? FilterQuality.none : FilterQuality.medium,
        gaplessPlayback: true,
        errorBuilder: (_, _, _) => const SizedBox.shrink(),
      ),
    );
  }
}

class _Silhouette extends StatelessWidget {
  const _Silhouette({required this.summary, required this.size});
  final PokemonSummary? summary;
  final double size;

  @override
  Widget build(BuildContext context) {
    final local = summary;
    if (local != null && local.hasLocalImage) {
      return Opacity(
        opacity: 0.22,
        child: PokemonImage(
          artworkFile: local.artworkFile,
          spriteFile: local.spriteFile,
          networkUrl: null,
          size: size,
          silhouette: true,
        ),
      );
    }
    return Center(
      child: PokeballMark(
        color: Colors.white.withValues(alpha: 0.35),
        size: size * 0.5,
      ),
    );
  }
}
