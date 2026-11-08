import 'package:flutter/material.dart';

@immutable
class AppTokens extends ThemeExtension<AppTokens> {
  const AppTokens({
    required this.bg,
    required this.sf,
    required this.sf2,
    required this.ink,
    required this.body,
    required this.mute,
    required this.ac,
    required this.acTexto,
    required this.acTinte,
    required this.on,
    required this.danger,
    required this.ln,
    required this.ln2,
    required this.marco,
    required this.marco2,
    required this.glow,
    required this.glass,
    required this.shadow,
    required this.success,
    required this.warning,
    required this.info,
  });

  final Color bg;

  final Color sf;

  final Color sf2;
  final Color ink;
  final Color body;
  final Color mute;

  final Color ac;

  final Color acTexto;

  final Color acTinte;

  final Color on;

  final Color danger;
  final Color ln;
  final Color ln2;

  final Color marco;

  final Color marco2;
  final Color glow;
  final Color glass;

  final List<BoxShadow> shadow;
  final Color success;
  final Color warning;
  final Color info;

  static const dark = AppTokens(
    bg: Color(0xFF0F1116),
    sf: Color(0xFF181B22),
    sf2: Color(0xFF22252E),
    ink: Color(0xFFF2F3F7),
    body: Color(0xFFB9BCC6),
    mute: Color(0xFF8A8E99),
    ac: Color(0xFF3F69DD),
    acTexto: Color(0xFF6A8DF0),
    acTinte: Color(0xFF1E2A4F),
    on: Color(0xFFFFFFFF),
    danger: Color(0xFFF06A6B),
    ln: Color(0xFF2C303B),
    ln2: Color(0xFF3F4452),
    marco: Color(0xFF8C9CC4),
    marco2: Color(0xFF2E3852),
    glow: Color(0x8C3F69DD),
    glass: Color(0xD1181B22),
    shadow: [],
    success: Color(0xFF4FC17F),
    warning: Color(0xFFE8A24A),
    info: Color(0xFF6A8DF0),
  );

  static const light = AppTokens(
    bg: Color(0xFFFFFFFF),
    sf: Color(0xFFFFFFFF),
    sf2: Color(0xFFF4F4F6),
    ink: Color(0xFF111118),
    body: Color(0xFF4A4A55),
    mute: Color(0xFF6B6B76),
    ac: Color(0xFF163EA5),
    acTexto: Color(0xFF163EA5),
    acTinte: Color(0xFFE8EDF8),
    on: Color(0xFFFFFFFF),
    danger: Color(0xFFCE3031),
    ln: Color(0xFFE4E4E8),
    ln2: Color(0xFFC9C9D1),
    marco: Color(0xFF2E3B5C),
    marco2: Color(0xFFB7C6E6),
    glow: Color(0x59163EA5),
    glass: Color(0xD6FFFFFF),
    shadow: [
      BoxShadow(color: Color(0x1A111118), blurRadius: 24, offset: Offset(0, 8)),
    ],
    success: Color(0xFF1E8E4E),
    warning: Color(0xFFB25E00),
    info: Color(0xFF163EA5),
  );

  @override
  AppTokens copyWith() => this;

  @override
  AppTokens lerp(AppTokens? other, double t) {
    if (other == null) return this;
    Color c(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppTokens(
      bg: c(bg, other.bg),
      sf: c(sf, other.sf),
      sf2: c(sf2, other.sf2),
      ink: c(ink, other.ink),
      body: c(body, other.body),
      mute: c(mute, other.mute),
      ac: c(ac, other.ac),
      acTexto: c(acTexto, other.acTexto),
      acTinte: c(acTinte, other.acTinte),
      on: c(on, other.on),
      danger: c(danger, other.danger),
      ln: c(ln, other.ln),
      ln2: c(ln2, other.ln2),
      marco: c(marco, other.marco),
      marco2: c(marco2, other.marco2),
      glow: c(glow, other.glow),
      glass: c(glass, other.glass),
      shadow: t < 0.5 ? shadow : other.shadow,
      success: c(success, other.success),
      warning: c(warning, other.warning),
      info: c(info, other.info),
    );
  }
}

abstract final class Radii {
  static const surface = 16.0;

  static const block = 12.0;

  static const control = 10.0;
  static const chip = 12.0;

  static const sheet = 24.0;

  static const pill = 999.0;
}

abstract final class Gaps {
  static const screen = 16.0;
  static const sibling = 12.0;
  static const section = 24.0;
  static const inside = 16.0;
  static const row = 12.0;

  static const appBar = 56.0;

  static const navClearance = 120.0;
}

extension TokensX on BuildContext {
  AppTokens get tokens => Theme.of(this).extension<AppTokens>()!;
  TextTheme get text => Theme.of(this).textTheme;

  TextStyle get gameText => _tiny5(16, tokens.ink);

  TextStyle get gameTextSmall => _tiny5(13, tokens.ink);

  TextStyle get gameTextLarge => _tiny5(20, tokens.ink);

  TextStyle get monoText => TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 13,
    height: 1.4,
    color: tokens.body,
  );

  TextStyle japaneseText(double size, Color color) => TextStyle(
    fontFamily: 'NotoSansJP',
    fontWeight: FontWeight.w900,
    fontSize: size,
    height: 1,
    color: color,
  );
}

TextStyle _tiny5(double size, Color color) =>
    TextStyle(fontFamily: 'Tiny5', fontSize: size, height: 1.3, color: color);
