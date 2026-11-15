import 'dart:ui' show PathMetric;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../app/home_tab.dart';
import '../../../../app/theme/app_tokens.dart';
import '../../../../shared/l10n_x.dart';
import '../../domain/entities/catalog_query.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../catalog/catalog_controller.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Semantics(
    header: true,
    child: Text(text, style: context.text.titleMedium),
  );
}

String formatMeasure(BuildContext context, double value) =>
    NumberFormat.decimalPatternDigits(
      locale: context.languageCode,
      decimalDigits: 1,
    ).format(value);

class DetailBanner extends StatelessWidget {
  const DetailBanner({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
  });
  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      // Par de tinte: el color al 16 % detrás de texto de tinta.
      color: color.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(Radii.block),
    ),
    child: Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: context.text.bodyMedium?.copyWith(color: context.tokens.ink),
          ),
        ),
      ],
    ),
  );
}

class DetailBadge extends StatelessWidget {
  const DetailBadge(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: t.warning.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(Radii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.workspace_premium_outlined, size: 15, color: t.warning),
          const SizedBox(width: 5),
          Text(text, style: context.text.labelMedium?.copyWith(color: t.ink)),
        ],
      ),
    );
  }
}

class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
    this.hint,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final box = Container(
      constraints: BoxConstraints(minHeight: onTap == null ? 46 : 48),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: t.ln, width: 1.5),
        borderRadius: BorderRadius.circular(Radii.block),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: context.text.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (onTap != null) ...[
            const SizedBox(width: 4),
            Icon(Icons.arrow_forward_rounded, size: 16, color: t.acTexto),
          ],
        ],
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: t.mute),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.text.labelMedium?.copyWith(letterSpacing: 0.72),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        if (onTap == null)
          box
        else
          // `container`: nodo propio para TalkBack, para que el botón se active por separado.
          Semantics(
            container: true,
            button: true,
            hint: hint,
            child: InkWell(
              borderRadius: BorderRadius.circular(Radii.block),
              onTap: onTap,
              child: box,
            ),
          ),
      ],
    );
  }
}

/// El género no está: la base local no lo guarda.
class AboutSection extends ConsumerWidget {
  const AboutSection({super.key, required this.detail});
  final PokemonDetail detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final lang = context.languageCode;
    final flavor = lang == 'es'
        ? detail.flavorEs ?? detail.flavorEn
        : detail.flavorEn;
    final generation = (ref.watch(generationsProvider).value ?? const [])
        .where((g) => g.id == detail.summary.generationId)
        .firstOrNull;
    String measure(double? v, String unit) =>
        v == null ? 'N/D' : '${formatMeasure(context, v)} $unit';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (flavor != null) ...[
          Text(flavor, style: context.text.bodyMedium?.copyWith(height: 1.5)),
          const SizedBox(height: Gaps.sibling),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StatTile(
                icon: Icons.scale_outlined,
                label: l10n.weight,
                value: measure(detail.weightKg, 'kg'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: StatTile(
                icon: Icons.height_rounded,
                label: l10n.height,
                value: measure(detail.heightMeters, 'm'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: StatTile(
                icon: Icons.egg_outlined,
                label: l10n.eggGroups,
                value: detail.eggGroups.isEmpty
                    ? 'N/D'
                    : detail.eggGroups.join(', '),
              ),
            ),
          ],
        ),
        const SizedBox(height: Gaps.sibling),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StatTile(
                icon: Icons.catching_pokemon,
                label: l10n.captureRate,
                value: detail.captureRate?.toString() ?? 'N/D',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: generation == null
                  ? const SizedBox.shrink()
                  : StatTile(
                      icon: Icons.public_rounded,
                      label: l10n.regionLabel,
                      value: '${generation.regionName} (${generation.roman})',
                      hint: l10n.regionOpen(generation.regionName),
                      onTap: () =>
                          showRegionInCatalog(context, ref, generation.id),
                    ),
            ),
          ],
        ),
        if (detail.abilities.isNotEmpty) ...[
          const SizedBox(height: Gaps.sibling),
          AbilitiesSection(abilities: detail.abilities),
        ],
      ],
    );
  }
}

void showRegionInCatalog(
  BuildContext context,
  WidgetRef ref,
  int generationId,
) {
  ref
      .read(catalogControllerProvider.notifier)
      .apply(CatalogQuery(generationId: generationId));
  ref.read(homeTabProvider.notifier).show(0);
  Navigator.of(context).popUntil((r) => r.isFirst);
}

/// La oculta lleva la palabra "(oculta)", nunca solo el borde.
class AbilitiesSection extends StatelessWidget {
  const AbilitiesSection({super.key, required this.abilities});
  final List<PokemonAbility> abilities;

  @override
  Widget build(BuildContext context) {
    final lang = context.languageCode;
    final t = context.tokens;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.catching_pokemon_outlined, size: 14, color: t.mute),
            const SizedBox(width: 6),
            Text(
              context.l10n.detailAbilities.toUpperCase(),
              style: context.text.labelMedium?.copyWith(letterSpacing: 0.72),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final a in abilities)
              Tooltip(
                message: a.shortEffect(lang) ?? '',
                triggerMode: TooltipTriggerMode.longPress,
                child: CustomPaint(
                  painter: a.isHidden
                      ? _DashedBorderPainter(color: t.ln, radius: Radii.block)
                      : null,
                  child: Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: a.isHidden
                        ? null
                        : BoxDecoration(
                            border: Border.all(color: t.ln, width: 1.5),
                            borderRadius: BorderRadius.circular(Radii.block),
                          ),
                    child: Center(
                      widthFactor: 1,
                      child: Text.rich(
                        TextSpan(
                          text: a.ability.localizedName(lang),
                          children: [
                            if (a.isHidden)
                              TextSpan(
                                text: ' ${context.l10n.detailHiddenAbility}',
                                style: TextStyle(color: t.mute),
                              ),
                          ],
                        ),
                        style: context.text.labelLarge,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.color, required this.radius});
  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final outline = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          Radius.circular(radius),
        ).deflate(0.75),
      );
    for (final PathMetric metric in outline.computeMetrics()) {
      for (var at = 0.0; at < metric.length; at += 8) {
        canvas.drawPath(metric.extractPath(at, at + 4), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) =>
      old.color != color || old.radius != radius;
}
