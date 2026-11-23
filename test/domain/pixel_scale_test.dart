import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/shared/pixel_scale.dart';

void main() {
  group('pixelSpriteSize', () {
    test('es un múltiplo entero de los 96 px de origen en píxeles físicos', () {
      for (final ratio in [1.0, 1.5, 2.0, 2.625, 2.75, 3.0, 3.5]) {
        final size = pixelSpriteSize(ratio, maxLogical: 192);
        final factor = size * ratio / pixelSpriteSource;
        expect(factor, closeTo(factor.roundToDouble(), 1e-9), reason: '$ratio');
        expect(size, lessThanOrEqualTo(192), reason: '$ratio');
      }
    });

    test('en un Pixel 7 (2.75) el máximo de 192 da k = 5, unos 175 dp', () {
      expect(pixelSpriteSize(2.75, maxLogical: 192), closeTo(174.5, 0.1));
    });

    test('nunca baja de 1x aunque el máximo sea menor', () {
      expect(pixelSpriteSize(2, maxLogical: 10), 48);
    });
  });
}
