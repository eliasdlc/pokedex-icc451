import 'package:flutter/material.dart';

import '../../app/theme/app_tokens.dart';

class ChoicePill extends StatelessWidget {
  const ChoicePill({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        borderRadius: BorderRadius.circular(Radii.pill),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          constraints: const BoxConstraints(minHeight: 48),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? t.ac : t.sf2,
            borderRadius: BorderRadius.circular(Radii.pill),
          ),
          child: Text(
            label,
            style: context.text.labelLarge?.copyWith(
              color: selected ? t.on : t.ink,
            ),
          ),
        ),
      ),
    );
  }
}
