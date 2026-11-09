import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/providers.dart';
import '../../domain/entities/catalog_query.dart';
import '../../domain/entities/poke_type.dart';
import '../../domain/entities/pokemon_summary.dart';

/// Estado de la pantalla de catálogo: qué se busca y cuántos se muestran.
class CatalogViewState {
  const CatalogViewState({
    this.query = const CatalogQuery(),
    this.limit = pageSize,
  });
  static const pageSize = 60;
  final CatalogQuery query;
  final int limit;

  CatalogViewState copyWith({CatalogQuery? query, int? limit}) =>
      CatalogViewState(query: query ?? this.query, limit: limit ?? this.limit);
}

class CatalogController extends Notifier<CatalogViewState> {
  @override
  CatalogViewState build() {
    unawaited(_restore());
    return const CatalogViewState();
  }

  Future<void> _restore() async {
    final saved = await ref.read(pokedexRepositoryProvider).loadSavedQuery();
    // búsqueda, filtros y orden vuelven tal como se dejaron.
    state = state.copyWith(query: saved);
  }

  void _update(CatalogQuery query) {
    state = CatalogViewState(query: query);
    unawaited(ref.read(pokedexRepositoryProvider).saveQuery(query));
  }

  void search(String text) => _update(state.query.copyWith(search: text));

  void toggleType(PokeType type) {
    final types = {...state.query.typeIds};
    types.contains(type.id) ? types.remove(type.id) : types.add(type.id);
    _update(state.query.copyWith(typeIds: types));
  }

  void apply(CatalogQuery query) =>
      _update(query.copyWith(search: state.query.search));

  void clearFilters() =>
      _update(CatalogQuery(search: state.query.search, sort: state.query.sort));

  /// Paginación local: al acercarse al final se piden 60 más a la base.
  void loadMore(int loaded) {
    if (loaded >= state.limit) {
      state = state.copyWith(limit: state.limit + CatalogViewState.pageSize);
    }
  }
}

final catalogControllerProvider =
    NotifierProvider<CatalogController, CatalogViewState>(
      CatalogController.new,
    );

final catalogItemsProvider = StreamProvider<List<PokemonSummary>>((ref) {
  final view = ref.watch(catalogControllerProvider);
  ref.watch(languageCodeProvider);
  return ref
      .watch(pokedexRepositoryProvider)
      .watchCatalog(view.query, limit: view.limit);
});

final catalogCountProvider = StreamProvider<int>((ref) {
  final query = ref.watch(catalogControllerProvider.select((v) => v.query));
  return ref.watch(pokedexRepositoryProvider).watchCatalogCount(query);
});

final catalogCountForProvider = StreamProvider.family<int, CatalogQuery>(
  (ref, query) => ref.watch(pokedexRepositoryProvider).watchCatalogCount(query),
);

final typesProvider = StreamProvider<List<PokeType>>(
  (ref) => ref.watch(pokedexRepositoryProvider).watchTypes(),
);

final generationsProvider = StreamProvider<List<Generation>>(
  (ref) => ref.watch(pokedexRepositoryProvider).watchGenerations(),
);

final abilitiesProvider = StreamProvider<List<Ability>>(
  (ref) => ref.watch(pokedexRepositoryProvider).watchAbilities(),
);
