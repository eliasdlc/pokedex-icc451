import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/di/providers.dart';
import '../../app/theme/app_tokens.dart';
import '../../app/theme/shell_tokens.dart';
import '../../core/connectivity/connectivity_state.dart';
import '../l10n_x.dart';
import 'connection_sheet.dart';

/// `PokedexHeader.float` deja solo el lente, las luces y las teclas sobre el contenido.
/// El lente es el botón Atrás cuando la ruta puede volver; las luces son el estado de conexión.
class PokedexHeader extends ConsumerWidget implements PreferredSizeWidget {
  const PokedexHeader({
    super.key,
    required String this.title,
    this.detail,
    this.actions = const [],
    this.onBack,
  }) : showLens = true;

  const PokedexHeader.float({
    super.key,
    this.actions = const [],
    this.onBack,
    this.showLens = true,
  }) : title = null,
       detail = null;

  /// Línea 1 de la pantalla LCD.
  final String? title;

  /// El dato de la pantalla; la línea 2 lo une al estado de conexión con una coma.
  final String? detail;
  final List<Widget> actions;
  final VoidCallback? onBack;

  /// En false no hay lente ni luces: la primera página de la bienvenida.
  final bool showLens;

  /// Alto bajo la barra de estado.
  static const height = 61.0;

  @override
  Size get preferredSize => const Size.fromHeight(height);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final top = MediaQuery.paddingOf(context).top;
    final full = title != null;
    final back =
        onBack ??
        (Navigator.canPop(context) ? () => Navigator.maybePop(context) : null);
    // La cabecera es cromo de alto fijo: el texto del sistema no la agranda.
    final content = MediaQuery.withNoTextScaling(
      child: SizedBox(
        height: top + height,
        child: Stack(
          children: [
            if (full)
              Positioned.fill(
                child: CustomPaint(painter: _PlatePainter(context.shell, top)),
              ),
            Positioned(
              left: 12,
              right: 9,
              top: top + 4,
              height: 48,
              child: Row(
                children: [
                  if (showLens) ...[
                    _Lens(onBack: back),
                    _Lights(title: title, detail: detail, full: full),
                  ],
                  if (full) const SizedBox(width: 3) else const Spacer(),
                  ...actions,
                ],
              ),
            ),
          ],
        ),
      ),
    );
    if (!full) return content;
    // La placa es roja en los dos temas: los iconos de la barra de estado van blancos.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: content,
    );
  }
}

class _Lens extends StatelessWidget {
  const _Lens({required this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final shell = context.shell;
    final sprite = _Sprite(
      rows: onBack == null ? _lensRows : _backRows,
      cell: 3,
      colors: {
        'T': shell.trazo,
        'A': shell.tecla,
        'B': shell.lente,
        'S': shell.lenteSombra,
        'L': shell.lenteLuz,
        'W': Colors.white,
      },
    );
    // Mide 48 aunque se vea de 42: la tecla de Atrás necesita su área táctil.
    final slot = SizedBox(
      width: 48,
      height: 48,
      child: Align(alignment: Alignment.centerLeft, child: sprite),
    );
    if (onBack == null) return ExcludeSemantics(child: slot);
    final label = MaterialLocalizations.of(context).backButtonTooltip;
    return Tooltip(
      message: label,
      excludeFromSemantics: true,
      child: Semantics(
        button: true,
        label: label,
        excludeSemantics: true,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onBack,
          child: slot,
        ),
      ),
    );
  }
}

/// Luces y pantalla LCD: un solo toque abre el detalle de la conexión.
class _Lights extends ConsumerWidget {
  const _Lights({
    required this.title,
    required this.detail,
    required this.full,
  });

