const pixelSpriteSource = 96.0;

double pixelSpriteSize(double pixelRatio, {required double maxLogical}) {
  final k = (maxLogical * pixelRatio / pixelSpriteSource).floor();
  return pixelSpriteSource * (k < 1 ? 1 : k) / pixelRatio;
}
