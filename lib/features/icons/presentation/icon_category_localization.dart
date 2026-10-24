import '../../../l10n/generated/app_localizations.dart';

String localizeIconCategory(
  AppLocalizations localizations,
  String category,
) {
  return switch (category) {
    'Essentiel' => localizations.categoryEssential,
    'Famille' => localizations.categoryFamily,
    'Loisirs' => localizations.categoryLeisure,
    'Météo' => localizations.categoryWeather,
    'Maison' => localizations.categoryHome,
    'Nourriture' => localizations.categoryFood,
    'Objets de voyage' => localizations.categoryTravelItems,
    'Santé' => localizations.categoryHealth,
    'Technologie' => localizations.categoryTechnology,
    'Travail' => localizations.categoryWork,
    'Vêtements' => localizations.categoryClothing,
    'Voyage' => localizations.categoryTravel,
    _ => category,
  };
}
