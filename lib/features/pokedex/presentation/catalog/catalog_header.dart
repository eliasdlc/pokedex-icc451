import 'package:flutter/material.dart';

import '../../../../app/theme/app_tokens.dart';
import '../../../../shared/l10n_x.dart';
import '../widgets/control_fill.dart';

class CatalogSearchField extends StatelessWidget {
  const CatalogSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
    this.enabled = true,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final l10n = context.l10n;
    OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(Radii.pill),
      borderSide: BorderSide(color: color, width: 1.5),
    );
    return SizedBox(
      height: 48,
      child: TextField(
        controller: controller,
        enabled: enabled,
        textInputAction: TextInputAction.search,
        textAlignVertical: TextAlignVertical.center,
        style: context.text.bodyMedium?.copyWith(color: t.ink),
        decoration: InputDecoration(
          hintText: l10n.searchHint,
          hintStyle: context.text.bodyMedium?.copyWith(color: t.mute),
          filled: true,
          fillColor: t.sf,
          isDense: true,
          contentPadding: EdgeInsets.zero,
          prefixIcon: Icon(Icons.search, size: 20, color: t.mute),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  tooltip: l10n.clearFilters,
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: onClear,
                ),
          border: border(t.ln),
          enabledBorder: border(t.ln),
          disabledBorder: border(t.ln),
          focusedBorder: border(t.ac),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class FilterPill extends StatelessWidget {
  const FilterPill({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final fill = controlFill(context);
    final on = onControlFill(context);
    final enabled = onTap != null;
    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      excludeSemantics: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(Radii.pill),
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Center(
            widthFactor: 1,
            child: Container(
              height: 40,
              padding: const EdgeInsets.only(left: 18, right: 14),
              decoration: BoxDecoration(
                color: fill.withValues(alpha: enabled ? 1 : 0.35),
                borderRadius: BorderRadius.circular(Radii.pill),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    maxLines: 1,
                    style: context.text.labelLarge?.copyWith(color: on),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: on),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
