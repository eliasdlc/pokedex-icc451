import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/di/providers.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../shared/l10n_x.dart';
import '../../../shared/widgets/pokedex_header.dart';
import '../../pokedex/domain/entities/art_sources.dart';
import 'choice_sheet.dart';
import 'lab_screen.dart';
import 'settings_row.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsProvider).value ?? const AppSettings();
    final indicator = ref.watch(indicatorProvider);
    final controller = ref.read(settingsProvider.notifier);

    final themes = [
      ChoiceOption(value: ThemeMode.system, label: l10n.perfilThemeAuto),
      ChoiceOption(value: ThemeMode.light, label: l10n.themeLight),
      ChoiceOption(value: ThemeMode.dark, label: l10n.themeDark),
    ];
    final languages = [
      ChoiceOption<String>(value: 'system', label: l10n.languageSystem),
      const ChoiceOption<String>(value: 'es', label: 'Español'),
      const ChoiceOption<String>(value: 'en', label: 'English'),
    ];
    final arts = [
      ChoiceOption<ArtMode?>(
        value: null,
        label: l10n.perfilArtByGeneration,
        hint: l10n.perfilArtByGenerationHint,
      ),
      ChoiceOption<ArtMode?>(value: ArtMode.pixel, label: l10n.perfilArtPixel),
      ChoiceOption<ArtMode?>(
        value: ArtMode.illustration,
        label: l10n.perfilArtIllustration,
      ),
      ChoiceOption<ArtMode?>(value: ArtMode.model3d, label: l10n.perfilArt3d),
    ];
    final languageCode = settings.locale?.languageCode ?? 'system';
    String labelOf<T>(List<ChoiceOption<T>> options, T value) =>
        options.firstWhere((o) => o.value == value).label;

    return Scaffold(
      appBar: PokedexHeader(title: l10n.settingsTitle),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          Gaps.screen,
          0,
          Gaps.screen,
          Gaps.section,
        ),
        children: [
          SettingsSection(l10n.perfilSectionPokedex),
          SettingsSwitchRow(
            title: l10n.perfilReduceMotion,
            subtitle: l10n.perfilReduceMotionHint,
            value: settings.reduceMotion,
            onChanged: controller.setReduceMotion,
          ),
          SettingsSwitchRow(
            title: l10n.perfilCryOnOpen,
            subtitle: l10n.perfilCryOnOpenHint,
            value: settings.cryOnOpen,
            onChanged: controller.setCryOnOpen,
          ),
          SettingsSection(l10n.languageLabel),
          SettingsRow(
            title: l10n.perfilAppLanguage,
            subtitle: labelOf(languages, languageCode),
            trailing: const SettingsChevron(),
            onTap: () => showChoiceSheet<String>(
              context,
              title: l10n.perfilAppLanguage,
              options: languages,
              selected: languageCode,
              onSelected: (code) =>
                  controller.setLocale(code == 'system' ? null : Locale(code)),
            ),
          ),
          SettingsSection(l10n.perfilSectionAppearance),
          SettingsRow(
            title: l10n.themeLabel,
            subtitle: labelOf(themes, settings.themeMode),
            trailing: const SettingsChevron(),
            onTap: () => showChoiceSheet<ThemeMode>(
              context,
              title: l10n.themeLabel,
              options: themes,
              selected: settings.themeMode,
              onSelected: controller.setThemeMode,
            ),
          ),
          SettingsRow(
            title: l10n.perfilArtMode,
            subtitle: labelOf(arts, settings.artMode),
            trailing: const SettingsChevron(),
            onTap: () => showChoiceSheet<ArtMode?>(
              context,
              title: l10n.perfilArtMode,
              options: arts,
              selected: settings.artMode,
              onSelected: controller.setArtMode,
            ),
          ),
          SettingsSection(l10n.perfilSectionData),
          SettingsRow(
            title: l10n.perfilLastSync,
            subtitle:
                '${timeAgo(l10n, indicator.lastSyncedAt)}\n'
                '${l10n.localCatalog(indicator.localCount, indicator.remoteTotal?.toString() ?? '?')}',
            trailing: _SyncButton(
              label: l10n.perfilSyncNow,
              onPressed: () =>
                  ref.read(syncServiceProvider).refresh(manual: true),
            ),
          ),
          SettingsRow(
            title: l10n.labTitle,
            subtitle: l10n.labSubtitle,
            trailing: const SettingsChevron(),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => const LabScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

class _SyncButton extends StatelessWidget {
  const _SyncButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.sync, size: 16),
      label: Text(label),
      style: TextButton.styleFrom(
        backgroundColor: t.ac.withValues(alpha: 0.08),
        foregroundColor: t.acTexto,
        minimumSize: const Size(48, 48),
        padding: const EdgeInsets.only(left: 10, right: 12),
        shape: const StadiumBorder(),
        textStyle: context.text.labelLarge,
      ),
    );
  }
}
