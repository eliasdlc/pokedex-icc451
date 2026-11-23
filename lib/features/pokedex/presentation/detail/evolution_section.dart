import 'package:flutter/material.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../app/theme/type_palette.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../../shared/l10n_x.dart';
import '../../../../shared/widgets/choice_pill.dart';
import '../../../../shared/widgets/type_chip.dart';
import '../../domain/entities/art_sources.dart';
import '../../domain/entities/poke_type.dart';
import '../../domain/entities/pokemon_detail.dart';
import 'detail_sections.dart';
import 'normal_shiny_switch.dart';
import 'pokemon_art.dart';

class MatchupsSection extends StatelessWidget {
  const MatchupsSection({super.key, required this.matchups});
  final TypeMatchups matchups;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (matchups.multipliers.isEmpty) return const SizedBox.shrink();
    Widget group(String title, Map<PokeType, double> entries) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        const SizedBox(height: Gaps.sibling),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final e in entries.entries)
              MatchupChip(type: e.key, multiplier: e.value),
          ],
        ),
      ],
    );
    final groups = [
      if (matchups.weaknesses.isNotEmpty)
        group(l10n.detailWeaknesses, matchups.weaknesses),
      if (matchups.resistances.isNotEmpty)
        group(l10n.detailResistances, matchups.resistances),
      if (matchups.immunities.isNotEmpty)
        group(l10n.detailImmunities, {
          for (final t in matchups.immunities) t: 0,
        }),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (i, g) in groups.indexed) ...[
          if (i > 0) const SizedBox(height: Gaps.section),
          g,
        ],
      ],
    );
  }
}

class MatchupChip extends StatelessWidget {
  const MatchupChip({super.key, required this.type, required this.multiplier});
  final PokeType type;
  final double multiplier;

  static String format(double v) =>
      '×${switch (v) {
        0.5 => '½',
        0.25 => '¼',
        _ => v == v.roundToDouble() ? v.toInt().toString() : v.toString(),
      }}';

  @override
  Widget build(BuildContext context) {
    final slug = type.slug;
    final fore = onType(slug);
    return Container(
      height: 36,
      constraints: const BoxConstraints(minWidth: 160),
      padding: const EdgeInsets.fromLTRB(3, 3, 16, 3),
      decoration: BoxDecoration(
        color: typeColor(slug),
        borderRadius: BorderRadius.circular(Radii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: TypeIcon(slug: slug, size: 16, color: typeColor(slug)),
          ),
          const SizedBox(width: 8),
          Text(
            '${type.localizedName(context.languageCode)} ${format(multiplier)}',
            maxLines: 1,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: fore,
            ),
          ),
        ],
      ),
    );
  }
}

String evolutionConditionText(AppLocalizations l10n, EvolutionCondition c) {
  String pretty(String slug) => slug.replaceAll('-', ' ');
  final parts = <String>[
    if (c.minLevel != null) l10n.evoLevel(c.minLevel!),
    if (c.item != null) l10n.evoItem(pretty(c.item!)),
    if (c.trigger == 'trade') l10n.evoTrade,
    if (c.minHappiness != null) l10n.evoFriendship,
    if (c.timeOfDay != null)
      l10n.evoTime(c.timeOfDay == 'night' ? l10n.timeNight : l10n.timeDay),
  ];
  return parts.isEmpty ? l10n.evoOther : parts.join(', ');
}

/// Una rama (Eevee) baja con sangría para que no parezca que viene de la anterior.
class EvolutionSection extends StatelessWidget {
  const EvolutionSection({
    super.key,
    required this.root,
    required this.currentId,
    required this.hue,
    required this.onOpen,
  });
  final EvolutionNode? root;
  final int currentId;

  final Color hue;
  final ValueChanged<int> onOpen;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final l10n = context.l10n;
    final tree = root;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(l10n.detailEvolutions),
        const SizedBox(height: Gaps.sibling),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: t.sf,
            border: Border.all(color: t.ln, width: 1.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: tree == null || tree.isLeaf
              ? Text(
                  l10n.noEvolution,
                  textAlign: TextAlign.center,
                  style: context.text.bodyLarge,
                )
              : _branch(context, tree),
        ),
      ],
    );
  }

  Widget _branch(BuildContext context, EvolutionNode node) {
    final many = node.children.length > 1;
    return Column(
      children: [
        EvolutionTile(
          node: node,
          isCurrent: node.speciesId == currentId,
          hue: hue,
          onTap: () => onOpen(node.speciesId),
        ),
        for (final child in node.children) ...[
          _Condition(condition: child.condition),
          Padding(
            padding: EdgeInsets.only(left: many ? 16 : 0),
            child: _branch(context, child),
          ),
        ],
      ],
    );
  }
}

class _Condition extends StatelessWidget {
  const _Condition({required this.condition});
  final EvolutionCondition? condition;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final c = condition;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_downward_rounded, size: 18, color: t.acTexto),
          if (c != null) ...[
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                evolutionConditionText(context.l10n, c),
                textAlign: TextAlign.center,
                style: context.text.labelLarge?.copyWith(color: t.acTexto),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class EvolutionTile extends StatelessWidget {
  const EvolutionTile({
    super.key,
    required this.node,
    required this.isCurrent,
    required this.hue,
    required this.onTap,
  });
  final EvolutionNode node;
  final bool isCurrent;
  final Color hue;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final name = node.slug[0].toUpperCase() + node.slug.substring(1);
    final number = 'Nº ${node.speciesId.toString().padLeft(4, '0')}';
    // La ilustración existe para todos los Pokémon; la generación no importa.
    final art = ArtSources(pokemonId: node.speciesId, generationId: 1);
    return Semantics(
      button: !isCurrent,
      selected: isCurrent,
      label: '$name, $number',
      excludeSemantics: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(34),
        onTap: isCurrent ? null : onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 68),
          padding: const EdgeInsets.fromLTRB(6, 6, 20, 6),
          decoration: BoxDecoration(
            color: t.sf,
            border: Border.all(color: isCurrent ? t.ac : t.ln, width: 1.5),
            borderRadius: BorderRadius.circular(34),
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isCurrent ? hue : t.sf2,
                  shape: BoxShape.circle,
                ),
                child: PokemonArt(
                  url: art.urlFor(ArtMode.illustration)!,
                  size: 48,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.text.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(number, style: context.text.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormsSection extends StatelessWidget {
  const FormsSection({
    super.key,
    required this.varieties,
    required this.currentId,
    required this.name,
    required this.onForm,
    required this.shiny,
    required this.canShiny,
    required this.onShiny,
  });
  final List<PokemonVariety> varieties;
  final int currentId;
  final String name;
  final ValueChanged<int> onForm;
  final bool shiny;

  final bool canShiny;
  final ValueChanged<bool> onShiny;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final lang = context.languageCode;
    final many = varieties.length > 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(l10n.detailForms),
        const SizedBox(height: Gaps.sibling),
        if (many)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final v in varieties)
                ChoicePill(
                  label: v.isDefault
                      ? l10n.formDefault
                      : v.formName(lang) ?? '#${v.id}',
                  selected: v.id == currentId,
                  onTap: () => onForm(v.id),
                ),
            ],
          ),
        if (canShiny) ...[
          if (many) const SizedBox(height: Gaps.sibling),
          NormalShinySwitch(shiny: shiny, onChanged: onShiny),
        ],
        const SizedBox(height: 8),
        Text(
          many ? l10n.detailFormsHint : l10n.detailFormsNone(name),
          style: context.text.bodySmall,
        ),
      ],
    );
  }
}
