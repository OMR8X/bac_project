import 'package:flutter/widgets.dart';
import 'package:neuro_app/l10n/generated/app_localizations.dart';

extension BuildContextL10n on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
