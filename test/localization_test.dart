import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/features/icons/presentation/icon_category_localization.dart';
import 'package:flutter_application_1/l10n/generated/app_localizations.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  test('provides translations for every supported language', () async {
    const expectedHomeLabels = {
      'fr': 'Accueil',
      'en': 'Home',
      'es': 'Inicio',
      'de': 'Startseite',
      'it': 'Home',
    };
    const expectedClothingLabels = {
      'fr': 'Vêtements',
      'en': 'Clothing',
      'es': 'Ropa',
      'de': 'Kleidung',
      'it': 'Abbigliamento',
    };

    expect(
      AppLocalizations.supportedLocales.map((locale) => locale.languageCode),
      containsAll(expectedHomeLabels.keys),
    );

    for (final entry in expectedHomeLabels.entries) {
      final localizations = await AppLocalizations.delegate.load(
        Locale(entry.key),
      );
      expect(localizations.home, entry.value);
      expect(localizations.openTaskCount(2), isNotEmpty);
      expect(
        localizeIconCategory(localizations, 'Vêtements'),
        expectedClothingLabels[entry.key],
      );
    }
  });

  testWidgets('lets the user select a language from the home screen', (
    tester,
  ) async {
    Locale? selectedLocale;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: TodoLandingPage(
          directory: Directory.systemTemp,
          onLocaleSelected: (locale) => selectedLocale = locale,
        ),
      ),
    );

    await tester.tap(find.byTooltip('Changer la langue'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Italiano'));
    await tester.pumpAndSettle();

    expect(selectedLocale, const Locale('it'));
  });
}
