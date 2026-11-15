import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../shared/l10n_x.dart';
import '../../../../shared/widgets/pokedex_header.dart';
import '../../../../shared/widgets/pokedex_key.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../widgets/collectible_card.dart';
import 'normal_shiny_switch.dart';

/// Compartir y guardar usan la hoja del sistema (`share_plus`).
/// La imagen sale del mismo `RepaintBoundary` que se ve: lo que ves es lo que se comparte.
class ShareCardScreen extends StatefulWidget {
  const ShareCardScreen({super.key, required this.detail});
  final PokemonDetail detail;

  static Future<void> open(BuildContext context, PokemonDetail detail) =>
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => ShareCardScreen(detail: detail),
        ),
      );

  @override
  State<ShareCardScreen> createState() => _ShareCardScreenState();
}

class _ShareCardScreenState extends State<ShareCardScreen> {
  final _boundary = GlobalKey();
  bool _shiny = false;
  bool _busy = false;

  /// Pinta la carta a 3x para que el PNG salga nítido.
  Future<void> _export({required bool withText}) async {
    if (_busy) return;
    final messenger = ScaffoldMessenger.of(context);
    final failed = context.l10n.detailShareFailed;
    final s = widget.detail.summary;
    setState(() => _busy = true);
    try {
      final render =
          _boundary.currentContext!.findRenderObject()!
              as RenderRepaintBoundary;
      final image = await render.toImage(pixelRatio: 3);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      final dir = await getTemporaryDirectory();
      final name = 'pokemon-${s.id}${_shiny ? '-shiny' : ''}.png';
      final file = File(p.join(dir.path, name));
      await file.writeAsBytes(bytes!.buffer.asUint8List());
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: withText ? s.nameEn : null,
        ),
      );
    } on Object {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(failed)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final d = widget.detail;
    return Scaffold(
      appBar: PokedexHeader(
        title: l10n.detailShareTitle,
        detail: d.summary.localizedName(context.languageCode),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Gaps.screen),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 361),
              child: Column(
                children: [
                  RepaintBoundary(
                    key: _boundary,
                    child: CollectibleCard(detail: d, shiny: _shiny),
                  ),
                  const SizedBox(height: Gaps.sibling),
                  if (d.shinyArtworkUrl != null)
                    NormalShinySwitch(
                      shiny: _shiny,
                      onChanged: (v) => setState(() => _shiny = v),
                    ),
                  const SizedBox(height: Gaps.sibling),
                  SizedBox(
                    width: double.infinity,
                    child: PokedexKey(
                      label: l10n.detailShareAsImage,
                      onPressed: _busy ? null : () => _export(withText: true),
                    ),
                  ),
                  const SizedBox(height: Gaps.sibling),
                  SizedBox(
                    width: double.infinity,
                    child: PokedexKey(
                      label: l10n.detailShareSave,
                      kind: PokedexKeyKind.outline,
                      onPressed: _busy ? null : () => _export(withText: false),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
