import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokedex/domain/entities/art_sources.dart';

void main() {
  const base =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon';

  ArtSources art(int id, int generation) =>
      ArtSources(pokemonId: id, generationId: generation);

  group('qué modos existen', () {
    test('el 649 tiene pixel y el 650 no', () {
      expect(art(649, 5).has(ArtMode.pixel), isTrue);
      expect(art(650, 6).has(ArtMode.pixel), isFalse);
      expect(art(650, 6).urlFor(ArtMode.pixel), isNull);
    });

    test('ilustración y 3D existen del 1 al 1025', () {
      for (final id in [1, 649, 650, 1025]) {
        expect(art(id, 1).has(ArtMode.illustration), isTrue);
        expect(art(id, 1).has(ArtMode.model3d), isTrue);
      }
    });

    test('una forma alternativa no tiene pixel pero sí arte propio', () {
      final raichuAlola = art(10100, 1);
      expect(raichuAlola.has(ArtMode.pixel), isFalse);
      expect(
        raichuAlola.urlFor(ArtMode.illustration).toString(),
        '$base/other/official-artwork/10100.png',
      );
    });
  });

  group('URLs', () {
    test('cada modo apunta a su carpeta del repositorio de sprites', () {
      final pikachu = art(25, 1);
      expect(
        pikachu.urlFor(ArtMode.pixel).toString(),
        '$base/versions/generation-v/black-white/animated/25.gif',
      );
      expect(
        pikachu.urlFor(ArtMode.illustration).toString(),
        '$base/other/official-artwork/25.png',
      );
      expect(
        pikachu.urlFor(ArtMode.model3d).toString(),
        '$base/other/home/25.png',
      );
    });

    test('sprite de espalda: animado hasta el 649 y estático después', () {
      expect(
        art(494, 5).backSprite.toString(),
        '$base/versions/generation-v/black-white/animated/back/494.gif',
      );
      expect(art(1025, 9).backSprite.toString(), '$base/back/1025.png');
    });

    test('el grito sale del repositorio de cries', () {
      expect(
        art(1025, 9).cry.toString(),
        'https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/1025.ogg',
      );
    });
  });

  group('modo por defecto', () {
    test('pixel de la generación 1 a la 5', () {
      for (final generation in [1, 2, 3, 4, 5]) {
        expect(art(1, generation).defaultMode, ArtMode.pixel);
      }
    });

    test('3D de la generación 6 a la 9', () {
      for (final generation in [6, 7, 8, 9]) {
        expect(art(650, generation).defaultMode, ArtMode.model3d);
      }
    });
  });

  group('respaldo', () {
    test('el orden sigue el del selector y da la vuelta', () {
      final a = art(1, 1);
      expect(a.fallbackOrder(ArtMode.pixel), [
        ArtMode.pixel,
        ArtMode.illustration,
        ArtMode.model3d,
      ]);
      expect(a.fallbackOrder(ArtMode.illustration), [
        ArtMode.illustration,
        ArtMode.model3d,
        ArtMode.pixel,
      ]);
      expect(a.fallbackOrder(ArtMode.model3d), [
        ArtMode.model3d,
        ArtMode.pixel,
        ArtMode.illustration,
      ]);
    });

    test('sin elección usa el modo de la generación', () {
      final gen1 = art(25, 1).select(null);
      expect(gen1.shown, ArtMode.pixel);
      expect(gen1.usedFallback, isFalse);
      expect(art(906, 9).select(null).shown, ArtMode.model3d);
    });

    test('un modo fijo que existe se respeta', () {
      final selection = art(25, 1).select(ArtMode.illustration);
      expect(selection.shown, ArtMode.illustration);
      expect(selection.usedFallback, isFalse);
    });

    test('pixel fijo en un Pokémon sin pixel cae a ilustración y lo avisa', () {
      final selection = art(906, 9).select(ArtMode.pixel);
      expect(selection.requested, ArtMode.pixel);
      expect(selection.shown, ArtMode.illustration);
      expect(selection.usedFallback, isTrue);
      expect(selection.url.toString(), '$base/other/official-artwork/906.png');
    });

    test('una forma de la Gen 1 por defecto en pixel cae a ilustración', () {
      final selection = art(10100, 1).select(null);
      expect(selection.shown, ArtMode.illustration);
      expect(selection.usedFallback, isTrue);
    });
  });
}
