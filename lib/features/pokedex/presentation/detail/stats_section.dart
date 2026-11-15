import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../../shared/l10n_x.dart';
import '../../domain/entities/pokemon_summary.dart';
import 'detail_providers.dart';

String statLabel(AppLocalizations l10n, StatKind kind) => switch (kind) {
  StatKind.hp => l10n.stat_hp,
  StatKind.attack => l10n.stat_attack,
  StatKind.defense => l10n.stat_defense,
  StatKind.specialAttack => l10n.stat_specialAttack,
  StatKind.specialDefense => l10n.stat_specialDefense,
  StatKind.speed => l10n.stat_speed,
};

/// Máximo de la serie: 255.
int statPercent(int value) => (value / BaseStats.maxBaseStat * 100).round();

/// Seis estadísticas de 255.
int totalPercent(int total) =>
    (total / (BaseStats.maxBaseStat * 6) * 100).round();

class StatsSection extends ConsumerWidget {
  const StatsSection({super.key, required this.stats, required this.hue});
  final BaseStats stats;
  final Color hue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final animate = !reducedMotion(context, ref);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(l10n.detailStats, style: context.gameTextLarge),
        ),
        const SizedBox(height: Gaps.sibling),
        Row(
          children: [
            _Summary(
              icon: Icons.favorite_border_rounded,
              kind: StatKind.hp,
              value: stats.hp,
              hue: hue,
            ),
            const SizedBox(width: 8),
            _Summary(
              icon: Icons.flash_on_rounded,
              kind: StatKind.attack,
              value: stats.attack,
              hue: hue,
            ),
            const SizedBox(width: 8),
            _Summary(
              icon: Icons.shield_outlined,
              kind: StatKind.defense,
              value: stats.defense,
              hue: hue,
            ),
            const SizedBox(width: 8),
            _Summary(
              icon: Icons.bolt_rounded,
              kind: StatKind.speed,
              value: stats.speed,
              hue: hue,
            ),
          ],
        ),
        const SizedBox(height: Gaps.sibling),
        StatRadar(stats: stats, hue: hue),
        const SizedBox(height: Gaps.sibling),
        for (final (kind, value) in stats.entries)
          _BarRow(
            label: statLabel(l10n, kind),
            value: value,
            fraction: value / BaseStats.maxBaseStat,
            percent: statPercent(value),
            hue: hue,
            animate: animate,
          ),
        _BarRow(
          label: l10n.total,
          value: stats.total,
          fraction: stats.total / (BaseStats.maxBaseStat * 6),
          percent: totalPercent(stats.total),
          hue: hue,
          animate: animate,
          strong: true,
        ),
      ],
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({
    required this.icon,
    required this.kind,
    required this.value,
    required this.hue,
  });
  final IconData icon;
  final StatKind kind;
  final int value;
  final Color hue;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final label = statLabel(context.l10n, kind);
    return Expanded(
      child: Semantics(
        label: '$label $value',
        excludeSemantics: true,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          decoration: BoxDecoration(
            color: t.sf,
            border: Border.all(color: t.ln, width: 1.5),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: hue.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                // El glifo va en tinta: el color del tipo no se lee sobre su propio tinte
                // en los tipos claros.
                child: Icon(icon, size: 16, color: t.ink),
              ),
              const SizedBox(height: 4),
              Text('$value', style: context.gameTextLarge),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(label, style: context.text.bodySmall),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BarRow extends StatelessWidget {
  const _BarRow({
    required this.label,
    required this.value,
    required this.fraction,
    required this.percent,
    required this.hue,
    required this.animate,
    this.strong = false,
  });
  final String label;
  final int value;
  final double fraction;
  final int percent;
  final Color hue;
  final bool animate;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Semantics(
        label: '$label $value, $percent %',
        excludeSemantics: true,
        child: Row(
          children: [
            SizedBox(
              width: 76,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: context.text.bodyMedium?.copyWith(
                    fontWeight: strong ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 28,
              child: Text(
                '$value',
                textAlign: TextAlign.right,
                style: context.gameText,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: fraction.clamp(0, 1)),
                duration: animate
                    ? const Duration(milliseconds: 600)
                    : Duration.zero,
                curve: Curves.easeOutCubic,
                builder: (_, v, _) => ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: v,
                    minHeight: 6,
                    color: hue,
                    backgroundColor: t.sf2,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 44,
              child: Text(
                '$percent %',
                textAlign: TextAlign.right,
                style: context.text.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// La escala llega a [radarMax] (150): con 255 los comunes quedarían como un punto.
/// Las barras de abajo sí usan 255.
class StatRadar extends StatelessWidget {
  const StatRadar({super.key, required this.stats, required this.hue});
  final BaseStats stats;
  final Color hue;

  static const radarMax = 150;
  static const _radius = 80.0;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final l10n = context.l10n;
    final entries = stats.entries;
    return Semantics(
      label: l10n.detailStats,
      child: ExcludeSemantics(
        child: SizedBox(
          height: 250,
          child: LayoutBuilder(
            builder: (context, box) {
              final center = Offset(box.maxWidth / 2, 125);
              return Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _RadarPainter(
                        values: [
                          for (final (_, v) in entries)
                            math.min(v / radarMax, 1.0),
                        ],
                        hue: hue,
                        grid: t.ln,
                        radius: _radius,
                      ),
                    ),
                  ),
                  for (final (i, (kind, value)) in entries.indexed)
                    _label(
                      context,
                      center,
                      i,
                      '${statLabel(l10n, kind)}  $value',
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _label(BuildContext context, Offset center, int i, String text) {
    final angle = -math.pi / 2 + i * math.pi / 3;
    final vertex = center + Offset(math.cos(angle), math.sin(angle)) * _radius;
    // (desplazamiento del punto de anclaje, fracción del propio tamaño)
    final (gap, shift) = switch (i) {
      0 => (const Offset(0, -6), const Offset(-0.5, -1)),
      3 => (const Offset(0, 6), const Offset(-0.5, 0)),
      1 || 2 => (const Offset(8, 0), const Offset(0, -0.5)),
      _ => (const Offset(-8, 0), const Offset(-1, -0.5)),
    };
    return Positioned(
      left: vertex.dx + gap.dx,
      top: vertex.dy + gap.dy,
      child: FractionalTranslation(
        translation: shift,
        child: Text(
          text,
          maxLines: 1,
          style: context.text.labelMedium?.copyWith(color: context.tokens.body),
        ),
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  const _RadarPainter({
    required this.values,
    required this.hue,
    required this.grid,
    required this.radius,
  });
  final List<double> values;
  final Color hue;
  final Color grid;
  final double radius;

  Path _polygon(Offset center, double r, [List<double>? scale]) {
    final path = Path();
    for (var i = 0; i < 6; i++) {
      final angle = -math.pi / 2 + i * math.pi / 3;
      final k = r * (scale?[i] ?? 1);
      final p = center + Offset(math.cos(angle), math.sin(angle)) * k;
      i == 0 ? path.moveTo(p.dx, p.dy) : path.lineTo(p.dx, p.dy);
    }
    return path..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final line = Paint()
      ..color = grid
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (var ring = 1; ring <= 3; ring++) {
      canvas.drawPath(_polygon(center, radius * ring / 3), line);
    }
    for (var i = 0; i < 6; i++) {
      final angle = -math.pi / 2 + i * math.pi / 3;
      canvas.drawLine(
        center,
        center + Offset(math.cos(angle), math.sin(angle)) * radius,
        line,
      );
    }
    final shape = _polygon(center, radius, values);
    canvas.drawPath(shape, Paint()..color = hue.withValues(alpha: 0.28));
    canvas.drawPath(
      shape,
      Paint()
        ..color = hue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(_RadarPainter old) =>
      old.hue != hue || old.grid != grid || !_same(old.values, values);

  static bool _same(List<double> a, List<double> b) {
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
