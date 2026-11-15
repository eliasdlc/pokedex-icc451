import 'package:flutter/material.dart';

import '../../../app/theme/app_tokens.dart';

/// [value] es null cuando "sin valor" es una opción válida (idioma del sistema).
class ChoiceOption<T> {
  const ChoiceOption({required this.value, required this.label, this.hint});

  final T value;
  final String label;
  final String? hint;
}

/// Avisa con [onSelected] y se cierra sola: así cerrar sin elegir no se confunde con elegir null.
Future<void> showChoiceSheet<T>(
  BuildContext context, {
  required String title,
  required List<ChoiceOption<T>> options,
  required T selected,
  required ValueChanged<T> onSelected,
}) => showModalBottomSheet<void>(
  context: context,
  builder: (sheetContext) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(
        Gaps.screen,
        0,
        Gaps.screen,
        Gaps.screen,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: sheetContext.text.titleMedium),
          const SizedBox(height: 8),
          for (final option in options)
            _ChoiceRow<T>(
              option: option,
              selected: option.value == selected,
              onTap: () {
                onSelected(option.value);
                Navigator.pop(sheetContext);
              },
            ),
        ],
      ),
    ),
  ),
);

class _ChoiceRow<T> extends StatelessWidget {
  const _ChoiceRow({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final ChoiceOption<T> option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.label,
                        style: context.text.labelLarge?.copyWith(
                          color: selected ? t.acTexto : t.ink,
                        ),
                      ),
                      if (option.hint != null)
                        Text(option.hint!, style: context.text.labelSmall),
                    ],
                  ),
                ),
                if (selected) Icon(Icons.check, size: 20, color: t.acTexto),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
