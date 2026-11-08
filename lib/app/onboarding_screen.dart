import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/l10n_x.dart';
import '../shared/widgets/pixel_icon.dart';
import 'di/providers.dart';
import 'theme/app_tokens.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  static const _pageCount = 3;

  final _pages = PageController();
  int _page = 0;

  bool get _last => _page == _pageCount - 1;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  void _finish() => ref.read(settingsProvider.notifier).completeOnboarding();

  void _next() => _pages.nextPage(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOutCubic,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final slides = [
      (
        const PixelIcon(kind: PixelIconKind.pokedex, scale: 6),
        l10n.navegacionOnb1Title,
        l10n.navegacionOnb1Body,
      ),
      (
        Icon(Icons.wifi_tethering, size: 80, color: context.tokens.ac),
        l10n.onbTitle2,
        l10n.onbBody2,
      ),
      (
        const PixelIcon(kind: PixelIconKind.play, scale: 6),
        l10n.navegacionOnb3Title,
        l10n.navegacionOnb3Body,
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Gaps.screen),
          child: Column(
            children: [
              // "Saltar" ocupa su sitio en la última página, invisible, para
              // que nada se mueva al llegar a ella.
              Align(
                alignment: Alignment.centerRight,
                child: Visibility(
                  visible: !_last,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: context.tokens.ink,
                    ),
                    onPressed: _finish,
                    child: Text(
                      l10n.navegacionSkip,
                      style: context.text.labelLarge,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pages,
                  onPageChanged: (i) => setState(() => _page = i),
                  children: [
                    for (final (art, title, body) in slides)
                      _OnboardingPage(art: art, title: title, body: body),
                  ],
                ),
              ),
              _PageDots(current: _page, count: _pageCount),
              const SizedBox(height: Gaps.section),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _last ? _finish : _next,
                  child: Text(_last ? l10n.getStarted : l10n.baseContinue),
                ),
              ),
              const SizedBox(height: Gaps.section),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.art,
    required this.title,
    required this.body,
  });

  final Widget art;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 200,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: 240,
                height: 36,
                decoration: BoxDecoration(
                  color: t.sf2,
                  borderRadius: BorderRadius.circular(Radii.pill),
                ),
              ),
              Padding(padding: const EdgeInsets.only(bottom: 12), child: art),
            ],
          ),
        ),
        const SizedBox(height: Gaps.section),
        Text(
          title,
          textAlign: TextAlign.center,
          style: context.text.headlineMedium,
        ),
        const SizedBox(height: Gaps.sibling),
        Text(body, textAlign: TextAlign.center, style: context.text.bodyLarge),
      ],
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.current, required this.count});

  final int current;
  final int count;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Semantics(
      label: context.l10n.navegacionOnbPage(current + 1, count),
      excludeSemantics: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < count; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.all(3),
              width: i == current ? 22 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: i == current ? t.ac : t.mute,
                borderRadius: BorderRadius.circular(Radii.pill),
              ),
            ),
        ],
      ),
    );
  }
}
