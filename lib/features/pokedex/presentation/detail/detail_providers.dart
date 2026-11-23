import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/providers.dart';
import '../../domain/entities/pokemon_detail.dart';
import 'cry_player.dart';

final detailProvider = StreamProvider.autoDispose.family<PokemonDetail?, int>((
  ref,
  id,
) {
  unawaited(ref.read(syncServiceProvider).ensureDetail(id));
  return ref.watch(pokedexRepositoryProvider).watchDetail(id);
});

final cryPlayerProvider = Provider.autoDispose<CryPlayer>((ref) {
  final player = AudioplayersCryPlayer();
  ref.onDispose(player.dispose);
  return player;
});

bool reducedMotion(BuildContext context, WidgetRef ref) =>
    MediaQuery.disableAnimationsOf(context) ||
    (ref.watch(settingsProvider).value?.reduceMotion ?? false);
