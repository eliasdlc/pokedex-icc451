import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/connectivity/connectivity_state.dart';
import '../../core/database/app_database.dart';
import '../../core/media/media_cache.dart';
import '../../core/network/api_failure_simulator.dart';
import '../../core/network/connectivity_monitor.dart';
import '../../features/games/data/drift_gamification_repository.dart';
import '../../features/games/domain/gamification_repository.dart';
import '../../features/pokedex/data/images/image_store.dart';
import '../../features/settings/data/drift_debug_console.dart';
import '../../features/settings/domain/debug_console.dart';
import '../../features/pokedex/data/local/pokedex_local_data_source.dart';
import '../../features/pokedex/data/remote/pokeapi_remote_data_source.dart';
import '../../features/pokedex/data/repositories/pokedex_repository_impl.dart';
import '../../features/pokedex/data/sync/sync_engine.dart';
import '../../features/pokedex/domain/entities/art_sources.dart';
import '../../features/pokedex/domain/repositories/pokedex_repository.dart';
import '../../features/pokedex/domain/usecases/toggle_favorite.dart';

// Raíz de composición: el ÚNICO lugar que conoce las clases concretas.
// Las pantallas piden contratos (PokedexRepository, SyncService...) y aquí se
// decide qué implementación reciben.

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final apiSimulatorProvider = Provider<ApiFailureSimulator>((ref) {
  final simulator = ApiFailureSimulator();
  ref.onDispose(simulator.dispose);
  return simulator;
});

final remoteDataSourceProvider = Provider<PokeApiRemoteDataSource>(
  (ref) => GraphQLPokeApiRemoteDataSource(
    simulator: ref.watch(apiSimulatorProvider),
  ),
);

final localDataSourceProvider = Provider<PokedexLocalDataSource>(
  (ref) => PokedexLocalDataSource(ref.watch(databaseProvider)),
);

final imageStoreProvider = Provider<ImageStore>((ref) => FileImageStore());

/// Arte y gritos: se descargan una vez con red y luego salen del dispositivo.
final mediaCacheProvider = Provider<MediaCache>((ref) => MediaCache());

/// Pide un archivo del caché: lo baja si hace falta. Las pantallas lo usan
/// con `ref.watch(mediaFileProvider((url: ..., kind: ...)))` el valor es null
/// mientras no hay archivo (sin red o sin ese recurso), nunca ocurre un error.
final mediaFileProvider =
    FutureProvider.family<File?, ({Uri url, MediaKind kind})>(
      (ref, request) =>
          ref.watch(mediaCacheProvider).obtener(request.url, request.kind),
    );

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  final remote = ref.watch(remoteDataSourceProvider);
  final monitor = ConnectivityMonitor(
    probe: remote.probe,
    simulator: ref.watch(apiSimulatorProvider),
  )..start();
  ref.onDispose(monitor.dispose);
  return monitor;
});

final syncServiceProvider = Provider<SyncService>((ref) {
  final engine = SyncEngine(
    remote: ref.watch(remoteDataSourceProvider),
    local: ref.watch(localDataSourceProvider),
    connectivity: ref.watch(connectivityServiceProvider),
    images: ref.watch(imageStoreProvider),
  );
  unawaited(engine.start());
  ref.onDispose(engine.dispose);
  return engine;
});

/// Idioma activo, para ordenar por nombre en el idioma que se lee.
class LanguageCode extends Notifier<String> {
  @override
  String build() => 'es';
  void set(String code) => state = code;
}

final languageCodeProvider = NotifierProvider<LanguageCode, String>(
  LanguageCode.new,
);

final pokedexRepositoryProvider = Provider<PokedexRepository>(
  (ref) => PokedexRepositoryImpl(
    ref.watch(localDataSourceProvider),
    languageCode: () => ref.read(languageCodeProvider),
  ),
);

final gamificationRepositoryProvider = Provider<GamificationRepository>(
  (ref) => DriftGamificationRepository(ref.watch(databaseProvider)),
);

final debugConsoleProvider = Provider<DebugConsole>(
  (ref) => DriftDebugConsole(ref.watch(databaseProvider)),
);

final toggleFavoriteProvider = Provider<ToggleFavorite>(
  (ref) => ToggleFavorite(ref.watch(pokedexRepositoryProvider)),
);

final availabilityProvider = StreamProvider<ServiceAvailability>(
  (ref) => ref.watch(connectivityServiceProvider).watch(),
);

final syncStateProvider = StreamProvider<SyncState>(
  (ref) => ref.watch(syncServiceProvider).watch(),
);

final indicatorProvider = Provider<IndicatorView>((ref) {
  final availability =
      ref.watch(availabilityProvider).value ?? ServiceAvailability.checking;
  final sync = ref.watch(syncStateProvider).value ?? const SyncState();
  return composeIndicator(availability, sync);
});

/// Ajustes del usuario persistidos en la base (tema, idioma, arte y sonido).
class AppSettings {
  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.locale,
    this.onboarded = true,
    this.cryOnOpen = true,
    this.artMode,
    this.reduceMotion = false,
  });
  final ThemeMode themeMode;
  final Locale? locale;
  final bool onboarded;
  final bool cryOnOpen;
  final ArtMode? artMode;
  final bool reduceMotion;
}

class SettingsController extends AsyncNotifier<AppSettings> {
  static const _theme = 'theme_mode';
  static const _locale = 'locale';
  static const _onboarded = 'onboarded';
  static const _cryOnOpen = 'cry_on_open';
  static const _artMode = 'art_mode';
  static const _reduceMotion = 'reduce_motion';

  static const _byGeneration = 'generation';

  PokedexLocalDataSource get _local => ref.read(localDataSourceProvider);

  @override
  Future<AppSettings> build() async {
    final theme = await _local.readSetting(_theme);
    final locale = await _local.readSetting(_locale);
    final onboarded = await _local.readSetting(_onboarded);
    final cryOnOpen = await _local.readSetting(_cryOnOpen);
    final artMode = await _local.readSetting(_artMode);
    final reduceMotion = await _local.readSetting(_reduceMotion);
    return AppSettings(
      themeMode: ThemeMode.values.asNameMap()[theme] ?? ThemeMode.system,
      locale: locale == null || locale == 'system' ? null : Locale(locale),
      onboarded: onboarded == 'true',
      cryOnOpen: cryOnOpen != 'false',
      artMode: ArtMode.values.asNameMap()[artMode],
      reduceMotion: reduceMotion == 'true',
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _local.writeSetting(_theme, mode.name);
    ref.invalidateSelf();
  }

  Future<void> setLocale(Locale? locale) async {
    await _local.writeSetting(_locale, locale?.languageCode ?? 'system');
    ref.invalidateSelf();
  }

  Future<void> completeOnboarding() async {
    await _local.writeSetting(_onboarded, 'true');
    ref.invalidateSelf();
  }

  Future<void> setCryOnOpen(bool value) async {
    await _local.writeSetting(_cryOnOpen, value.toString());
    ref.invalidateSelf();
  }

  Future<void> setArtMode(ArtMode? mode) async {
    await _local.writeSetting(_artMode, mode?.name ?? _byGeneration);
    ref.invalidateSelf();
  }

  Future<void> setReduceMotion(bool value) async {
    await _local.writeSetting(_reduceMotion, value.toString());
    ref.invalidateSelf();
  }
}

final settingsProvider = AsyncNotifierProvider<SettingsController, AppSettings>(
  SettingsController.new,
);
