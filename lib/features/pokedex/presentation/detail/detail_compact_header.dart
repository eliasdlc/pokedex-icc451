import 'package:flutter/material.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../../shared/l10n_x.dart';
import '../../../../shared/widgets/pokedex_header.dart';
import '../../domain/entities/pokemon_summary.dart';

/// Cabecera de las pestañas que no son Acerca de: la placa con el nombre y el
/// número en la pantalla LCD, y las pestañas debajo.
class DetailCompactHeader extends StatelessWidget {
  const DetailCompactHeader({
    super.key,
    required this.pokemon,
    required this.number,
    required this.isFavorite,
    required this.onFavorite,
    required this.onBack,
    required this.onCry,
    required this.tabs,
  });

  final PokemonSummary pokemon;
  final String number;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onBack;
  final VoidCallback? onCry;
  final Widget tabs;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ColoredBox(
      color: context.tokens.bg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PokedexHeader(
            title: pokemon.localizedName(context.languageCode),
            detail: number,
            onBack: onBack,
            actions: detailKeys(
              l10n,
              isFavorite: isFavorite,
              onFavorite: onFavorite,
              onCry: onCry,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: tabs,
          ),
        ],
      ),
    );
  }
}

/// Grito y favorito: las mismas dos teclas en el héroe y en la cabecera compacta.
List<Widget> detailKeys(
  AppLocalizations l10n, {
  required bool isFavorite,
  required VoidCallback onFavorite,
  required VoidCallback? onCry,
}) => [
  HeaderKey(
    icon: HeaderIcon.cry,
    tooltip: onCry == null ? l10n.detailCryUnavailable : l10n.detailCryReplay,
    onPressed: onCry,
  ),
  HeaderKey(
    icon: HeaderIcon.favorite,
    active: isFavorite,
    tooltip: isFavorite ? l10n.removeFavorite : l10n.addFavorite,
    onPressed: onFavorite,
  ),
];
