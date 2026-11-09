import 'package:flutter/widgets.dart';

import '../l10n/gen/app_localizations.dart';

extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
  String get languageCode => Localizations.localeOf(this).languageCode;
}

String timeAgo(AppLocalizations l10n, DateTime? when, {DateTime? now}) {
  if (when == null) return l10n.neverSynced;
  final diff = (now ?? DateTime.now()).difference(when);
  if (diff.inMinutes < 1) return l10n.justNow;
  if (diff.inHours < 1) return l10n.minutesAgo(diff.inMinutes);
  if (diff.inDays < 1) return l10n.hoursAgo(diff.inHours);
  return l10n.daysAgo(diff.inDays);
}
