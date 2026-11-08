import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/di/providers.dart';
import '../../app/theme/app_tokens.dart';
import '../../core/connectivity/connectivity_state.dart';
import '../l10n_x.dart';
import '../navigation.dart';

class ConnectivityIndicator extends ConsumerWidget {
  const ConnectivityIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(indicatorProvider);
    final (color, icon, label) = _visual(context, view.status);
    return Semantics(
      button: true,
      label: context.l10n.indicatorSemantics(label),
      excludeSemantics: true,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: () => showModalBottomSheet<void>(
            context: rootNavigatorKey.currentContext ?? context,
            builder: (_) => const _IndicatorSheet(),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
            child: Center(
              widthFactor: 1,
              child: Container(
                height: 32,
                padding: const EdgeInsets.only(left: 10, right: 12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(Radii.pill),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: view.status == IndicatorStatus.syncing
                          ? SizedBox.square(
                              key: const ValueKey('sync'),
                              dimension: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: color,
                              ),
                            )
                          : Icon(
                              icon,
                              key: ValueKey(icon),
                              size: 16,
                              color: color,
                            ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      label,
                      maxLines: 1,
                      style: context.text.labelLarge?.copyWith(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

(Color, IconData, String) _visual(
  BuildContext context,
  IndicatorStatus status,
) {
  final t = context.tokens;
  final l10n = context.l10n;
  return switch (status) {
    IndicatorStatus.online => (
      t.success,
      Icons.wifi_rounded,
      l10n.statusOnline,
    ),
    IndicatorStatus.offline => (
      t.mute,
      Icons.wifi_off_rounded,
      l10n.statusOffline,
    ),
    IndicatorStatus.serviceUnavailable => (
      t.warning,
      Icons.warning_amber_rounded,
      l10n.statusUnavailable,
    ),
    IndicatorStatus.syncing => (t.info, Icons.sync_rounded, l10n.statusSyncing),
  };
}

class _IndicatorSheet extends ConsumerWidget {
  const _IndicatorSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(indicatorProvider);
    final sync = ref.watch(syncStateProvider).value ?? const SyncState();
    final l10n = context.l10n;
    final (color, icon, label) = _visual(context, view.status);
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
                Text(label, style: context.text.titleLarge),
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
              child: FilledButton.icon(
                onPressed: () =>
                    ref.read(syncServiceProvider).refresh(manual: true),
                icon: const Icon(Icons.refresh),
                label: Text(l10n.retryNow),
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
