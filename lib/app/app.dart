import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/gen/app_localizations.dart';
import '../shared/navigation.dart';
import 'di/providers.dart';
import 'home_shell.dart';
import 'onboarding_screen.dart';
import 'theme/app_theme.dart';

class PokedexApp extends ConsumerStatefulWidget {
  const PokedexApp({super.key});

  @override
  ConsumerState<PokedexApp> createState() => _PokedexAppState();
}

class _PokedexAppState extends ConsumerState<PokedexApp> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    ref.read(syncServiceProvider);
    _lifecycle = AppLifecycleListener(
      onResume: () {
        unawaited(ref.read(connectivityServiceProvider).recheck());
        unawaited(ref.read(syncServiceProvider).checkIntegrity());
      },
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final value = settings.value;
    return MaterialApp(
      navigatorKey: rootNavigatorKey,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: value?.themeMode ?? ThemeMode.system,
      locale: value?.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // El indicador de conexión vive en `PokedexHeader`; aquí solo se avisa el
      // idioma activo a los datos.
      builder: (context, child) {
        final code = Localizations.localeOf(context).languageCode;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (ref.read(languageCodeProvider) != code) {
            ref.read(languageCodeProvider.notifier).set(code);
          }
        });
        return child!;
      },
      home: switch (settings) {
        AsyncData(value: final s) when !s.onboarded => const OnboardingScreen(),
        AsyncData() => const HomeShell(),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
