import 'package:flutter/widgets.dart';

import 'generated/checklist_localizations.dart';

// Exposed as `l10n` so checklist screens keep reading `context.l10n`; they
// import this extension instead of the app-level one.
extension ChecklistLocalizationContext on BuildContext {
  ChecklistLocalizations get l10n =>
      ChecklistLocalizations.of(this) ??
      lookupChecklistLocalizations(const Locale('fr'));
}
