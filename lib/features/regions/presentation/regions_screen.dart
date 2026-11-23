import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/home_tab.dart';
import '../../../shared/l10n_x.dart';
import '../../../shared/widgets/pokeball_navbar.dart';
import '../../../shared/widgets/pokedex_header.dart';
import '../../../shared/widgets/state_message.dart';

/// PROVISIONAL hasta la Etapa 5: allí se reemplaza por la lista de regiones,
/// de Kanto a Paldea. Mientras tanto explica qué vendrá y ofrece ir a la
/// Pokédex (PA-15: ninguna pantalla en blanco ni sin acción sugerida).
class RegionsScreen extends ConsumerWidget {
  const RegionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: PokedexHeader(title: l10n.regionsTitle),
      body: StateMessage(
        icon: Icons.map_outlined,
        title: l10n.soonTitle,
        body: l10n.regionsSoonBody,
        actionLabel: l10n.openPokedex,
        action: () =>
            ref.read(homeTabProvider.notifier).show(NavTab.pokedex.index),
      ),
    );
  }
}
