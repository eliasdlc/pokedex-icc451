import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokedex/presentation/detail/cry_player.dart';
import 'package:pokedex/features/pokedex/presentation/detail/detail_providers.dart';

class FakeCryPlayer implements CryPlayer {
  final played = <File>[];

  @override
  Future<void> play(File file) async => played.add(file);

  @override
  Future<void> dispose() async {}
}

void main() {
  test('la ficha pide el grito por la interfaz, no por el plugin', () async {
    final fake = FakeCryPlayer();
    final container = ProviderContainer(
      overrides: [cryPlayerProvider.overrideWithValue(fake)],
    );
    addTearDown(container.dispose);

    await container.read(cryPlayerProvider).play(File('25.ogg'));

    expect(fake.played.single.path, '25.ogg');
  });
}
