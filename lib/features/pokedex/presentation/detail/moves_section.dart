import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../../shared/l10n_x.dart';
import '../../../../shared/widgets/type_chip.dart';
import '../../domain/entities/art_sources.dart';
import '../../domain/entities/poke_type.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../../domain/entities/pokemon_summary.dart';
import '../../../../shared/widgets/pokedex_key.dart';
import '../catalog/catalog_controller.dart';
import 'detail_sections.dart';
import 'pokemon_art.dart';

String methodLabel(AppLocalizations l10n, MoveLearnMethod m) => switch (m) {
  MoveLearnMethod.levelUp => l10n.methodLevelUp,
  MoveLearnMethod.machine => l10n.methodMachine,
  MoveLearnMethod.tutor => l10n.methodTutor,
  MoveLearnMethod.egg => l10n.methodEgg,
};

class MovesHeader extends StatelessWidget {
  const MovesHeader({
    super.key,
    required this.versionGroups,
    required this.versionGroupId,
    required this.method,
    required this.sort,
    required this.onVersion,
    required this.onMethod,
    required this.onSort,
  });
  final List<VersionGroup> versionGroups;
  final int versionGroupId;
  final MoveLearnMethod method;
  final MoveSort sort;
  final ValueChanged<int> onVersion;
  final ValueChanged<MoveLearnMethod> onMethod;
  final ValueChanged<MoveSort> onSort;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final current = versionGroups
        .where((v) => v.id == versionGroupId)
        .firstOrNull;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: SectionTitle(l10n.detailMoves)),
            _VersionPicker(
              label: current?.displayName ?? '',
              versionGroups: versionGroups,
              onSelected: onVersion,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          children: [
            for (final m in MoveLearnMethod.values)
              _MethodPill(
                label: methodLabel(l10n, m),
                selected: m == method,
                onTap: () => onMethod(m),
              ),
          ],
        ),
        const SizedBox(height: 4),
        SegmentedButton<MoveSort>(
          showSelectedIcon: false,
          style: SegmentedButton.styleFrom(
            selectedBackgroundColor: context.tokens.acTinte,
            selectedForegroundColor: context.tokens.acTexto,
            foregroundColor: context.tokens.ink,
            side: BorderSide(color: context.tokens.ln2),
            textStyle: context.text.labelLarge,
          ),
          segments: [
            ButtonSegment(value: MoveSort.level, label: Text(l10n.sortByLevel)),
            ButtonSegment(value: MoveSort.name, label: Text(l10n.sortByName)),
          ],
          selected: {sort},
          onSelectionChanged: (v) => onSort(v.first),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}

