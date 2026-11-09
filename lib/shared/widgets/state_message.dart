import 'package:flutter/material.dart';

import '../../app/theme/app_tokens.dart';

class StateMessage extends StatelessWidget {
  const StateMessage({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    this.action,
    this.actionLabel,
    this.secondaryBody,
    this.illustration,
  });

  final IconData icon;
  final String title;
  final String body;
  final String? secondaryBody;
  final VoidCallback? action;
  final String? actionLabel;
  final Widget? illustration;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            illustration ??
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: t.sf2,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 40, color: t.mute),
                ),
            const SizedBox(height: Gaps.section),
            Text(
              title,
              style: context.text.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              body,
              style: context.text.bodyLarge,
              textAlign: TextAlign.center,
            ),
            if (secondaryBody != null) ...[
              const SizedBox(height: 8),
              Text(
                secondaryBody!,
                style: context.text.bodyMedium?.copyWith(color: t.mute),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: Gaps.section),
              FilledButton(onPressed: action, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}

class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    super.key,
    this.height,
    this.width,
    this.radius = Radii.surface,
  });
  final double? height;
  final double? width;
  final double radius;

  @override
  Widget build(BuildContext context) => Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: context.tokens.sf2,
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}
