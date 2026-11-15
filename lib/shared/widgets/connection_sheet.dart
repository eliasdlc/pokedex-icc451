import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/di/providers.dart';
import '../../app/theme/app_tokens.dart';
import '../../core/connectivity/connectivity_state.dart';
import '../../l10n/gen/app_localizations.dart';
import '../l10n_x.dart';
import '../navigation.dart';
import 'pokedex_key.dart';

/// El texto corto del estado: va en la pantalla LCD y en la etiqueta de las luces.
String connectionLabel(AppLocalizations l10n, IndicatorStatus status) =>
    switch (status) {
      IndicatorStatus.online => l10n.statusOnline,
      IndicatorStatus.offline => l10n.statusOffline,
      IndicatorStatus.serviceUnavailable => l10n.statusUnavailable,
      IndicatorStatus.syncing => l10n.statusSyncing,
    };

/// Se abre desde las luces de la cabecera. Usa el Navigator raíz para quedar
/// por encima de la barra de navegación.
void showConnectionSheet(BuildContext context) => showModalBottomSheet<void>(
  context: rootNavigatorKey.currentContext ?? context,
  builder: (_) => const _ConnectionSheet(),
);

class _ConnectionSheet extends ConsumerWidget {
  const _ConnectionSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(indicatorProvider);
    final sync = ref.watch(syncStateProvider).value ?? const SyncState();
    final l10n = context.l10n;
    final t = context.tokens;
    final (color, icon) = switch (view.status) {
      IndicatorStatus.online => (t.success, Icons.wifi_rounded),
      IndicatorStatus.offline => (t.mute, Icons.wifi_off_rounded),
      IndicatorStatus.serviceUnavailable => (
        t.warning,
        Icons.warning_amber_rounded,
      ),
      IndicatorStatus.syncing => (t.info, Icons.sync_rounded),
    };
    final long = switch (view.status) {
      IndicatorStatus.online => l10n.statusOnlineLong,
      IndicatorStatus.offline => l10n.statusOfflineLong,
      IndicatorStatus.serviceUnavailable => l10n.statusUnavailableLong,
      IndicatorStatus.syncing => l10n.statusSyncingLong,
    };
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Gaps.screen,
          0,
          Gaps.screen,
          Gaps.screen,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(Radii.chip),
                  ),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: Gaps.row),
                Text(
                  connectionLabel(l10n, view.status),
                  style: context.text.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: Gaps.sibling),
            Text(long, style: context.text.bodyLarge),
            const SizedBox(height: Gaps.sibling),
            _Line(
              icon: Icons.storage_outlined,
              text: view.origin == DataOrigin.liveAndLocal
                  ? l10n.originLive
                  : l10n.originLocal,
            ),
            _Line(
              icon: Icons.schedule,
              text: l10n.lastSync(timeAgo(l10n, view.lastSyncedAt)),
            ),
            _Line(
              icon: Icons.catching_pokemon,
              text: l10n.localCatalog(
                view.localCount,
                view.remoteTotal?.toString() ?? '?',
              ),
            ),
            if (sync.pendingRepairs > 0)
              _Line(
                icon: Icons.build_circle_outlined,
                text: l10n.pendingRepairs(sync.pendingRepairs),
              ),
            const SizedBox(height: Gaps.section),
            SizedBox(
              width: double.infinity,
              child: PokedexKey(
                label: l10n.retryNow,
                onPressed: () =>
                    ref.read(syncServiceProvider).refresh(manual: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: context.tokens.mute),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: context.text.bodyMedium)),
      ],
    ),
  );
}
