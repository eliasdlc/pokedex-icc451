import 'package:flutter/material.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../shared/l10n_x.dart';

enum DetailTab { about, stats, evolutions, moves }

class DetailTabs extends StatelessWidget {
  const DetailTabs({super.key, required this.current, required this.onSelect});

  final DetailTab current;
  final ValueChanged<DetailTab> onSelect;

  static String label(BuildContext context, DetailTab tab) => switch (tab) {
    DetailTab.about => context.l10n.detailTabAbout,
    DetailTab.stats => context.l10n.detailTabStats,
    DetailTab.evolutions => context.l10n.detailTabEvolutions,
    DetailTab.moves => context.l10n.detailTabMoves,
  };

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return SizedBox(
      height: 48,
      child: Stack(
        children: [
          // Fondo de la píldora: 42 de alto dentro de los 48 táctiles.
          Positioned.fill(
            top: 3,
            bottom: 3,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: t.sf2,
                borderRadius: BorderRadius.circular(Radii.pill),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                for (final tab in DetailTab.values)
                  Expanded(
                    child: _TabItem(
                      label: label(context, tab),
                      selected: tab == current,
                      onTap: () => onSelect(tab),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
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
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          // 48 - 2 x 7 = 34: la pestaña activa mide 34 dentro de la píldora.
          margin: const EdgeInsets.symmetric(vertical: 7),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? t.sf : null,
            borderRadius: BorderRadius.circular(Radii.pill),
            boxShadow: selected && t.shadow.isNotEmpty
                ? const [
                    BoxShadow(
                      color: Color(0x1A111118),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          // Con letra grande del sistema el nombre se reduce, no se corta.
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              maxLines: 1,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                color: selected ? t.ink : t.mute,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
