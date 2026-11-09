import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../app/theme/type_palette.dart';
import '../../../../shared/l10n_x.dart';
import '../../../../shared/widgets/connectivity_indicator.dart';
import '../../../../shared/widgets/favorite_button.dart';
import '../../../../shared/widgets/type_chip.dart';
import '../../domain/entities/art_sources.dart';
import '../../domain/entities/pokemon_summary.dart';
import 'art_mode_switch.dart';
import 'detail_providers.dart';
import 'pokemon_art.dart';

class DetailBarButton extends StatelessWidget {
  const DetailBarButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.overlay = true,
    this.color,
  });

  final IconData icon;
  final String label;

  final VoidCallback? onTap;
  final bool overlay;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      excludeSemantics: true,
      child: Tooltip(
        message: label,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Opacity(
            opacity: enabled ? 1 : 0.4,
            child: SizedBox.square(
              dimension: 48,
              child: Center(
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: overlay
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          // Pintura cruda: no cambia con el tema.
                          color: Colors.black.withValues(alpha: 0.32),
                        )
                      : null,
                  child: Icon(
                    icon,
                    size: 24,
                    color: overlay ? Colors.white : color ?? context.tokens.ink,
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

class DetailHero extends ConsumerStatefulWidget {
  const DetailHero({
    super.key,
    required this.pokemon,
    required this.number,
    required this.selection,
    required this.available,
    required this.onArtSelected,
    required this.isFavorite,
    required this.onFavorite,
    required this.onBack,
    required this.onCry,
    required this.tabs,
    this.playIntro = true,
    this.formName,
    this.badges = const [],
  });

  final PokemonSummary pokemon;

  final String number;
  final ArtSelection selection;
  final Set<ArtMode> available;
  final ValueChanged<ArtMode> onArtSelected;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onBack;
  final VoidCallback? onCry;
  final Widget tabs;
  final bool playIntro;
  final String? formName;
  final List<Widget> badges;

  @override
  ConsumerState<DetailHero> createState() => _DetailHeroState();
}

class _DetailHeroState extends ConsumerState<DetailHero>
    with TickerProviderStateMixin {
  late final AnimationController _drop = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );

  late final AnimationController _idle = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  );

  bool? _reduced;

  @override
  void initState() {
    super.initState();
    _drop.addStatusListener((status) {
      if (status == AnimationStatus.completed && _reduced == false) {
        _idle.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _drop.dispose();
    _idle.dispose();
    super.dispose();
  }

  void _applyMotion(bool reduced) {
    if (_reduced == reduced) return;
    final first = _reduced == null;
    _reduced = reduced;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (reduced) {
        _idle.stop();
        _drop.value = 1;
      } else if (first && widget.playIntro) {
        _drop.forward(from: 0);
      } else {
        _drop.value = 1;
        _idle.repeat(reverse: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _applyMotion(reducedMotion(context, ref));
    final t = context.tokens;
    final s = widget.pokemon;
    final lang = context.languageCode;
    final hue = typeColor(s.types.first.slug);
    final barTop = math.max(56.0, MediaQuery.paddingOf(context).top + 2);
    return Stack(
      children: [
        SizedBox(
          height: 430,
          width: double.infinity,
          child: ColoredBox(
            color: hue,
            child: Stack(
              children: [
                if (s.nameJa != null)
                  Positioned(
                    top: 170,
                    left: 0,
                    right: 0,
                    height: 110,
                    child: ExcludeSemantics(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          s.nameJa!,
                          maxLines: 1,
                          style: context.japaneseText(
                            68,
                            Colors.white.withValues(alpha: 0.16),
                          ),
                        ),
                      ),
                    ),
                  ),
                const Positioned(top: 100, left: 0, right: 0, child: _Glow()),
                const Positioned(
                  top: 350,
                  left: 0,
                  right: 0,
                  child: _Platform(),
                ),
                Positioned(
                  top: 148,
                  left: 0,
                  right: 0,
                  child: RepaintBoundary(child: _sprite()),
                ),
                Positioned(
                  top: 106,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ArtModeSwitch(
                      selection: widget.selection,
                      available: widget.available,
                      onSelect: widget.onArtSelected,
                      inactiveInk: inkOn(hue),
                    ),
                  ),
                ),
                Positioned(
                  top: barTop,
                  left: 16,
                  right: 16,
                  height: 48,
                  child: _topBar(context),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 400),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            decoration: BoxDecoration(
              color: t.bg,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                Text(
                  widget.number,
                  style: context.text.titleSmall?.copyWith(
                    fontSize: 14,
                    color: t.mute,
                    letterSpacing: 0.84,
                  ),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Semantics(
                    header: true,
                    child: Text(
                      s.localizedName(lang),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: context.text.displayLarge?.copyWith(
                        height: 1.25,
                        letterSpacing: -0.64,
                      ),
                    ),
                  ),
                ),
                if (widget.formName != null)
                  Text(
                    widget.formName!,
                    style: context.text.bodyMedium?.copyWith(color: t.mute),
                  ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    for (final type in s.types) TypeChip(type),
                    ...widget.badges,
                  ],
                ),
                const SizedBox(height: 10),
                widget.tabs,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _sprite() {
    final reduced = _reduced ?? false;
    final art = PokemonArt(
      url: widget.selection.url,
      size: 236,
      summary: widget.pokemon,
      pixelArt: widget.selection.shown == ArtMode.pixel,
    );
    if (reduced) return Center(child: art);
    return Center(
      child: AnimatedBuilder(
        animation: Listenable.merge([_drop, _idle]),
        child: art,
        builder: (context, child) {
          // Sale 90 px por encima y rebota hasta su sitio.
          final fall = (1 - Curves.bounceOut.transform(_drop.value)) * -90;
          final bob = Curves.easeInOut.transform(_idle.value) * -6;
          return Transform.translate(
            offset: Offset(0, fall + bob),
            child: child,
          );
        },
      ),
    );
  }

  Widget _topBar(BuildContext context) {
    final l10n = context.l10n;
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: DetailBarButton(
            icon: Icons.chevron_left_rounded,
            label: MaterialLocalizations.of(context).backButtonTooltip,
            onTap: widget.onBack,
          ),
        ),
        const Align(alignment: Alignment.center, child: _HeroIndicator()),
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DetailBarButton(
                icon: Icons.volume_up_rounded,
                label: widget.onCry == null
                    ? l10n.detailCryUnavailable
                    : l10n.detailCryReplay,
                onTap: widget.onCry,
              ),
              const SizedBox(width: 8),
              FavoriteButton(
                isFavorite: widget.isFavorite,
                onToggle: widget.onFavorite,
                overlay: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroIndicator extends StatelessWidget {
  const _HeroIndicator();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          top: 8,
          bottom: 8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.tokens.sf,
              borderRadius: BorderRadius.circular(Radii.pill),
            ),
          ),
        ),
        const ConnectivityIndicator(),
      ],
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow();

  @override
  Widget build(BuildContext context) => Center(
    child: SizedBox.square(
      dimension: 330,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              Colors.white.withValues(alpha: 0.5),
              Colors.white.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    ),
  );
}

class _Platform extends StatelessWidget {
  const _Platform();

  @override
  Widget build(BuildContext context) => Center(
    child: SizedBox(
      width: 240,
      height: 44,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.16),
              borderRadius: const BorderRadius.all(Radius.elliptical(120, 22)),
            ),
            child: const SizedBox.expand(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: SizedBox(
              width: 204,
              height: 30,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: const BorderRadius.all(
                    Radius.elliptical(102, 15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
