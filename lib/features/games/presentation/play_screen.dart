import 'package:flutter/material.dart';

import '../../../shared/l10n_x.dart';
import '../../../shared/widgets/pokedex_header.dart';
import '../../../shared/widgets/state_message.dart';

/// PROVISIONAL hasta la Etapa 5: allí se reemplaza por el centro de juegos.
/// Guarda el mismo parámetro que tendrá la pantalla real y mientras tanto
/// explica qué vendrá y ofrece ir a la Pokédex (PA-15).
class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key, this.onOpenCatalog});

  /// Cambia a la pestaña Pokédex.
  final VoidCallback? onOpenCatalog;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: PokedexHeader(title: l10n.playTitle),
      body: StateMessage(
        icon: Icons.sports_esports_outlined,
        title: l10n.soonTitle,
        body: l10n.playSoonBody,
        actionLabel: l10n.openPokedex,
        action: onOpenCatalog,
      ),
    );
  }
}
