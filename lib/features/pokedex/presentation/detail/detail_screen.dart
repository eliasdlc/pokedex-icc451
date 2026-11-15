import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/providers.dart';
import '../../../../app/theme/app_tokens.dart';
import '../../../../app/theme/type_palette.dart';
import '../../../../core/media/media_cache.dart';
import '../../../../shared/l10n_x.dart';
import '../../../../shared/widgets/pokedex_header.dart';
import '../../../../shared/widgets/pokedex_key.dart';
import '../../../../shared/widgets/state_message.dart';
import '../../domain/entities/art_sources.dart';
import '../../domain/entities/poke_type.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../../domain/entities/pokemon_summary.dart';
import '../catalog/catalog_controller.dart';
import 'detail_compact_header.dart';
import 'detail_hero.dart';
import 'detail_providers.dart';
import 'detail_sections.dart';
import 'detail_tabs.dart';
import 'evolution_section.dart';
import 'moves_section.dart';
import 'share_card.dart';
import 'stats_section.dart';

class DetailScreen extends ConsumerStatefulWidget {
  const DetailScreen({super.key, required this.pokemonId});
  final int pokemonId;

  static Future<void> open(BuildContext context, int id) => Navigator.of(
    context,
  ).push(MaterialPageRoute<void>(builder: (_) => DetailScreen(pokemonId: id)));

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  DetailTab _tab = DetailTab.about;

  bool _shiny = false;

  int? _formId;

  ArtMode? _artChoice;

  /// Al cambiar de forma se sigue mostrando lo último pintado, sin parpadear con el esqueleto.
  PokemonDetail? _shown;

  /// El grito y la caída suceden una vez por apertura, aunque la pantalla se reconstruya.
  bool _openedOnce = false;

  int? _versionGroupId;
  MoveLearnMethod _method = MoveLearnMethod.levelUp;
  MoveSort _sort = MoveSort.level;

