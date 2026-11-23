import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/type_palette.dart';
import '../../../../shared/l10n_x.dart';
import '../../../../shared/widgets/type_chip.dart';
import '../../domain/entities/art_sources.dart';
import '../../domain/entities/poke_type.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../catalog/catalog_controller.dart';
import '../detail/card_facts.dart';
import '../detail/detail_providers.dart';
import '../detail/detail_sections.dart' show formatMeasure;
import '../detail/pokemon_art.dart';

// Objeto impreso: sus colores (marco dorado, tinta oscura) no cambian con el tema.
const _ink = Color(0xFF1B1B22);
const _inkSoft = Color(0xFF3B3B44);
const _gold = Color(0xFFFBEFB8);

/// Se maqueta a 240x336 y se escala con `FittedBox` en proporción 63:88.
class CollectibleCard extends ConsumerStatefulWidget {
  const CollectibleCard({super.key, required this.detail, this.shiny = false});

  final PokemonDetail detail;

  final bool shiny;

  static const designSize = Size(240, 336);

  /// Total de la Pokédex nacional, para "025/1025".
  static const pokedexTotal = 1025;

  @override
  ConsumerState<CollectibleCard> createState() => _CollectibleCardState();
}

class _CollectibleCardState extends ConsumerState<CollectibleCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shine = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  );
  bool _running = false;

  @override
  void dispose() {
    _shine.dispose();
    super.dispose();
  }

  void _sync(bool animate) {
    if (animate == _running) return;
    _running = animate;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      animate ? _shine.repeat() : _shine.stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final types = {
      for (final t in ref.watch(typesProvider).value ?? <PokeType>[]) t.id: t,
    };
    final facts = CardFacts.from(widget.detail, types);
    _sync(facts.holo && !reducedMotion(context, ref));
    return Semantics(
      container: true,
      label: _semantics(context, facts),
      child: AspectRatio(
        aspectRatio: 63 / 88,
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox.fromSize(
            size: CollectibleCard.designSize,
            // La carta se repinta sola (brillo): que no arrastre a su padre.
            child: RepaintBoundary(
              child: _CardFace(
                detail: widget.detail,
                facts: facts,
                shiny: widget.shiny,
                shine: _shine,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _semantics(BuildContext context, CardFacts facts) {
    final s = widget.detail.summary;
    return '${s.localizedName(context.languageCode)}, '
        '${context.l10n.detailCardHp} ${facts.hp}';
  }
}

class _CardFace extends StatelessWidget {
  const _CardFace({
    required this.detail,
    required this.facts,
    required this.shiny,
    required this.shine,
  });
  final PokemonDetail detail;
  final CardFacts facts;
  final bool shiny;
  final Animation<double> shine;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final s = detail.summary;
    final hue = typeColor(facts.typeSlug);
    // Cara de la carta: el color del tipo aclarado, para que la tinta oscura
    // se lea también sobre Siniestro, Fantasma o Dragón.
    final face = Color.lerp(hue, Colors.white, 0.35)!;
    final number = (detail.speciesId ?? s.id).toString().padLeft(3, '0');
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(-0.6, -1),
          end: Alignment(0.6, 1),
          colors: [Color(0xFFF7DC5A), Color(0xFFEFC43A), Color(0xFFF9E27A)],
        ),
        border: Border.all(color: const Color(0xFFC59A1E)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
        decoration: BoxDecoration(
          color: face,
          borderRadius: BorderRadius.circular(6),
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: RadialGradient(
            center: const Alignment(-0.25, -0.1),
            radius: 0.55,
            colors: [
              Colors.white.withValues(alpha: 0.35),
              Colors.white.withValues(alpha: 0),
            ],
          ),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(fontFamily: 'Poppins', color: _ink),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Header(detail: detail, facts: facts),
              const SizedBox(height: 3),
              _ArtWindow(
                detail: detail,
                facts: facts,
                shiny: shiny,
                shine: shine,
                face: face,
              ),
              const SizedBox(height: 3),
              _SpeciesStrip(detail: detail, number: number),
              const SizedBox(height: 5),
              Expanded(child: _Attacks(facts: facts)),
              _Footer(facts: facts),
              const SizedBox(height: 3),
              _Flavor(detail: detail),
              const SizedBox(height: 2),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.detailCardArtCredit,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 5,
                        fontWeight: FontWeight.w500,
                        color: Color(0xBF1B1B22),
                      ),
                    ),
                  ),
                  Text(
                    '$number/${CollectibleCard.pokedexTotal}',
                    style: const TextStyle(
                      fontSize: 5.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xD91B1B22),
                    ),
                  ),
                  // Poppins no trae la estrella: se dibuja como icono.
                  if (facts.holo)
                    const Icon(Icons.star_rounded, size: 7, color: _ink),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// El tipo normal es la energía incolora.
class _Energy extends StatelessWidget {
  const _Energy({required this.slug, required this.size});
  final String slug;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: typeColor(slug),
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 1),
      boxShadow: const [
        BoxShadow(
          color: Color(0x40000000),
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ],
    ),
    child: TypeIcon(slug: slug, size: size * 0.62, color: onType(slug)),
  );
}

class _Header extends StatelessWidget {
  const _Header({required this.detail, required this.facts});
  final PokemonDetail detail;
  final CardFacts facts;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final stage = switch (facts.stage) {
      CardStage.basic => l10n.detailCardStageBasic,
      CardStage.stage1 => l10n.detailCardStage1,
      CardStage.stage2 => l10n.detailCardStage2,
    };
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  stage,
                  style: const TextStyle(
                    fontSize: 6.5,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  detail.summary.localizedName(context.languageCode),
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.3,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        Text(
          l10n.detailCardHp,
          style: const TextStyle(fontSize: 7, fontWeight: FontWeight.w700),
        ),
        const SizedBox(width: 2),
        Text(
          '${facts.hp}',
          style: const TextStyle(
            fontSize: 16,
            height: 1.2,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 3),
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: _Energy(slug: facts.typeSlug, size: 16),
        ),
      ],
    );
  }
}

