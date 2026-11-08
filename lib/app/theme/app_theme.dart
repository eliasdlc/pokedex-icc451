import 'package:flutter/material.dart';

import 'app_tokens.dart';

TextTheme _textTheme(AppTokens t) {
  TextStyle poppins(double size, FontWeight weight, Color color) => TextStyle(
    fontFamily: 'Poppins',
    fontSize: size,
    fontWeight: weight,
    height: 1.4,
    color: color,
  );
  return TextTheme(
    displayLarge: poppins(32, FontWeight.w600, t.ink),
    headlineMedium: poppins(24, FontWeight.w600, t.ink),
    titleLarge: poppins(20, FontWeight.w600, t.ink),
    titleMedium: poppins(18, FontWeight.w600, t.ink),
    titleSmall: poppins(16, FontWeight.w600, t.ink),
    bodyLarge: poppins(16, FontWeight.w400, t.body),
    bodyMedium: poppins(14, FontWeight.w400, t.body),
    bodySmall: poppins(12, FontWeight.w400, t.body),
    labelLarge: poppins(14, FontWeight.w500, t.ink),
    labelMedium: poppins(12, FontWeight.w500, t.mute),
    labelSmall: poppins(12, FontWeight.w400, t.mute),
  );
}

ThemeData buildTheme(Brightness brightness) {
  final t = brightness == Brightness.dark ? AppTokens.dark : AppTokens.light;
  final scheme = ColorScheme.fromSeed(seedColor: t.ac, brightness: brightness)
      .copyWith(
        primary: t.ac,
        onPrimary: t.on,
        surface: t.sf,
        onSurface: t.ink,
        surfaceContainerHighest: t.sf2,
        outline: t.ln2,
        outlineVariant: t.ln,
        error: t.danger,
      );
  final text = _textTheme(t);
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: t.bg,
    fontFamily: 'Poppins',
    textTheme: text,
    extensions: [t],
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      backgroundColor: t.bg,
      foregroundColor: t.ink,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: text.titleMedium,
    ),
    cardTheme: CardThemeData(
      color: t.sf,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Radii.surface),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: t.ac,
        foregroundColor: t.on,
        minimumSize: const Size(64, 52),
        shape: const StadiumBorder(),
        textStyle: text.labelLarge,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: t.ink,
        minimumSize: const Size(64, 52),
        side: BorderSide(color: t.ln2),
        shape: const StadiumBorder(),
        textStyle: text.labelLarge,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: t.acTexto,
        minimumSize: const Size(48, 48),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: t.sf2,
      hintStyle: text.bodyLarge?.copyWith(color: t.mute),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radii.control),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radii.control),
        borderSide: BorderSide(color: t.ac, width: 1.5),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: t.sf,
      modalBackgroundColor: t.sf,
      showDragHandle: true,
      dragHandleColor: t.ln2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Radii.sheet)),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: t.sf2,
      contentTextStyle: text.bodyMedium?.copyWith(color: t.ink),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Radii.block),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? t.on : t.mute,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? t.ac : t.sf2,
      ),
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
    ),
    dividerTheme: DividerThemeData(color: t.ln, thickness: 1, space: 1),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: t.ac,
      linearTrackColor: t.sf2,
    ),
  );
}
