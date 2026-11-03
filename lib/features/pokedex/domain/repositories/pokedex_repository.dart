import '../../../../core/connectivity/connectivity_state.dart';
import '../entities/catalog_query.dart';
import '../entities/poke_type.dart';
import '../entities/pokemon_detail.dart';
import '../entities/pokemon_summary.dart';

abstract interface class PokedexRepository {
  Stream<List<PokemonSummary>> watchCatalog(
    CatalogQuery query, {
    required int limit,
  });
  Stream<int> watchCatalogCount(CatalogQuery query);
  Stream<PokemonDetail?> watchDetail(int id);
  Stream<List<PokemonSummary>> watchFavorites();
  Stream<List<PokeType>> watchTypes();
  Stream<List<Generation>> watchGenerations();
  Stream<List<Ability>> watchAbilities();

  Future<bool> toggleFavorite(int pokemonId);

  Future<List<PokemonSummary>> playablePokemon({bool requireDetail = false});
  Future<PokemonDetail?> getDetail(int id);

  Future<Map<(int, int), int>> typeEfficacy();

  Future<CatalogQuery> loadSavedQuery();
  Future<void> saveQuery(CatalogQuery query);
}

abstract interface class SyncService {
  Stream<SyncState> watch();

  Future<void> start();

  Future<void> refresh({bool manual = false});

  Future<void> ensureDetail(int pokemonId);

  Future<int> checkIntegrity();
}
