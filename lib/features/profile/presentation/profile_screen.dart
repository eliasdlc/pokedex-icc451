import 'package:flutter/material.dart';

import '../../../shared/l10n_x.dart';
import '../../../shared/widgets/pokedex_header.dart';
import '../../../shared/widgets/state_message.dart';
import '../../settings/presentation/settings_screen.dart';

/// PROVISIONAL hasta la Etapa 5: allí se reemplaza por la Ficha de
/// entrenador y los logros. Solo trae lo que la Etapa 4 necesita: la tecla
/// que abre Ajustes (y desde ahí el Laboratorio de la defensa).
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    void openSettings() => Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => const SettingsScreen()),
    );
    return Scaffold(
      appBar: PokedexHeader(
        title: l10n.baseNavProfile,
        actions: [
          HeaderKey(
            icon: HeaderIcon.settings,
            tooltip: l10n.navSettings,
            onPressed: openSettings,
          ),
        ],
      ),
      // PA-15: explica qué vendrá y ofrece lo que ya funciona.
      body: StateMessage(
        icon: Icons.badge_outlined,
        title: l10n.soonTitle,
        body: l10n.profileSoonBody,
        actionLabel: l10n.openSettings,
        action: openSettings,
      ),
    );
  }
}
