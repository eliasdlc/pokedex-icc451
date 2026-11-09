import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/providers.dart';
import '../../../../app/theme/app_tokens.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/connectivity/connectivity_state.dart';
import '../../../../core/utils/debouncer.dart';
import '../../../../shared/l10n_x.dart';
import '../../../../shared/widgets/main_app_bar.dart';
import '../../../../shared/widgets/state_message.dart';
import '../detail/detail_screen.dart';
import '../widgets/empty_state_view.dart';
import '../widgets/pokemon_list_card.dart';
import 'catalog_controller.dart';
import 'catalog_header.dart';
import 'catalog_notices.dart';
import 'sort_sheet.dart';
import 'type_sheet.dart';

class CatalogScreen extends ConsumerStatefulWidget {
  const CatalogScreen({super.key});

  @override
  ConsumerState<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends ConsumerState<CatalogScreen> {
  final _debouncer = Debouncer(AppConfig.searchDebounce);
  final _search = TextEditingController();
  final _scroll = ScrollController();

  bool _typed = false;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scroll.position.extentAfter < 600) {
      final loaded = ref.read(catalogItemsProvider).value?.length ?? 0;
      ref.read(catalogControllerProvider.notifier).loadMore(loaded);
    }
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _search.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _search.clear();
    ref.read(catalogControllerProvider.notifier).search('');
    setState(() {});
  }

  void _onSearchChanged(String text) {
    setState(() => _typed = true);
    _debouncer.run(
      () => ref.read(catalogControllerProvider.notifier).search(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    ref.listen(catalogControllerProvider.select((v) => v.query.search), (
      _,
      search,
    ) {
      if (!_typed && _search.text != search) {
        setState(() => _search.text = search);
      }
    });
    final view = ref.watch(catalogControllerProvider);
    final items = ref.watch(catalogItemsProvider);
    final count = ref.watch(catalogCountProvider).value;
    final indicator = ref.watch(indicatorProvider);
    final sync = ref.watch(syncStateProvider).value ?? const SyncState();
    final types = ref.watch(typesProvider).value ?? const [];
    final t = context.tokens;

    final online = indicator.origin == DataOrigin.liveAndLocal;
    // Base vacía y sin red: no hay nada que buscar ni que ordenar todavía.
    final noData = (items.value?.isEmpty ?? false) && sync.localCount == 0;
    final controlsOff = noData && !online;

    final typeIds = view.query.typeIds;
    final typeLabel = switch (typeIds.length) {
      0 => l10n.navegacionAllTypes,
      1 =>
        types
                .where((type) => type.id == typeIds.first)
                .map((type) => type.localizedName(context.languageCode))
                .firstOrNull ??
            l10n.navegacionTypesCount(1),
      final n => l10n.navegacionTypesCount(n),
    };
    return Scaffold(
      appBar: MainAppBar(title: l10n.appTitle),
      body: RefreshIndicator(
        color: t.ac,
        onRefresh: () => ref.read(syncServiceProvider).refresh(manual: true),
        child: CustomScrollView(
          controller: _scroll,
          clipBehavior: Clip.none,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  Gaps.screen,
                  Gaps.screen,
                  Gaps.screen,
                  Gaps.sibling,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CatalogSearchField(
                      controller: _search,
                      enabled: !controlsOff,
                      onChanged: _onSearchChanged,
                      onClear: _clearSearch,
                    ),
                    const SizedBox(height: Gaps.sibling),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FilterPill(
                          label: typeLabel,
                          onTap: controlsOff
                              ? null
                              : () => showTypeSheet(context),
                        ),
                        FilterPill(
                          label: sortLabel(l10n, view.query),
                          onTap: controlsOff
                              ? null
                              : () => showSortSheet(context),
                        ),
                      ],
                    ),
                    if (count != null && !controlsOff)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          l10n.resultsCount(count),
                          style: context.text.labelMedium,
                        ),
                      ),
                    if (indicator.status ==
                            IndicatorStatus.serviceUnavailable &&
                        !noData) ...[
                      const SizedBox(height: Gaps.sibling),
                      ApiDownCard(onRetry: _retrySync),
                    ] else if (!online && sync.isPartial) ...[
                      const SizedBox(height: Gaps.sibling),
                      InfoNotice(
                        color: t.warning,
                        text: l10n.partialCatalog(
                          sync.localCount,
                          sync.remoteTotal!,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            ...items.when(
              data: (list) {
                if (list.isEmpty) {
                  return [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: _empty(context, view, sync, online),
                    ),
                  ];
                }
                return [
                  _CardList(
                    itemCount: list.length,
                    itemBuilder: (context, i) => PokemonListCard(
                      pokemon: list[i],
                      onTap: () => DetailScreen.open(context, list[i].id),
                    ),
                  ),
                ];
              },
              // Esqueleto con la forma de las tarjetas, no un spinner.
              loading: () => [
                _CardList(
                  itemCount: 6,
                  itemBuilder: (_, _) => const _CardSkeleton(),
                ),
              ],
              error: (e, _) => [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: StateMessage(
                    icon: Icons.error_outline,
                    title: l10n.errorTitle,
                    body: l10n.errorBody,
                    action: () => ref.invalidate(catalogItemsProvider),
                    actionLabel: l10n.retryNow,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _retrySync() =>
      ref.read(syncServiceProvider).refresh(manual: true);

  Widget _empty(
    BuildContext context,
    CatalogViewState view,
    SyncState sync,
    bool online,
  ) {
    final l10n = context.l10n;
    if (sync.localCount == 0) {
      if (online) {
        return StateMessage(
          icon: Icons.downloading,
          title: l10n.emptyFirstLoadTitle,
          body: l10n.emptyFirstLoadBody,
        );
      }
      return EmptyStateView(
        icon: Icons.cloud_off_outlined,
        title: l10n.navegacionEmptyDbTitle,
        body: l10n.navegacionEmptyDbBody,
        primaryLabel: l10n.navegacionRetry,
        onPrimary: _retrySync,
        secondaryLabel: l10n.navegacionCheckConnection,
        onSecondary: () => ref.read(connectivityServiceProvider).recheck(),
      );
    }
    return StateMessage(
      icon: Icons.search_off,
      title: l10n.emptyResultsTitle,
      body: l10n.emptyResultsBody,
      action: view.query.hasFilters
          ? () => ref.read(catalogControllerProvider.notifier).clearFilters()
          : null,
      actionLabel: l10n.clearFilters,
    );
  }
}

class _CardList extends StatelessWidget {
  const _CardList({required this.itemCount, required this.itemBuilder});

  final int itemCount;
  final NullableIndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(
        Gaps.screen,
        0,
        Gaps.screen,
        Gaps.navClearance,
      ),
      sliver: SliverFixedExtentList.builder(
        itemExtent: PokemonListCard.extent,
        itemCount: itemCount,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.only(bottom: PokemonListCard.gap),
          child: itemBuilder(context, i),
        ),
      ),
    );
  }
}

class _CardSkeleton extends StatelessWidget {
  const _CardSkeleton();

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.only(top: 16),
    child: SkeletonBox(radius: 24),
  );
}
