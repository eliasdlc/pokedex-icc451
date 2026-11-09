import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/providers.dart';
import '../../../../app/theme/app_tokens.dart';
import '../../../../core/connectivity/connectivity_state.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../../shared/l10n_x.dart';
import '../../domain/entities/catalog_query.dart';
import '../widgets/control_fill.dart';
import 'catalog_controller.dart';
import 'catalog_notices.dart';
import 'sheet_frame.dart';

Future<void> showSortSheet(BuildContext context) =>
    showCatalogSheet(context, (_) => const _SortSheet());

String sortLabel(AppLocalizations l10n, CatalogQuery query) {
  final arrow = query.ascending ? '↑' : '↓';
  return switch (query.sort) {
    CatalogSort.number =>
      query.ascending
          ? l10n.navegacionSortNumberAsc
          : l10n.navegacionSortNumberDesc,
    CatalogSort.name =>
      query.ascending
          ? l10n.navegacionSortNameAsc
          : l10n.navegacionSortNameDesc,
    CatalogSort.total => '${l10n.total} $arrow',
    CatalogSort.attack => '${l10n.sortAttack} $arrow',
    CatalogSort.defense => '${l10n.sortDefense} $arrow',
    CatalogSort.speed => '${l10n.sortSpeed} $arrow',
  };
}

class _SortSheet extends ConsumerStatefulWidget {
  const _SortSheet();

  @override
  ConsumerState<_SortSheet> createState() => _SortSheetState();
}

class _SortSheetState extends ConsumerState<_SortSheet> {
  late CatalogQuery _draft = ref.read(catalogControllerProvider).query;

  void _setOrder(CatalogSort sort, bool ascending) => setState(
    () => _draft = _draft.copyWith(sort: sort, ascending: ascending),
  );

  void _toggleGeneration(int id) => setState(
    () => _draft = _draft.copyWith(
      generationId: () => _draft.generationId == id ? null : id,
    ),
  );
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final generations = ref.watch(generationsProvider).value ?? const [];
    final abilities = ref.watch(abilitiesProvider).value ?? const [];
    final sync = ref.watch(syncStateProvider).value ?? const SyncState();
    final count = ref.watch(catalogCountForProvider(_draft)).value;
    final lang = context.languageCode;
    final t = context.tokens;

    return SheetFrame(
      title: l10n.navegacionSortTitle,
      onClear: () => setState(
        () => _draft = CatalogQuery(
          search: _draft.search,
          typeIds: _draft.typeIds,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PillGrid([
            _OrderPill(
              label: l10n.navegacionSortNumberAsc,
              selected: _isOrder(CatalogSort.number, true),
              onTap: () => _setOrder(CatalogSort.number, true),
            ),
            _OrderPill(
              label: l10n.navegacionSortNumberDesc,
              selected: _isOrder(CatalogSort.number, false),
              onTap: () => _setOrder(CatalogSort.number, false),
            ),
            _OrderPill(
              label: l10n.navegacionSortNameAsc,
              selected: _isOrder(CatalogSort.name, true),
              onTap: () => _setOrder(CatalogSort.name, true),
            ),
            _OrderPill(
              label: l10n.navegacionSortNameDesc,
              selected: _isOrder(CatalogSort.name, false),
              onTap: () => _setOrder(CatalogSort.name, false),
            ),
          ]),
          const SizedBox(height: Gaps.sibling),
          _Eyebrow(l10n.generationLabel),
          Row(
            children: [
              for (final g in generations)
                Expanded(
                  child: _GenerationDot(
                    label: g.roman,
                    selected: _draft.generationId == g.id,
                    onTap: () => _toggleGeneration(g.id),
                  ),
                ),
            ],
          ),
          const SizedBox(height: Gaps.sibling),
          _Eyebrow(l10n.regionLabel),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final g in generations) ...[
                  _SheetChip(
                    label: g.regionName,
                    selected: _draft.generationId == g.id,
                    fill: context.tokens.ac,
                    ink: context.tokens.on,
                    onTap: () => _toggleGeneration(g.id),
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ),
          const SizedBox(height: Gaps.sibling),
          _Eyebrow(l10n.navegacionStatsSection),
          Wrap(
            spacing: 8,
            children: [
              for (final (sort, name) in [
                (CatalogSort.total, l10n.total),
                (CatalogSort.attack, l10n.sortAttack),
                (CatalogSort.defense, l10n.sortDefense),
                (CatalogSort.speed, l10n.sortSpeed),
              ])
                _SheetChip(
                  label: name,
                  selected: _draft.sort == sort,
                  fill: context.tokens.ac,
                  ink: context.tokens.on,
                  arrow: _draft.sort != sort
                      ? null
                      : _draft.ascending
                      ? Icons.arrow_upward_rounded
                      : Icons.arrow_downward_rounded,
                  semanticSuffix: _draft.sort != sort
                      ? null
                      : _draft.ascending
                      ? l10n.ascending
                      : l10n.descending,
                  onTap: () => _setOrder(
                    sort,
                    _draft.sort == sort ? !_draft.ascending : false,
                  ),
                ),
            ],
          ),
          const SizedBox(height: Gaps.sibling),
          _Eyebrow(l10n.abilityLabel),
          DropdownButtonFormField<int?>(
            initialValue: _draft.abilityId,
            isExpanded: true,
            style: context.text.bodyMedium?.copyWith(color: t.ink),
            borderRadius: BorderRadius.circular(Radii.block),
            items: [
              DropdownMenuItem(value: null, child: Text(l10n.anyOption)),
              for (final a in abilities)
                DropdownMenuItem(
                  value: a.id,
                  child: Text(a.localizedName(lang)),
                ),
            ],
            onChanged: (id) =>
                setState(() => _draft = _draft.copyWith(abilityId: () => id)),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.favoritesOnly, style: context.text.labelLarge),
            value: _draft.favoritesOnly,
            onChanged: (v) =>
                setState(() => _draft = _draft.copyWith(favoritesOnly: v)),
          ),
          if (sync.isPartial) ...[
            const SizedBox(height: Gaps.sibling),
            InfoNotice(
              color: t.info,
              text: l10n.navegacionPartialNote(
                sync.localCount,
                sync.remoteTotal!,
              ),
            ),
          ],
        ],
      ),
      footer: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.navegacionSavedNote, style: context.text.bodySmall),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                ref.read(catalogControllerProvider.notifier).apply(_draft);
                Navigator.pop(context);
              },
              child: Text(
                count == null ? l10n.apply : l10n.navegacionSeeResults(count),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isOrder(CatalogSort sort, bool ascending) =>
      _draft.sort == sort && _draft.ascending == ascending;
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(
      text.toUpperCase(),
      style: context.text.labelMedium?.copyWith(
        color: context.tokens.body,
        letterSpacing: 0.72,
      ),
    ),
  );
}

