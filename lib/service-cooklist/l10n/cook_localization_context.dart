import 'package:flutter/widgets.dart';

import 'generated/cook_localizations.dart';

extension CookLocalizationContext on BuildContext {
  CookLocalizations get cookL10n =>
      CookLocalizations.of(this) ??
      lookupCookLocalizations(const Locale('fr'));
}
