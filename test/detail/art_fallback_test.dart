import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokedex/domain/entities/art_sources.dart';

void main() {
  test('Pikachu (Nº 25, Gen 1) abre en Pixel y no hay respaldo', () {
    final art = const ArtSources(pokemonId: 25, generationId: 1).select(null);
    expect(art.shown, ArtMode.pixel);
    expect(art.usedFallback, isFalse);
  });

  test('Sylveon (Nº 700, Gen 6) abre en 3D', () {
    final art = const ArtSources(pokemonId: 700, generationId: 6).select(null);
    expect(art.shown, ArtMode.model3d);
  });

  test('pedir Pixel pasado el Nº 649 cae a Ilustración y lo avisa', () {
    final art = const ArtSources(
      pokemonId: 700,
      generationId: 6,
    ).select(ArtMode.pixel);
    expect(art.requested, ArtMode.pixel);
    expect(art.shown, ArtMode.illustration);
    expect(art.usedFallback, isTrue);
  });
}
