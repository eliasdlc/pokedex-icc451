import 'package:flutter/material.dart';

import '../../app/theme/app_tokens.dart';
import 'connectivity_indicator.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key, required this.title, this.actions = const []});

  final String title;
  final List<Widget> actions;

  @override
  Size get preferredSize => const Size.fromHeight(Gaps.appBar + 1);

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return ColoredBox(
      color: t.bg,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SizedBox(
              height: Gaps.appBar,
              child: Padding(
                padding: const EdgeInsets.only(left: Gaps.screen, right: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Semantics(
                        header: true,
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.text.titleMedium,
                        ),
                      ),
                    ),
                    for (final action in actions) ...[
                      action,
                      const SizedBox(width: 8),
                    ],
                    const ConnectivityIndicator(),
                  ],
                ),
              ),
            ),
            Divider(height: 1, thickness: 1, color: t.ln),
          ],
        ),
      ),
    );
  }
}
