import '../../../../core/config/app_config.dart';
import '../repositories/pokedex_repository.dart';

class ToggleFavorite {
  ToggleFavorite(this._repository);
  final PokedexRepository _repository;

  Future<({bool isFavorite, Duration elapsed, bool withinBudget})> call(
    int pokemonId,
  ) async {
    final watch = Stopwatch()..start();
    final isFavorite = await _repository.toggleFavorite(pokemonId);
    watch.stop();
    return (
      isFavorite: isFavorite,
      elapsed: watch.elapsed,
      withinBudget: watch.elapsed < AppConfig.favoriteWriteBudget,
    );
  }
}
