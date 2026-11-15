/// Cómo se dibuja un Pokémon en el detalle.
enum ArtMode { pixel, illustration, model3d }

class ArtSelection {
  const ArtSelection({
    required this.requested,
    required this.shown,
    required this.url,
  });
  final ArtMode requested;
  final ArtMode shown;
  final Uri url;

  bool get usedFallback => requested != shown;
}

class ArtSources {
  const ArtSources({
    required this.pokemonId,
    required this.generationId,
    this.staticSprite,
  }) : assert(pokemonId > 0);

  final int pokemonId;
  final int generationId;

  /// El sprite fijo de PokéAPI (`front_default`), el mismo que dibuja el
  /// catálogo. Es el Pixel de quien no tiene sprite animado: sin él, el
  /// catálogo mostraría un sprite que la ficha dice que no existe.
  final Uri? staticSprite;

  /// Último Pokémon con sprite animado (Black/White).
  static const lastPixelId = 649;

  static const lastPixelGeneration = 5;

  static const _sprites =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon';
  static const _animated =
      '$_sprites/versions/generation-v/black-white/animated';
  static const _cries =
      'https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest';

  bool get _animatedPixel => pokemonId <= lastPixelId;

  bool has(ArtMode mode) => switch (mode) {
    ArtMode.pixel => _animatedPixel || staticSprite != null,
    ArtMode.illustration || ArtMode.model3d => true,
  };

  Uri? urlFor(ArtMode mode) {
    if (!has(mode)) return null;
    return switch (mode) {
      ArtMode.pixel =>
        _animatedPixel ? Uri.parse('$_animated/$pokemonId.gif') : staticSprite,
      ArtMode.illustration => Uri.parse(
        '$_sprites/other/official-artwork/$pokemonId.png',
      ),
      ArtMode.model3d => Uri.parse('$_sprites/other/home/$pokemonId.png'),
    };
  }

  ArtMode get defaultMode =>
      generationId <= lastPixelGeneration ? ArtMode.pixel : ArtMode.model3d;

  /// Orden de respaldo cuando [chosen] no existe: el modo pedido y luego los
  /// demás en el orden del selector (Pixel, Ilustración, 3D), dando la vuelta.
  ///
  /// * pixel -> ilustración -> 3D
  /// * ilustración -> 3D -> pixel
  /// * 3D -> pixel -> ilustración
  List<ArtMode> fallbackOrder(ArtMode chosen) {
    const modes = ArtMode.values;
    return [
      for (var i = 0; i < modes.length; i++)
        modes[(chosen.index + i) % modes.length],
    ];
  }

  /// Resuelve qué mostrar. [chosen] es la elección del usuario; null significa
  /// "por generación" (el valor por defecto de los ajustes).
  ArtSelection select(ArtMode? chosen) {
    final requested = chosen ?? defaultMode;
    // La ilustración existe siempre, así que la lista nunca queda vacía.
    final shown = fallbackOrder(requested).firstWhere(has);
    return ArtSelection(
      requested: requested,
      shown: shown,
      url: urlFor(shown)!,
    );
  }

  /// Sprite de espalda para la batalla: animado hasta el 649 y el estático
  /// de PokéAPI después.
  Uri get backSprite => Uri.parse(
    pokemonId <= lastPixelId
        ? '$_animated/back/$pokemonId.gif'
        : '$_sprites/back/$pokemonId.png',
  );

  /// Grito más reciente (.ogg). Existe para los 1025 y para las formas.
  Uri get cry => Uri.parse('$_cries/$pokemonId.ogg');
}
