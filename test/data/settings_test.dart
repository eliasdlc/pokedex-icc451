import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/app/di/providers.dart';
import 'package:pokedex/core/database/app_database.dart';
import 'package:pokedex/features/pokedex/domain/entities/art_sources.dart';

void main() {
  late AppDatabase db;

  ProviderContainer containerOver(AppDatabase database) {
    final container = ProviderContainer(
      overrides: [databaseProvider.overrideWithValue(database)],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  Future<AppSettings> read(ProviderContainer c) =>
      c.read(settingsProvider.future);

  test('valores por defecto', () async {
    final settings = await read(containerOver(db));
    expect(settings.themeMode, ThemeMode.system);
    expect(settings.cryOnOpen, isTrue);
    expect(settings.artMode, isNull);
    expect(settings.reduceMotion, isFalse);
  });

  test('el tema acepta sistema, claro y oscuro', () async {
    final c = containerOver(db);
    final controller = c.read(settingsProvider.notifier);
    for (final mode in ThemeMode.values) {
      await controller.setThemeMode(mode);
      expect((await read(c)).themeMode, mode);
    }
  });

  test('el grito al abrir se apaga y se vuelve a prender', () async {
    final c = containerOver(db);
    final controller = c.read(settingsProvider.notifier);
    await controller.setCryOnOpen(false);
    expect((await read(c)).cryOnOpen, isFalse);
    await controller.setCryOnOpen(true);
    expect((await read(c)).cryOnOpen, isTrue);
  });

  test('reducir movimiento se guarda', () async {
    final c = containerOver(db);
    await c.read(settingsProvider.notifier).setReduceMotion(true);
    expect((await read(c)).reduceMotion, isTrue);
  });

  test(
    'el modo de arte fijo se guarda y null vuelve a "por generación"',
    () async {
      final c = containerOver(db);
      final controller = c.read(settingsProvider.notifier);
      for (final mode in ArtMode.values) {
        await controller.setArtMode(mode);
        expect((await read(c)).artMode, mode);
      }
      await controller.setArtMode(null);
      expect((await read(c)).artMode, isNull);
    },
  );

  test(
    'persisten al abrir de nuevo la app (otro contenedor, misma base)',
    () async {
      final first = containerOver(db);
      final controller = first.read(settingsProvider.notifier);
      await controller.setCryOnOpen(false);
      await controller.setArtMode(ArtMode.illustration);
      await controller.setReduceMotion(true);
      await controller.setThemeMode(ThemeMode.dark);

      final settings = await read(containerOver(db));
      expect(settings.cryOnOpen, isFalse);
      expect(settings.artMode, ArtMode.illustration);
      expect(settings.reduceMotion, isTrue);
      expect(settings.themeMode, ThemeMode.dark);
    },
  );

  test('las claves de siempre conservan su valor por defecto', () async {
    final c = containerOver(db);
    final settings = await read(c);
    expect(settings.locale, isNull);
    expect(settings.onboarded, isFalse);
    await c.read(settingsProvider.notifier).completeOnboarding();
    expect((await read(c)).onboarded, isTrue);
  });
}