  int get _currentId => _formId ?? widget.pokemonId;

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(detailProvider(_currentId));
    final l10n = context.l10n;
    if (detail.value != null) _shown = detail.value;
    final shown = detail.isLoading ? _shown : detail.value;
    if (shown != null) {
      return Scaffold(body: _body(context, shown));
    }
    // Sin ficha todavía: la placa da el botón de volver mientras carga.
    return Scaffold(
      appBar: PokedexHeader(title: l10n.navPokedex),
      body: switch (detail) {
        AsyncError() => StateMessage(
          icon: Icons.error_outline,
          title: l10n.errorTitle,
          body: l10n.errorBody,
        ),
        AsyncLoading() => const Center(
          child: SkeletonBox(height: 280, width: 280),
        ),
        _ => StateMessage(
          icon: Icons.help_outline,
          title: l10n.emptyResultsTitle,
          body: l10n.detailNotDownloaded,
        ),
      },
    );
  }

  ArtSources _sources(PokemonSummary s) => ArtSources(
    pokemonId: s.id,
    generationId: s.generationId,
    staticSprite: s.spriteUrl == null ? null : Uri.tryParse(s.spriteUrl!),
  );

  ({Uri url, MediaKind kind}) _cryRequest(PokemonSummary s) =>
      (url: _sources(s).cry, kind: MediaKind.cries);

  /// Sin archivo (sin red y nunca descargado) no suena nada y no hay error.
  Future<void> _cryOnOpen(
    PokemonSummary s, {
    required bool systemReduced,
  }) async {
    final settings = await ref.read(settingsProvider.future);
    if (!mounted || !settings.cryOnOpen) return;
    if (systemReduced || settings.reduceMotion) return;
    final file = await ref.read(mediaFileProvider(_cryRequest(s)).future);
    if (!mounted || file == null) return;
    await ref.read(cryPlayerProvider).play(file);
  }

  Future<void> _replayCry(PokemonSummary s) async {
    final file = await ref.read(mediaFileProvider(_cryRequest(s)).future);
    if (!mounted || file == null) return;
    await ref.read(cryPlayerProvider).play(file);
  }

  void _selectArt(ArtMode mode) => setState(() {
    _artChoice = mode;
    // El variocolor es una ilustración: al elegir otro modo se apaga.
    _shiny = false;
  });

  void _setShiny(bool value) => setState(() {
    _shiny = value;
    if (value) _artChoice = ArtMode.illustration;
  });

  void _selectForm(int id) => setState(() {
    _formId = id == widget.pokemonId ? null : id;
    _versionGroupId = null;
    _shiny = false;
  });

  Future<void> _toggleFavorite() async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    final result = await ref.read(toggleFavoriteProvider)(_currentId);
    debugPrint(
      'favorito $_currentId: ${result.elapsed.inMicroseconds / 1000} ms',
    );
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            result.isFavorite ? l10n.favoriteAdded : l10n.favoriteRemoved,
          ),
          duration: const Duration(milliseconds: 1200),
        ),
      );
  }

  Widget _body(BuildContext context, PokemonDetail d) {
    final t = context.tokens;
    final l10n = context.l10n;
    final lang = context.languageCode;
    final s = d.summary;
    final hue = typeColor(s.types.first.slug);

    final first = !_openedOnce;
    if (first) {
      _openedOnce = true;
      final systemReduced = MediaQuery.disableAnimationsOf(context);
      // Después del primer cuadro: no se arranca audio en medio de un build.
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => unawaited(_cryOnOpen(s, systemReduced: systemReduced)),
      );
    }

    final sources = _sources(s);
    final shinyUrl = d.shinyArtworkUrl == null
        ? null
        : Uri.tryParse(d.shinyArtworkUrl!);
    final selection = _shiny && shinyUrl != null
        ? ArtSelection(
            requested: ArtMode.illustration,
            shown: ArtMode.illustration,
            url: shinyUrl,
          )
        : sources.select(
            _artChoice ?? ref.watch(settingsProvider).value?.artMode,
          );
    final cryFile = ref.watch(mediaFileProvider(_cryRequest(s))).value;
    final onCry = cryFile == null ? null : () => unawaited(_replayCry(s));
    final number = d.nationalNumber.replaceFirst('#', 'Nº ');
    final tabs = DetailTabs(
      current: _tab,
      onSelect: (tab) => setState(() => _tab = tab),
    );
    final banners = <Widget>[
      if (d.isTampered)
        DetailBanner(
          icon: Icons.build_circle_outlined,
          text: l10n.tamperedBanner,
          color: t.warning,
        ),
      if (!d.isComplete)
        DetailBanner(
          icon: Icons.downloading,
          text: l10n.detailNotDownloaded,
          color: t.info,
        ),
    ];

    final variety = d.currentVariety;
    final formName = variety != null && !variety.isDefault
        ? variety.formName(lang)
        : null;

    final Widget header;
    if (_tab == DetailTab.about) {
      header = DetailHero(
        pokemon: s,
        number: number,
        selection: selection,
        available: {
          for (final m in ArtMode.values)
            if (sources.has(m)) m,
        },
        onArtSelected: _selectArt,
        isFavorite: s.isFavorite,
        onFavorite: _toggleFavorite,
        onBack: () => Navigator.maybePop(context),
        onCry: onCry,
        playIntro: first,
        tabs: tabs,
        formName: formName,
        badges: [
          if (d.isLegendary) DetailBadge(l10n.legendary),
          if (d.isMythical) DetailBadge(l10n.mythical),
        ],
      );
    } else {
      header = DetailCompactHeader(
        pokemon: s,
        number: number,
        isFavorite: s.isFavorite,
        onFavorite: _toggleFavorite,
        onBack: () => Navigator.maybePop(context),
        onCry: onCry,
        tabs: tabs,
      );
    }

    final content = _tabContent(context, d, hue, banners);
    if (_tab == DetailTab.about) {
      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: header),
          ...content,
        ],
      );
    }
    return Column(
      children: [
        header,
        Expanded(child: CustomScrollView(slivers: content)),
      ],
    );
  }

  List<Widget> _tabContent(
    BuildContext context,
    PokemonDetail d,
    Color hue,
    List<Widget> banners,
  ) {
    final width = MediaQuery.sizeOf(context).width;
    final side = math.max(Gaps.screen, (width - 600) / 2);
    final bottom = MediaQuery.paddingOf(context).bottom + 32;
    EdgeInsets padding(double top) =>
        EdgeInsets.fromLTRB(side, top, side, bottom);
    List<Widget> spaced(List<Widget> items) => [
      for (final (i, w) in items.indexed) ...[
        if (i > 0) const SizedBox(height: Gaps.section),
        w,
      ],
    ];
    final bannerBlock = [
      for (final b in banners) ...[b, const SizedBox(height: Gaps.sibling)],
    ];
    final s = d.summary;
    return switch (_tab) {
      DetailTab.about => [
        SliverPadding(
          padding: padding(0),
          sliver: SliverList.list(
            children: [
              ...bannerBlock,
              AboutSection(detail: d),
              const SizedBox(height: Gaps.section),
              PokedexKey(
                label: context.l10n.share,
                kind: PokedexKeyKind.outline,
                onPressed: () => ShareCardScreen.open(context, d),
              ),
            ],
          ),
        ),
      ],
      DetailTab.stats => [
        SliverPadding(
          padding: padding(Gaps.sibling),
          sliver: SliverList.list(
            children: [
              ...bannerBlock,
              StatsSection(stats: s.stats, hue: hue),
            ],
          ),
        ),
      ],
      DetailTab.evolutions => [
        SliverPadding(
          padding: padding(Gaps.sibling),
          sliver: SliverList.list(
            children: [
              ...bannerBlock,
              ...spaced([
                MatchupsSection(matchups: d.matchups),
                if (d.isComplete)
                  EvolutionSection(
                    root: d.evolution,
                    currentId: d.speciesId ?? s.id,
                    hue: hue,
                    onOpen: (id) => DetailScreen.open(context, id),
                  ),
                FormsSection(
                  varieties: d.varieties,
                  currentId: s.id,
                  name: s.localizedName(context.languageCode),
                  onForm: _selectForm,
                  shiny: _shiny,
                  canShiny: d.shinyArtworkUrl != null,
                  onShiny: _setShiny,
                ),
              ]),
            ],
          ),
        ),
      ],
      DetailTab.moves => [
        SliverPadding(
          padding: padding(Gaps.sibling),
          // Slivers propios: la lista se construye a medida que se ve, aunque tenga 100.
          sliver: SliverMainAxisGroup(
            slivers: [
              SliverList.list(children: bannerBlock),
              ..._moveSlivers(d),
              SliverList.list(
                children: [
                  const SizedBox(height: Gaps.section),
                  SizeSection(detail: d),
                  const SizedBox(height: Gaps.section),
                  WhereLivesButton(summary: s),
                ],
              ),
            ],
          ),
        ),
      ],
    };
  }

  List<Widget> _moveSlivers(PokemonDetail d) {
    final versionGroupId = _versionGroupId ?? d.defaultVersionGroupId;
    if (versionGroupId == null) return const [];
    final types = {
      for (final t in ref.watch(typesProvider).value ?? <PokeType>[]) t.id: t,
    };
    final moves = d.movesFor(
      versionGroupId: versionGroupId,
      method: _method,
      sort: _sort,
    );
    return [
      SliverToBoxAdapter(
        child: MovesHeader(
          versionGroups: d.versionGroups,
          versionGroupId: versionGroupId,
          method: _method,
          sort: _sort,
          onVersion: (id) => setState(() => _versionGroupId = id),
          onMethod: (m) => setState(() => _method = m),
          onSort: (s) => setState(() => _sort = s),
        ),
      ),
      if (moves.isEmpty)
        const SliverToBoxAdapter(child: MovesEmpty())
      else
        SliverList.builder(
          itemCount: moves.length,
          itemBuilder: (context, i) => MoveRow(
            move: moves[i],
            type: types[moves[i].typeId],
            first: i == 0,
          ),
        ),
    ];
  }
}
