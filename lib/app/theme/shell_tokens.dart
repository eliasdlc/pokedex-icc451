import 'package:flutter/material.dart';

/// Colores de la carcasa (variables `carcasa/*` de Figma): la cabecera, el navbar y las teclas.
/// Van aparte de `AppTokens` porque solo los usa el cromo, nunca el contenido.
@immutable
class ShellTokens extends ThemeExtension<ShellTokens> {
  const ShellTokens({
    required this.rojo,
    required this.rojoCuerpo,
    required this.rojoLuz,
    required this.rojoSombra,
    required this.trazo,
    required this.contorno,
    required this.lcd,
    required this.lcdSombra,
    required this.lcdTinta,
    required this.lcdTinta2,
    required this.lente,
    required this.lenteLuz,
    required this.lenteSombra,
    required this.tecla,
    required this.teclaSombra,
    required this.teclaTinta,
    required this.teclaActiva,
    required this.ledVerde,
    required this.ledVerdeOff,
    required this.ledAmarillo,
    required this.ledAmarilloOff,
    required this.ledRojo,
    required this.ledRojoOff,
  });

  final Color rojo;
  final Color rojoCuerpo;
  final Color rojoLuz;
  final Color rojoSombra;
  final Color trazo;

  /// Borde de lo que va sobre el fondo; en oscuro se aclara para no perderse.
  final Color contorno;
  final Color lcd;
  final Color lcdSombra;
  final Color lcdTinta;
  final Color lcdTinta2;
  final Color lente;
  final Color lenteLuz;
  final Color lenteSombra;
  final Color tecla;
  final Color teclaSombra;
  final Color teclaTinta;
  final Color teclaActiva;
  final Color ledVerde;
  final Color ledVerdeOff;
  final Color ledAmarillo;
  final Color ledAmarilloOff;
  final Color ledRojo;
  final Color ledRojoOff;

  static const light = ShellTokens(
    rojo: Color(0xFFDC3038),
    rojoCuerpo: Color(0xFFC4262E),
    rojoLuz: Color(0xFFF2686E),
    rojoSombra: Color(0xFF9A1C24),
    trazo: Color(0xFF2B1B24),
    contorno: Color(0xFF2B1B24),
    lcd: Color(0xFFCFE6A8),
    lcdSombra: Color(0xFFA9C784),
    lcdTinta: Color(0xFF1F3B22),
    lcdTinta2: Color(0xFF3C5A36),
    lente: Color(0xFF2F9BEA),
    lenteLuz: Color(0xFFA8E0FF),
    lenteSombra: Color(0xFF1763B8),
    tecla: Color(0xFFF2F2F5),
    teclaSombra: Color(0xFFB4B7C4),
    teclaTinta: Color(0xFF2B1B24),
    teclaActiva: Color(0xFF2468E0),
    ledVerde: Color(0xFF46D26A),
    ledVerdeOff: Color(0xFF2C5A38),
    ledAmarillo: Color(0xFFFFD23F),
    ledAmarilloOff: Color(0xFF6E5A1F),
    ledRojo: Color(0xFFFF7A4D),
    ledRojoOff: Color(0xFF6B2222),
  );

  static const dark = ShellTokens(
    rojo: Color(0xFFB92A31),
    rojoCuerpo: Color(0xFF9E2229),
    rojoLuz: Color(0xFFD2474E),
    rojoSombra: Color(0xFF7A161C),
    trazo: Color(0xFF150C11),
    contorno: Color(0xFF5E667D),
    lcd: Color(0xFF1B2A1C),
    lcdSombra: Color(0xFF101A11),
    lcdTinta: Color(0xFFA6F27C),
    lcdTinta2: Color(0xFF7FBF62),
    lente: Color(0xFF2F9BEA),
    lenteLuz: Color(0xFFA8E0FF),
    lenteSombra: Color(0xFF1763B8),
    tecla: Color(0xFFD9DBE3),
    teclaSombra: Color(0xFF9A9EAD),
    teclaTinta: Color(0xFF1B1118),
    teclaActiva: Color(0xFF2F6FE6),
    ledVerde: Color(0xFF46D26A),
    ledVerdeOff: Color(0xFF24492E),
    ledAmarillo: Color(0xFFFFD23F),
    ledAmarilloOff: Color(0xFF5A4A1A),
    ledRojo: Color(0xFFFF7A4D),
    ledRojoOff: Color(0xFF541B1B),
  );

  @override
  ShellTokens copyWith() => this;

  // Claro y oscuro no se mezclan: el cambio de tema es inmediato.
  @override
  ShellTokens lerp(ShellTokens? other, double t) =>
      other == null || t < 0.5 ? this : other;
}

extension ShellTokensX on BuildContext {
  ShellTokens get shell => Theme.of(this).extension<ShellTokens>()!;
}
