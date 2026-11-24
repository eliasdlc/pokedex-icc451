import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/di/providers.dart';
import '../../../app/home_tab.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../shared/l10n_x.dart';
import '../../../shared/widgets/game_dialog_box.dart';
import '../../../shared/widgets/pokedex_header.dart';
import '../../pokedex/domain/entities/pokemon_summary.dart';
import '../domain/achievements.dart';
import '../domain/gamification_repository.dart';
import '../domain/trivia_engine.dart';
import 'games_providers.dart';
import 'widgets/silhouette_stage.dart';
import 'widgets/trivia_header.dart';
import 'widgets/trivia_no_data.dart';
import 'widgets/trivia_option.dart';
import 'widgets/trivia_result.dart';

class TriviaScreen extends ConsumerStatefulWidget {
  const TriviaScreen({super.key});

  @override
  ConsumerState<TriviaScreen> createState() => _TriviaScreenState();
}

enum _Phase { loading, unavailable, asking, revealed, finished }

class _TriviaScreenState extends ConsumerState<TriviaScreen> {
  final _engine = TriviaEngine();
  final _watch = Stopwatch();
  List<TriviaQuestion> _round = const [];
  _Phase _phase = _Phase.loading;
  int _index = 0;
  int _score = 0;
  int _correct = 0;
  int _streak = 0;
  int _bestStreak = 0;
  int _poolSize = 0;
  bool _retrying = false;
  PokemonSummary? _picked;
  Timer? _timer;
  int _remainingMs = TriviaEngine.secondsPerQuestion * 1000;

  final _newAchievements = <Achievement>[];

  DateTime? _savedAt;

