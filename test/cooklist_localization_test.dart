import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/service-cooklist/l10n/generated/cook_localizations.dart';

void main() {
  test('cook localizations exist for all app languages', () {
    expect(
      CookLocalizations.supportedLocales.map((l) => l.languageCode).toSet(),
      {'fr', 'en', 'es', 'de', 'it'},
    );
  });

  test('home button label is translated', () async {
    final fr = await CookLocalizations.delegate.load(const Locale('fr'));
    final it = await CookLocalizations.delegate.load(const Locale('it'));
    expect(fr.myCooklists, 'Mes Cooklists');
    expect(it.myCooklists, isNotEmpty);
  });
}