class _VersionPicker extends StatelessWidget {
  const _VersionPicker({
    required this.label,
    required this.versionGroups,
    required this.onSelected,
  });
  final String label;
  final List<VersionGroup> versionGroups;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return PopupMenuButton<int>(
      tooltip: context.l10n.movesVersion,
      onSelected: onSelected,
      itemBuilder: (_) => [
        for (final v in versionGroups.reversed)
          PopupMenuItem(value: v.id, child: Text(v.displayName)),
      ],
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48, maxWidth: 200),
        child: Center(
          child: Container(
            height: 40,
            padding: const EdgeInsets.only(left: 14, right: 10),
            decoration: BoxDecoration(
              color: t.sf,
              border: Border.all(color: t.ln, width: 1.5),
              borderRadius: BorderRadius.circular(Radii.pill),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.text.labelMedium?.copyWith(color: t.ink),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.expand_more_rounded, size: 16, color: t.ink),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MethodPill extends StatelessWidget {
  const _MethodPill({
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
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Center(
            widthFactor: 1,
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: selected ? t.ink : t.sf2,
                borderRadius: BorderRadius.circular(Radii.pill),
              ),
              // Center con widthFactor: la píldora mide lo que su texto.
              child: Center(
                widthFactor: 1,
                child: Text(
                  label,
                  style: context.text.labelLarge?.copyWith(
                    color: selected ? t.bg : t.ink,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MoveRow extends StatelessWidget {
  const MoveRow({
    super.key,
    required this.move,
    required this.type,
    required this.first,
  });
  final PokemonMove move;
  final PokeType? type;
  final bool first;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final l10n = context.l10n;
    return Container(
      constraints: const BoxConstraints(minHeight: 44),
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        border: first ? null : Border(top: BorderSide(color: t.ln)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 52,
            // Nivel 0 en PokéAPI = lo aprende al evolucionar.
            child: Text(switch ((move.method, move.level)) {
              (MoveLearnMethod.levelUp, 0) => l10n.moveOnEvolution,
              (MoveLearnMethod.levelUp, final level) => l10n.moveLevel(level),
              _ => '',
            }, style: context.text.labelMedium),
          ),
          Expanded(
            child: Text(move.displayName, style: context.text.labelLarge),
          ),
          if (type != null) TypeChip(type!, compact: true),
          SizedBox(
            width: 40,
            child: Text(
              move.power?.toString() ?? '-',
              textAlign: TextAlign.right,
              style: context.text.labelLarge?.copyWith(color: t.body),
            ),
          ),
        ],
      ),
    );
  }
}

class MovesEmpty extends StatelessWidget {
  const MovesEmpty({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: Gaps.section),
    child: Text(context.l10n.movesEmpty, style: context.text.bodyMedium),
  );
}

/// La escala se ajusta al más alto para que Onix o Wailord quepan.
class SizeSection extends StatelessWidget {
  const SizeSection({super.key, required this.detail});
  final PokemonDetail detail;

  /// Estatura de la persona de referencia, en metros.
  static const personMeters = 1.6;
  static const _areaHeight = 150.0;
  static const _drawHeight = 112.0;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final l10n = context.l10n;
    final meters = detail.heightMeters;
    if (meters == null) return const SizedBox.shrink();
    final s = detail.summary;
    final pixelsPerMeter =
        _drawHeight / (meters > personMeters ? meters : personMeters);
    final personPx = personMeters * pixelsPerMeter;
    // Mínimo de 28 para que un Pokémon diminuto siga siendo visible.
    final pokemonPx = (meters * pixelsPerMeter).clamp(28.0, _drawHeight);
    final art = ArtSources(pokemonId: s.id, generationId: s.generationId);
    const ground = _areaHeight - 12;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(l10n.detailSizeTitle),
        const SizedBox(height: Gaps.sibling),
        SizedBox(
          height: _areaHeight,
          child: Stack(
            children: [
              for (final (m, px) in [
                (personMeters, personPx),
                (meters, pokemonPx),
              ]) ...[
                Positioned(
                  left: 0,
                  right: 0,
                  top: ground - px,
                  child: CustomPaint(
                    size: const Size(double.infinity, 1),
                    painter: _GuidePainter(t.ln2),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: ground - px + 3,
                  child: Text(
                    '${formatMeasure(context, m)} m',
                    style: context.text.labelMedium,
                  ),
                ),
              ],
              Positioned(
                left: 0,
                right: 0,
                top: ground,
                child: Divider(color: t.ln2, height: 1),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: _areaHeight - ground,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.person_rounded,
                      size: personPx * 1.15,
                      color: t.mute,
                    ),
                    const SizedBox(width: 40),
                    PokemonArt(
                      url: art.urlFor(ArtMode.illustration)!,
                      size: pokemonPx * 1.15,
                      summary: s,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              l10n.detailSizeYou(formatMeasure(context, personMeters)),
              style: context.text.labelMedium?.copyWith(color: t.body),
            ),
            const Spacer(),
            Flexible(
              child: Text(
                l10n.detailSizePokemon(
                  s.localizedName(context.languageCode),
                  formatMeasure(context, meters),
                  formatMeasure(context, detail.weightKg ?? 0),
                ),
                textAlign: TextAlign.right,
                style: context.text.labelMedium?.copyWith(color: t.body),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _GuidePainter extends CustomPainter {
  const _GuidePainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    for (var x = 0.0; x < size.width; x += 8) {
      canvas.drawLine(Offset(x, 0), Offset(x + 4, 0), paint);
    }
  }

  @override
  bool shouldRepaint(_GuidePainter old) => old.color != color;
}

class WhereLivesButton extends ConsumerWidget {
  const WhereLivesButton({super.key, required this.summary});
  final PokemonSummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final generation = (ref.watch(generationsProvider).value ?? const [])
        .where((g) => g.id == summary.generationId)
        .firstOrNull;
    if (generation == null) return const SizedBox.shrink();
    final region = generation.regionName;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: PokedexKey(
            label: l10n.detailWhereLives(region),
            kind: PokedexKeyKind.outline,
            onPressed: () => showRegionInCatalog(context, ref, generation.id),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.detailWhereLivesHint(region),
          textAlign: TextAlign.center,
          style: context.text.bodySmall,
        ),
      ],
    );
  }
}