  @override
  void initState() {
    super.initState();
    unawaited(_start());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _start() async {
    final pool = await ref.read(pokedexRepositoryProvider).playablePokemon();
    if (!mounted) return;
    _poolSize = pool.length;
    if (!_engine.canPlay(pool)) {
      setState(() => _phase = _Phase.unavailable);
      return;
    }
    setState(() {
      _round = _engine.buildRound(pool);
      _index = 0;
      _score = 0;
      _correct = 0;
      _streak = 0;
      _bestStreak = 0;
      _savedAt = null;
      _newAchievements.clear();
    });
    _watch
      ..reset()
      ..start();
    _ask();
  }

  /// Sin red la sincronización manual no hace nada.
  Future<void> _retry() async {
    setState(() => _retrying = true);
    await ref.read(syncServiceProvider).refresh(manual: true);
    if (!mounted) return;
    setState(() => _retrying = false);
    await _start();
  }

  void _ask() {
    _timer?.cancel();
    setState(() {
      _phase = _Phase.asking;
      _picked = null;
      _remainingMs = TriviaEngine.secondsPerQuestion * 1000;
    });
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() => _remainingMs -= 100);
      if (_remainingMs <= 0) _answer(null);
    });
  }

  Future<void> _unlock(Achievement a) async {
    final isNew = await unlockAndAnnounce(
      ref,
      ScaffoldMessenger.of(context),
      context.l10n,
      a,
    );
    if (isNew && mounted) setState(() => _newAchievements.add(a));
  }

  void _answer(PokemonSummary? option) {
    if (_phase != _Phase.asking) return;
    _timer?.cancel();
    final question = _round[_index];
    final correct = option?.id == question.answer.id;
    setState(() {
      _picked = option;
      _phase = _Phase.revealed;
      _score += _engine.pointsFor(
        correct: correct,
        remaining: Duration(milliseconds: _remainingMs.clamp(0, 1 << 30)),
        streak: _streak,
      );
      if (correct) {
        _correct++;
        _streak++;
        if (_streak > _bestStreak) _bestStreak = _streak;
      } else {
        _streak = 0;
      }
    });
    if (correct) unawaited(_unlock(Achievement.firstCorrect));
    if (_streak >= 5) unawaited(_unlock(Achievement.streak5));
    Future<void>.delayed(const Duration(milliseconds: 1400), _next);
  }

  Future<void> _next() async {
    if (!mounted) return;
    if (_index + 1 < _round.length) {
      setState(() => _index++);
      _ask();
      return;
    }
    _watch.stop();
    final playedAt = DateTime.now();
    setState(() {
      _phase = _Phase.finished;
      _savedAt = playedAt;
    });
    await ref
        .read(gamificationRepositoryProvider)
        .saveTriviaScore(
          TriviaScore(
            score: _score,
            correct: _correct,
            total: _round.length,
            bestStreak: _bestStreak,
            duration: _watch.elapsed,
            playedAt: playedAt,
          ),
        );
    if (!mounted) return;
    if (_correct == _round.length) await _unlock(Achievement.perfectRound);
    if (!mounted) return;
    if (_score >= 1000) await _unlock(Achievement.score1000);
  }

  @override
  Widget build(BuildContext context) {
    final title = context.l10n.gamesTriviaCardTitle;
    return Scaffold(
      appBar: switch (_phase) {
        _Phase.finished => null,
        _Phase.unavailable || _Phase.loading => PokedexHeader(title: title),
        _ => PokedexHeader(title: title, actions: const [LanguageToggle()]),
      },
      body: switch (_phase) {
        _Phase.finished => _finished(context),
        _Phase.unavailable => SafeArea(child: _unavailable(context)),
        _Phase.loading => const SafeArea(child: _LoadingSkeleton()),
        _ => SafeArea(child: _question(context)),
      },
    );
  }

  Widget _unavailable(BuildContext context) {
    return TriviaNoDataView(
      have: _poolSize,
      needed: TriviaEngine.minimumPool,
      onRetry: _retrying ? null : _retry,
      onOpenPokedex: () {
        ref.read(homeTabProvider.notifier).show(0);
        Navigator.pop(context);
      },
    );
  }

  Widget _question(BuildContext context) {
    final l10n = context.l10n;
    final q = _round[_index];
    final lang = context.languageCode;
    final revealed = _phase == _Phase.revealed;
    final name = q.answer.localizedName(lang);
    final seconds = (_remainingMs / 1000).ceil().clamp(0, 99);
    final message = !revealed
        ? l10n.gamesTriviaPrompt
        : _picked == null
        ? l10n.triviaTimeout(name)
        : _picked!.id == q.answer.id
        ? l10n.triviaCorrect(name)
        : l10n.triviaWrong(name);
    TriviaOptionState optionState(PokemonSummary option) => !revealed
        ? TriviaOptionState.idle
        : option.id == q.answer.id
        ? TriviaOptionState.correct
        : option.id == _picked?.id
        ? TriviaOptionState.wrong
        : TriviaOptionState.dimmed;
    final reduceMotion = shouldReduceMotion(context, ref);
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(Gaps.screen),
            children: [
              Row(
                children: [
                  TriviaStatPill(
                    icon: Icons.timer_outlined,
                    text: '0:${seconds.toString().padLeft(2, '0')}',
                    semanticLabel: l10n.gamesTriviaTime(seconds),
                  ),
                  const SizedBox(width: 8),
                  TriviaStatPill(
                    icon: Icons.bolt,
                    text: l10n.gamesTriviaPoints(_score),
                    iconColor: context.tokens.acTexto,
                  ),
                  const Spacer(),
                  Text(
                    l10n.triviaQuestion(_index + 1, _round.length),
                    style: context.text.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(Radii.pill),
                child: LinearProgressIndicator(
                  value:
                      _remainingMs / (TriviaEngine.secondsPerQuestion * 1000),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: Gaps.section),
              Center(
                child: SilhouetteStage(
                  pokemon: q.answer,
                  revealed: revealed,
                  reduceMotion: reduceMotion,
                ),
              ),
              const SizedBox(height: Gaps.section),
              GameDialogBox(text: message, showArrow: revealed),
              const SizedBox(height: Gaps.sibling),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                mainAxisExtent: 52,
                children: [
                  for (final option in q.options)
                    TriviaOption(
                      label: option.localizedName(lang),
                      state: optionState(option),
                      onTap: revealed ? null : () => _answer(option),
                    ),
                ],
              ),
              const SizedBox(height: Gaps.section),
              Text(
                l10n.gamesTriviaOfflineNote,
                textAlign: TextAlign.center,
                style: context.text.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _finished(BuildContext context) {
    final ranking = ref.watch(rankingProvider).value ?? const [];
    return TriviaResultView(
      lastPokemon: _round.last.answer,
      score: _score,
      correct: _correct,
      total: _round.length,
      newAchievements: List.of(_newAchievements),
      ranking: ranking,
      playedAt: _savedAt,
      onPlayAgain: _start,
      onExit: () => Navigator.pop(context),
    );
  }
}

/// Esqueleto con la forma de la pantalla final, no un indicador de carga.
class _LoadingSkeleton extends StatelessWidget {
  const _LoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: SilhouetteStage.diameter,
        height: SilhouetteStage.diameter,
        decoration: BoxDecoration(
          color: context.tokens.sf2,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