class _ArtWindow extends StatelessWidget {
  const _ArtWindow({
    required this.detail,
    required this.facts,
    required this.shiny,
    required this.shine,
    required this.face,
  });
  final PokemonDetail detail;
  final CardFacts facts;
  final bool shiny;
  final Animation<double> shine;
  final Color face;

  @override
  Widget build(BuildContext context) {
    final s = detail.summary;
    final shinyUrl = shiny ? detail.shinyArtworkUrl : null;
    final url =
        (shinyUrl != null ? Uri.tryParse(shinyUrl) : null) ??
        ArtSources(
          pokemonId: s.id,
          generationId: s.generationId,
        ).urlFor(ArtMode.illustration)!;
    final hue = typeColor(facts.typeSlug);
    final window = Container(
      height: 124,
      decoration: BoxDecoration(
        color: hue,
        border: Border.all(color: _gold, width: 3),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  radius: 0.8,
                  colors: [
                    Colors.white.withValues(alpha: 0.7),
                    Colors.white.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 2,
            child: Container(
              width: 150,
              height: 22,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.14),
                borderRadius: const BorderRadius.all(Radius.elliptical(75, 11)),
              ),
            ),
          ),
          PokemonArt(url: url, size: 118, summary: s),
        ],
      ),
    );
    if (!facts.holo) return window;
    return AnimatedBuilder(
      animation: shine,
      child: window,
      builder: (context, child) => ShaderMask(
        blendMode: BlendMode.overlay,
        shaderCallback: (bounds) => _rainbow(shine.value).createShader(bounds),
        child: child,
      ),
    );
  }

  /// Deslizarlo un ancho completo lo deja igual: el bucle no da salto.
  static LinearGradient _rainbow(double t) => LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    tileMode: TileMode.repeated,
    transform: _Slide(t),
    colors: const [
      Color(0xD9FF6EC7),
      Color(0xD9FFD36E),
      Color(0xD97CFFB2),
      Color(0xD96EC9FF),
      Color(0xD9B07CFF),
      Color(0xD9FF6EC7),
    ],
  );
}

class _Slide extends GradientTransform {
  const _Slide(this.t);
  final double t;

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) =>
      Matrix4.translationValues(bounds.width * t, 0, 0);
}

