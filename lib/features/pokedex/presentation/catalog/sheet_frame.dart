import 'package:flutter/material.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../shared/l10n_x.dart';

Future<void> showCatalogSheet(BuildContext context, WidgetBuilder builder) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      barrierColor: Colors.black.withValues(alpha: 0.4),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.9,
      ),
      builder: builder,
    );

class SheetFrame extends StatelessWidget {
  const SheetFrame({
    super.key,
    required this.title,
    required this.onClear,
    required this.body,
    required this.footer,
  });

  final String title;
  final VoidCallback onClear;
  final Widget body;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: Gaps.inside),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 48,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Gaps.screen),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Semantics(
                    header: true,
                    child: Text(title, style: context.text.titleMedium),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: onClear,
                      child: Text(
                        context.l10n.clearFilters,
                        style: context.text.labelLarge?.copyWith(
                          color: context.tokens.acTexto,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                Gaps.screen,
                Gaps.sibling,
                Gaps.screen,
                Gaps.sibling,
              ),
              child: body,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Gaps.screen,
              Gaps.sibling,
              Gaps.screen,
              0,
            ),
            child: footer,
          ),
        ],
      ),
    );
  }
}