class _PillGrid extends StatelessWidget {
  const _PillGrid(this.pills);
  final List<Widget> pills;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (var i = 0; i < pills.length; i += 2)
        Row(
          children: [
            Expanded(child: pills[i]),
            const SizedBox(width: 8),
            Expanded(
              child: i + 1 < pills.length ? pills[i + 1] : const SizedBox(),
            ),
          ],
        ),
    ],
  );
}

class _OrderPill extends StatelessWidget {
  const _OrderPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(Radii.pill),
        onTap: onTap,
        child: SizedBox(
          height: 50,
          child: Center(
            child: Container(
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? controlFill(context) : t.sf,
                borderRadius: BorderRadius.circular(Radii.pill),
                border: selected ? null : Border.all(color: t.ln, width: 1.5),
              ),
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.text.labelLarge?.copyWith(
                  color: selected ? onControlFill(context) : t.ink,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GenerationDot extends StatelessWidget {
  const _GenerationDot({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Semantics(
      button: true,
      selected: selected,
      label: '${context.l10n.generationLabel} $label',
      excludeSemantics: true,
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: SizedBox(
          height: 48,
          child: Center(
            child: Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? t.ac : t.sf2,
                shape: BoxShape.circle,
              ),
              child: Text(
                label,
                maxLines: 1,
                style: context.text.labelMedium?.copyWith(
                  color: selected ? t.on : t.ink,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SheetChip extends StatelessWidget {
  const _SheetChip({
    required this.label,
    required this.selected,
    required this.fill,
    required this.ink,
    required this.onTap,
    this.arrow,
    this.semanticSuffix,
  });

  final String label;
  final bool selected;

  /// Relleno y texto cuando está elegida.
  final Color fill;
  final Color ink;
  final VoidCallback onTap;
  final IconData? arrow;
  final String? semanticSuffix;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final textColor = selected ? ink : t.ink;
    return Semantics(
      button: true,
      selected: selected,
      label: semanticSuffix == null ? label : '$label, $semanticSuffix',
      excludeSemantics: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(Radii.pill),
        onTap: onTap,
        child: SizedBox(
          height: 48,
          child: Center(
            widthFactor: 1,
            child: Container(
              height: 34,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: selected ? fill : t.sf2,
                borderRadius: BorderRadius.circular(Radii.pill),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: context.text.labelLarge?.copyWith(color: textColor),
                  ),
                  if (arrow != null) ...[
                    const SizedBox(width: 4),
                    Icon(arrow, size: 16, color: textColor),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