class _SpeciesStrip extends StatelessWidget {
  const _SpeciesStrip({required this.detail, required this.number});
  final PokemonDetail detail;
  final String number;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    String measure(double? v, String unit) =>
        v == null ? 'N/D' : '${formatMeasure(context, v)} $unit';
    return Container(
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        gradient: const LinearGradient(
          colors: [Color(0xFFE9C766), Color(0xFFFBEFC0), Color(0xFFE9C766)],
        ),
      ),
      child: Text(
        'Nº $number  ${l10n.height} ${measure(detail.heightMeters, 'm')}  '
        '${l10n.weight} ${measure(detail.weightKg, 'kg')}',
        maxLines: 1,
        style: const TextStyle(
          fontSize: 6,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600,
          color: Color(0xFF3A2F12),
        ),
      ),
    );
  }
}

class _Attacks extends StatelessWidget {
  const _Attacks({required this.facts});
  final CardFacts facts;

  @override
  Widget build(BuildContext context) {
    if (facts.attacks.isEmpty) {
      return Center(
        child: Text(
          context.l10n.detailCardNoAttacks,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 7, color: _inkSoft),
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final (i, a) in facts.attacks.indexed) ...[
          if (i > 0)
            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(vertical: 3),
              color: _ink.withValues(alpha: 0.18),
            ),
          _AttackRow(attack: a),
        ],
      ],
    );
  }
}

class _AttackRow extends StatelessWidget {
  const _AttackRow({required this.attack});
  final CardAttack attack;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final klass = switch (attack.damageClass) {
      DamageClass.physical => l10n.detailCardClassPhysical,
      DamageClass.special => l10n.detailCardClassSpecial,
      DamageClass.status => l10n.detailCardClassStatus,
    };
    final accuracy = attack.accuracy == null
        ? ''
        : ', ${l10n.detailCardAccuracy(attack.accuracy!)}';
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 48,
              child: Row(
                children: [
                  // El primer símbolo es del tipo del movimiento; el resto, incoloros.
                  for (var i = 0; i < attack.cost; i++) ...[
                    if (i > 0) const SizedBox(width: 2),
                    _Energy(
                      slug: i == 0 ? attack.typeSlug : 'normal',
                      size: 14,
                    ),
                  ],
                ],
              ),
            ),
            Expanded(
              child: Text(
                attack.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11.5,
                  height: 1.3,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              width: 36,
              child: Text(
                attack.damage?.toString() ?? '',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            '$klass$accuracy',
            maxLines: 1,
            style: const TextStyle(fontSize: 6, color: _inkSoft),
          ),
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.facts});
  final CardFacts facts;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final weak = facts.weakness;
    final resist = facts.resistance;
    Widget cell(String label, Widget value) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 5.5, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 1),
        value,
      ],
    );
    const valueStyle = TextStyle(fontSize: 8, fontWeight: FontWeight.w700);
    return Column(
      children: [
        Container(height: 1, color: _ink.withValues(alpha: 0.35)),
        const SizedBox(height: 3),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cell(
              l10n.detailCardWeakness,
              weak == null
                  ? const Text('-', style: valueStyle)
                  : Row(
                      children: [
                        _Energy(slug: weak.slug, size: 12),
                        const SizedBox(width: 2),
                        Text(
                          '×${facts.weaknessMultiplier!.round()}',
                          style: valueStyle,
                        ),
                      ],
                    ),
            ),
            cell(
              l10n.detailCardResistance,
              resist == null
                  ? const Text('-', style: valueStyle)
                  : Row(
                      children: [
                        _Energy(slug: resist.slug, size: 12),
                        const SizedBox(width: 2),
                        // Convención de las cartas: la resistencia resta 30.
                        const Text('−30', style: valueStyle),
                      ],
                    ),
            ),
            cell(
              l10n.detailCardRetreat,
              Row(
                children: [
                  for (var i = 0; i < facts.retreat; i++) ...[
                    if (i > 0) const SizedBox(width: 2),
                    const _Energy(slug: 'normal', size: 12),
                  ],
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Flavor extends StatelessWidget {
  const _Flavor({required this.detail});
  final PokemonDetail detail;

  @override
  Widget build(BuildContext context) {
    final lang = context.languageCode;
    final text =
        (lang == 'es' ? detail.flavorEs ?? detail.flavorEn : detail.flavorEn)
            ?.replaceAll(RegExp(r'\s+'), ' ')
            .trim();
    return Container(
      height: 17,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.35),
        border: Border.all(color: _gold),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        text ?? '',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 5.5,
          height: 1.3,
          fontStyle: FontStyle.italic,
          color: Color(0xFF2A2A30),
        ),
      ),
    );
  }
}
