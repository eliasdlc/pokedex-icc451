import 'package:flutter/material.dart';

import '../../../../app/theme/app_tokens.dart';

class EmptyStateView extends StatelessWidget {
  const EmptyStateView({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    this.primaryLabel,
    this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
  });

  final IconData icon;
  final String title;
  final String body;
  final String? primaryLabel;
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Gaps.screen),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(color: t.sf2, shape: BoxShape.circle),
              child: Icon(icon, size: 44, color: t.mute),
            ),
            const SizedBox(height: Gaps.section),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: context.text.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    body,
                    textAlign: TextAlign.center,
                    style: context.text.bodyLarge,
                  ),
                ],
              ),
            ),
            if (primaryLabel != null) ...[
              const SizedBox(height: Gaps.section),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onPrimary,
                  child: Text(primaryLabel!),
                ),
              ),
            ],
            if (secondaryLabel != null) ...[
              SizedBox(
                height: primaryLabel == null ? Gaps.section : Gaps.sibling,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: t.acTexto,
                    side: BorderSide(color: t.ac, width: 1.5),
                  ),
                  onPressed: onSecondary,
                  child: Text(secondaryLabel!),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
