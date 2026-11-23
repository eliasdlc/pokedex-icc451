import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/providers.dart';
import '../../../../app/home_tab.dart';
import '../../../../app/theme/app_tokens.dart';
import '../../../../shared/l10n_x.dart';
import '../../../../shared/widgets/pokeball_navbar.dart';
import '../../../../shared/widgets/pokedex_header.dart';
import '../../../../shared/widgets/state_message.dart';
import '../../domain/entities/pokemon_summary.dart';
import '../detail/detail_screen.dart';
import '../widgets/control_fill.dart';
import '../widgets/empty_state_view.dart';
import '../widgets/pokemon_list_card.dart';

final favoritesProvider = StreamProvider<List<PokemonSummary>>(
  (ref) => ref.watch(pokedexRepositoryProvider).watchFavorites(),
);

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  /// Un `Dismissible` descartado sale del árbol en el mismo cuadro y la base tarda en avisar.
  final _removed = <int>{};

  Future<void> _remove(PokemonSummary pokemon) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _removed.add(pokemon.id));
    await ref.read(toggleFavoriteProvider)(pokemon.id);
    if (!mounted) return;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          // Aviso oscuro en ambos temas.
          backgroundColor: controlFill(context),
          elevation: 0,
          content: Text(
            l10n.navegacionRemovedFavorite(
              pokemon.localizedName(context.languageCode),
            ),
            style: context.text.bodyMedium?.copyWith(
              color: onControlFill(context),
            ),
          ),
          action: SnackBarAction(
            label: l10n.navegacionUndo,
            // El azul de acción en oscuro es el que se lee sobre fondo oscuro.
            textColor: AppTokens.dark.acTexto,
            onPressed: () => _undo(pokemon.id),
          ),
        ),
      );
  }

  Future<void> _undo(int id) async {
    await ref.read(toggleFavoriteProvider)(id);
    if (mounted) setState(() => _removed.remove(id));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final favorites = ref.watch(favoritesProvider);
    return Scaffold(
      appBar: PokedexHeader(
        title: l10n.favoritesTitle,
        detail: favorites.value == null
            ? null
            : l10n.favoritesCount(favorites.value!.length),
      ),
      body: favorites.when(
        loading: () => const SizedBox.shrink(),
        error: (_, _) => StateMessage(
          icon: Icons.error_outline,
          title: l10n.errorTitle,
          body: l10n.errorBody,
        ),
        data: (all) {
          // Lo que ya salió de la base deja de contar como "ocultado".
          _removed.removeWhere((id) => !all.any((p) => p.id == id));
          final list = [
            for (final p in all)
              if (!_removed.contains(p.id)) p,
          ];
          if (list.isEmpty) return _empty(context);
          return ListView.builder(
            // Los sprites sobresalen de su tarjeta: nada los recorta.
            clipBehavior: Clip.none,
            itemExtent: PokemonListCard.extent,
            padding: const EdgeInsets.fromLTRB(
              Gaps.screen,
              Gaps.screen,
              Gaps.screen,
              Gaps.navClearance,
            ),
            itemCount: list.length,
            itemBuilder: (context, i) => _FavoriteItem(
              pokemon: list[i],
              onOpen: () => DetailScreen.open(context, list[i].id),
              onRemoved: () => _remove(list[i]),
            ),
          );
        },
      ),
    );
  }

  Widget _empty(BuildContext context) {
    final l10n = context.l10n;
    return EmptyStateView(
      icon: Icons.favorite_border,
      title: l10n.navegacionFavEmptyTitle,
      body: l10n.navegacionFavEmptyBody,
      secondaryLabel: l10n.navegacionGoToPokedex,
      onSecondary: () =>
          ref.read(homeTabProvider.notifier).show(NavTab.pokedex.index),
    );
  }
}

class _FavoriteItem extends StatelessWidget {
  const _FavoriteItem({
    required this.pokemon,
    required this.onOpen,
    required this.onRemoved,
  });

  final PokemonSummary pokemon;
  final VoidCallback onOpen;
  final VoidCallback onRemoved;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.only(bottom: PokemonListCard.gap),
      child: Dismissible(
        key: ValueKey(pokemon.id),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => onRemoved(),
        background: Padding(
          // El panel rojo se alinea con el panel de la tarjeta (16 de aire).
          padding: const EdgeInsets.only(top: 16),
          child: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 28),
            decoration: BoxDecoration(
              color: t.danger,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.delete_outline, color: Colors.white),
                Text(
                  context.l10n.navegacionRemove,
                  style: context.text.labelMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        child: PokemonListCard(pokemon: pokemon, onTap: onOpen),
      ),
    );
  }
}
