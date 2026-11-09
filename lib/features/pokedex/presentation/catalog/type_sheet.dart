import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../app/theme/type_palette.dart';
import '../../../../shared/l10n_x.dart';
import '../widgets/control_fill.dart';
import 'catalog_controller.dart';
import 'sheet_frame.dart';

Future<void> showTypeSheet(BuildContext context) =>
    showCatalogSheet(context, (_) => const _TypeSheet());

class _TypeSheet extends ConsumerStatefulWidget {
  const _TypeSheet();

  @override
  ConsumerState<_TypeSheet> createState() => _TypeSheetState();
}

class _TypeSheetState extends ConsumerState<_TypeSheet> {
  late Set<int> _ids = {...ref.read(catalogControllerProvider).query.typeIds};

  void _toggle(int id) => setState(() {
    final next = {..._ids};
    next.contains(id) ? next.remove(id) : next.add(id);
    _ids = next;
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final types = ref.watch(typesProvider).value ?? const [];
    final lang = context.languageCode;
    return SheetFrame(
      title: l10n.navegacionTypePickTitle,
      onClear: () => setState(() => _ids = {}),
      body: Column(
        children: [
          _TypeOption(
            label: l10n.navegacionAllTypes,
            selected: _ids.isEmpty,
            fill: controlFill(context),
            ink: onControlFill(context),
            onTap: () => setState(() => _ids = {}),
          ),
          for (final type in types)
            _TypeOption(
              label: type.localizedName(lang),
              selected: _ids.contains(type.id),
              fill: typeColor(type.slug),
              ink: onType(type.slug),
              onTap: () => _toggle(type.id),
            ),
        ],
      ),
      footer: SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: () {
            final controller = ref.read(catalogControllerProvider.notifier);
            controller.apply(
              ref.read(catalogControllerProvider).query.copyWith(typeIds: _ids),
            );
            Navigator.pop(context);
          },
          child: Text(l10n.navegacionApplyFilter),
        ),
      ),
    );
  }
}

class _TypeOption extends StatelessWidget {
  const _TypeOption({
    required this.label,
    required this.selected,
    required this.fill,
    required this.ink,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final Color fill;
  final Color ink;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(Radii.pill),
        onTap: onTap,
        child: SizedBox(
          height: 52,
          child: Center(
            child: Container(
              height: 42,
              width: double.infinity,
              decoration: BoxDecoration(
                color: fill,
                borderRadius: BorderRadius.circular(Radii.pill),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    label,
                    style: context.text.labelLarge?.copyWith(color: ink),
                  ),
                  // La elección no depende solo del color: lleva una marca.
                  if (selected)
                    Positioned(
                      left: 16,
                      child: Icon(Icons.check_rounded, size: 18, color: ink),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