  final String? title;
  final String? detail;
  final bool full;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(indicatorProvider.select((v) => v.status));
    final label = connectionLabel(context.l10n, status);
    void open() => showConnectionSheet(context);
    final lights = Semantics(
      button: true,
      label: context.l10n.indicatorSemantics(label),
      excludeSemantics: true,
      onTap: open,
      child: _Leds(status: status),
    );
    if (!full) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: open,
        child: SizedBox(
          width: 51,
          height: 48,
          child: Align(alignment: Alignment.centerLeft, child: lights),
        ),
      );
    }
    // El estado va siempre primero, también en línea (IND-05: texto e icono);
    // el dato de la pantalla lo sigue tras una coma.
    final line2 = detail == null ? label : '$label, $detail';
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: open,
        child: Row(
          children: [
            lights,
            // El hueco que deja el escalón de la placa.
            const SizedBox(width: 42),
            Expanded(
              child: _Lcd(
                title: title!,
                line2: line2,
                icon: connectionIcon(status),
                detail: detail,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Leds extends StatelessWidget {
  const _Leds({required this.status});

  final IndicatorStatus status;

  @override
  Widget build(BuildContext context) {
    final shell = context.shell;
    Widget led(Color on, Color off, bool lit) => Container(
      width: 9,
      height: 9,
      color: lit ? on : off,
      alignment: Alignment.topLeft,
      child: lit
          ? Container(
              width: 3,
              height: 3,
              color: Colors.white.withValues(alpha: 0.7),
            )
          : null,
    );
    return Container(
      width: 15,
      height: 39,
      color: shell.trazo,
      padding: const EdgeInsets.all(3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          led(
            shell.ledRojo,
            shell.ledRojoOff,
            status == IndicatorStatus.serviceUnavailable,
          ),
          led(
            shell.ledAmarillo,
            shell.ledAmarilloOff,
            status == IndicatorStatus.syncing,
          ),
          led(
            shell.ledVerde,
            shell.ledVerdeOff,
            status == IndicatorStatus.online,
          ),
        ],
      ),
    );
  }
}

class _Lcd extends StatelessWidget {
  const _Lcd({
    required this.title,
    required this.line2,
    required this.icon,
    required this.detail,
  });

  final String title;
  final String line2;
  final IconData icon;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final shell = context.shell;
    TextStyle style(double size, double line, Color color) => TextStyle(
      fontFamily: 'Tiny5',
      fontSize: size,
      height: line / size,
      color: color,
    );
    return Semantics(
      header: true,
      label: detail == null ? title : '$title, $detail',
      excludeSemantics: true,
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: shell.lcd,
          border: Border.all(color: shell.trazo, width: 3),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: 3,
              child: ColoredBox(color: shell.lcdSombra),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: style(20, 18, shell.lcdTinta),
                  ),
                  Row(
                    children: [
                      Icon(icon, size: 11, color: shell.lcdTinta2),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          line2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: style(13, 12, shell.lcdTinta2),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum HeaderIcon { settings, cry, favorite }

/// Tecla cuadrada de la cabecera con un icono de píxeles; mide 42 y su área táctil 48.
class HeaderKey extends StatelessWidget {
  const HeaderKey({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.active = false,
  });

  final HeaderIcon icon;
  final String tooltip;
  final VoidCallback? onPressed;

  /// Solo el corazón: relleno rojo cuando es favorito.
  final bool active;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final shell = context.shell;
    final (rows, origin) = switch (icon) {
      HeaderIcon.settings => (_gearRows, const Offset(9, 6)),
      HeaderIcon.cry => (_speakerRows, const Offset(9, 8)),
      HeaderIcon.favorite => (_heartRows, const Offset(10, 8)),
    };
    return _KeyTarget(
      tooltip: tooltip,
      selected: icon == HeaderIcon.favorite ? active : null,
      onPressed: onPressed,
      child: _KeyCap(
        width: 42,
        child: Padding(
          padding: EdgeInsets.only(left: origin.dx - 3, top: origin.dy - 3),
          child: _Sprite(
            rows: rows,
            cell: 2,
            colors: {
              'T': shell.teclaTinta,
              'F': active ? t.danger : shell.tecla,
              'W': active ? Colors.white : shell.tecla,
            },
          ),
        ),
      ),
    );
  }
}

/// Tecla con texto, como Saltar en la bienvenida.
class HeaderTextKey extends StatelessWidget {
  const HeaderTextKey({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final shell = context.shell;
    return _KeyTarget(
      tooltip: null,
      label: label,
      onPressed: onPressed,
      child: _KeyCap(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(9, 0, 9, 6),
          child: Center(
            widthFactor: 1,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Tiny5',
                fontSize: 13,
                height: 15 / 13,
                color: shell.teclaTinta,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// El par ES / EN de la trivia: la tecla del idioma activo se ilumina en azul.
class HeaderLanguageKeys extends StatelessWidget {
  const HeaderLanguageKeys({
    super.key,
    required this.english,
    required this.onChanged,
  });

  final bool english;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final shell = context.shell;
    Widget key(String text, bool isEnglish) {
      final on = english == isEnglish;
      return Semantics(
        button: true,
        selected: on,
        // El nombre del idioma en su propio idioma, como lo busca quien no entiende el otro.
        label: isEnglish ? 'English' : 'Español',
        excludeSemantics: true,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onChanged(isEnglish),
          child: SizedBox(
            height: 48,
            child: Center(
              child: Container(
                width: 36,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: on ? shell.teclaActiva : shell.tecla,
                  border: Border.all(color: shell.trazo, width: 3),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'Tiny5',
                    fontSize: 13,
                    height: 1,
                    color: on ? Colors.white : shell.teclaTinta,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          key('ES', false),
          // Los bordes se montan para que el par se lea como una sola pieza.
          Transform.translate(
            offset: const Offset(-3, 0),
            child: key('EN', true),
          ),
        ],
      ),
    );
  }
}

class _KeyTarget extends StatelessWidget {
  const _KeyTarget({
    required this.tooltip,
    required this.onPressed,
    required this.child,
    this.label,
    this.selected,
  });

  final String? tooltip;
  final String? label;
  final bool? selected;
  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final target = Semantics(
      button: true,
      enabled: onPressed != null,
      selected: selected,
      label: label ?? tooltip,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          child: Center(widthFactor: 1, child: child),
        ),
      ),
    );
    if (tooltip == null) return target;
    return Tooltip(message: tooltip, excludeFromSemantics: true, child: target);
  }
}

class _KeyCap extends StatelessWidget {
  const _KeyCap({required this.child, this.width});

  final Widget child;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final shell = context.shell;
    return Container(
      width: width,
      height: 42,
      decoration: BoxDecoration(
        color: shell.tecla,
        border: Border.all(color: shell.trazo, width: 3),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 6,
            child: ColoredBox(color: shell.teclaSombra),
          ),
          Align(alignment: Alignment.topLeft, child: child),
        ],
      ),
    );
  }
}

/// Dibuja una cuadrícula de píxeles: cada letra es un color y el punto queda vacío.
class _Sprite extends StatelessWidget {
  const _Sprite({required this.rows, required this.cell, required this.colors});

  final List<String> rows;
  final double cell;
  final Map<String, Color> colors;

  @override
  Widget build(BuildContext context) => CustomPaint(
    size: Size(rows.first.length * cell, rows.length * cell),
    painter: _SpritePainter(rows, cell, colors),
  );
}

class _SpritePainter extends CustomPainter {
  _SpritePainter(this.rows, this.cell, this.colors);

  final List<String> rows;
  final double cell;
  final Map<String, Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (final (y, row) in rows.indexed) {
      for (var x = 0; x < row.length; x++) {
        final color = colors[row[x]];
        if (color == null) continue;
        paint.color = color;
        canvas.drawRect(Rect.fromLTWH(x * cell, y * cell, cell, cell), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_SpritePainter old) =>
      old.rows != rows || !mapEquals(old.colors, colors);
}

/// La placa roja con su escalón en diagonal; las medidas son las de Figma con la
/// barra de estado de 47, y `dy` las corre al alto real de cada teléfono.
class _PlatePainter extends CustomPainter {
  _PlatePainter(this.shell, double top) : dy = top - 47;

  final ShellTokens shell;
  final double dy;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final paint = Paint();
    void rect(Color color, double x, double y, double width, double height) {
      paint.color = color;
      canvas.drawRect(Rect.fromLTWH(x, y + dy, width, height), paint);
    }

    paint.color = shell.rojo;
    canvas.drawRect(Offset.zero & size, paint);
    for (var i = 0; i < 9; i++) {
      final x = 111.0 - 3 * i;
      final y = 51.0 + 6 * i;
      final h = i == 8 ? 3.0 : 6.0;
      rect(shell.rojoCuerpo, x, y, w - x, h);
      rect(shell.rojoSombra, x, y, 3, h);
    }
    rect(shell.rojoSombra, 111, 51, w - 111, 3);
    rect(shell.rojoLuz, 102, 45, w - 102, 3);
    rect(shell.rojoLuz, 102, 48, 3, 6);
    for (var i = 0; i < 8; i++) {
      rect(shell.rojoLuz, 99.0 - 3 * i, 54.0 + 6 * i, 3, 6);
    }
    rect(shell.trazo, 105, 48, w - 105, 3);
    for (var i = 0; i < 9; i++) {
      rect(shell.trazo, 105.0 - 3 * i, 51.0 + 6 * i, 6, i == 8 ? 3 : 6);
    }
    rect(shell.rojoSombra, 0, 105, w, 3);
  }

  @override
  bool shouldRepaint(_PlatePainter old) => old.shell != shell || old.dy != dy;
}

const _lensRows = [
  '....TTTTTT....',
  '...TTAAAATT...',
  '..TAALLLBAAT..',
  '.TAALLLBBBAAT.',
  'TTALWWBBBBBATT',
  'TALLWBBBBBBBAT',
  'TALLBBBBBBBSAT',
  'TALBBBBBBBSSAT',
  'TABBBBBBBSSSAT',
  'TTABBBBBSSSATT',
  '.TAABBBSSSAAT.',
  '..TAABSSSAAT..',
  '...TTAAAATT...',
  '....TTTTTT....',
];

/// El mismo lente con una flecha blanca: así se reconoce como Atrás.
const _backRows = [
  '....TTTTTT....',
  '...TTAAAATT...',
  '..TAALLLBAAT..',
  '.TAALLLBBBAAT.',
  'TTALLWBBBBBATT',
  'TALLWWBBBBBBAT',
  'TALWWWWWWWWSAT',
  'TALWWWWWWWWSAT',
  'TABBWWBBBSSSAT',
  'TTABBWBBSSSATT',
  '.TAABBBSSSAAT.',
  '..TAABSSSAAT..',
  '...TTAAAATT...',
  '....TTTTTT....',
];

const _gearRows = [
  '....TTTT....',
  '.TT.TTTT.TT.',
  '.TTTTTTTTTT.',
  '..TTT..TTT..',
  'TTTT....TTTT',
  'TTT......TTT',
  'TTT......TTT',
  'TTTT....TTTT',
  '..TTT..TTT..',
  '.TTTTTTTTTT.',
  '.TT.TTTT.TT.',
  '....TTTT....',
];

const _speakerRows = [
  '......T....',
  '.....TT..T.',
  '....TTT...T',
  'TTTTTTT.T.T',
  'TTTTTTT.T.T',
  'TTTTTTT.T.T',
  'TTTTTTT.T.T',
  '....TTT...T',
  '.....TT..T.',
  '......T....',
];

const _heartRows = [
  '..TT...TT..',
  '.TFFT.TFFT.',
  'TFWFFTFFFFT',
  'TFFFFFFFFFT',
  'TFFFFFFFFFT',
  '.TFFFFFFFT.',
  '..TFFFFFT..',
  '...TFFFT...',
  '....TFT....',
  '.....T.....',
];
