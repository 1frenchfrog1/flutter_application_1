// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'cook_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class CookLocalizationsDe extends CookLocalizations {
  CookLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get myCooklists => 'Meine Cooklists';

  @override
  String get homeTooltip => 'Startseite';

  @override
  String get unableToLoadCooklists => 'Cooklists konnten nicht geladen werden';

  @override
  String get evaluationTools => 'Auswertungswerkzeuge';

  @override
  String get reload => 'Neu laden';

  @override
  String get addCooklist => 'Cooklist hinzufügen';

  @override
  String get evaluationPanel => 'Auswertungsbereich';

  @override
  String get back => 'Zurück';

  @override
  String get addSampleCooklists => 'Beispielrezepte hinzufügen';

  @override
  String get reloadFromStorage => 'Aus dem Speicher neu laden';

  @override
  String get deleteAllCooklists => 'Alle Cooklists löschen';

  @override
  String get editCooklist => 'Cooklist bearbeiten';

  @override
  String get otherActions => 'Weitere Aktionen';

  @override
  String get duplicate => 'Duplizieren';

  @override
  String get uncheckAll => 'Alle abwählen';

  @override
  String get cooklistName => 'Name des Rezepts';

  @override
  String get cooklistNameHint => 'Z. B. Kartoffelgratin';

  @override
  String get cooklistNameRequired => 'Gib einen Namen für das Rezept ein.';

  @override
  String get steps => 'Schritte';

  @override
  String get manageSteps => 'Schritte verwalten';

  @override
  String stepCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Schritte',
      one: '1 Schritt',
      zero: 'Keine Schritte',
    );
    return '$_temp0';
  }

  @override
  String get iconChoice => 'Symbol auswählen';

  @override
  String get icon => 'Symbol';

  @override
  String get chooseCooklistIcon => 'Symbol für das Rezept auswählen';

  @override
  String get cooklistDescriptionHint => 'Worum geht es in diesem Rezept?';

  @override
  String get optionalNotes => 'Optionale Notizen';

  @override
  String get saveCooklist => 'Cooklist speichern';

  @override
  String get deleteCooklistConfirmation => 'Diese Cooklist löschen?';

  @override
  String get irreversibleAction => 'Diese Aktion ist endgültig.';

  @override
  String get editStep => 'Schritt bearbeiten';

  @override
  String get editStepTooltip => 'Schritt bearbeiten';

  @override
  String get removeStep => 'Schritt entfernen';

  @override
  String get addStep => 'Schritt hinzufügen';

  @override
  String get deleteStepConfirmation => 'Diesen Schritt löschen?';

  @override
  String get cannotUndo => 'Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get stepTitle => 'Titel';

  @override
  String get stepTitleRequired => 'Gib einen Titel für diesen Schritt ein.';

  @override
  String get stepExample => 'Z. B. Zwiebeln anbraten';

  @override
  String get stepIcon => 'Symbol des Schritts';

  @override
  String get chooseIcon => 'Symbol auswählen';

  @override
  String get iconWillAppearInList => 'Es erscheint in der Liste';

  @override
  String get photo => 'Foto';

  @override
  String get noPhotoAdded => 'Kein Foto hinzugefügt';

  @override
  String get addPhoto => 'Foto hinzufügen';

  @override
  String get replace => 'Ersetzen';

  @override
  String get removePhoto => 'Foto entfernen';

  @override
  String get description => 'Beschreibung';

  @override
  String get usefulDetails => 'Nützliche Details';

  @override
  String get notes => 'Notizen';

  @override
  String notesLabel(String notes) {
    return 'Notizen: $notes';
  }

  @override
  String get saving => 'Wird gespeichert…';

  @override
  String get photoSaveError => 'Das Foto konnte nicht gespeichert werden.';

  @override
  String get selectImageSource => 'Bildquelle auswählen';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galerie';

  @override
  String get selectStepImage => 'Bild für den Schritt auswählen';

  @override
  String get nothingSelected => 'Kein Bild ausgewählt';

  @override
  String get chooseImage => 'Bild auswählen';

  @override
  String get select => 'Auswählen';

  @override
  String get tools => 'Werkzeuge';

  @override
  String get all => 'Alle';

  @override
  String get leftToDo => 'Offen';

  @override
  String get save => 'Speichern';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get close => 'Schließen';

  @override
  String get iconLoadingErrorTitle => 'Laden nicht möglich';

  @override
  String get cooklistIconPickerTitle => 'Symbol auswählen';

  @override
  String get searchIcon => 'Symbole suchen';

  @override
  String get clearSearch => 'Suche löschen';

  @override
  String get allCategories => 'Alle';

  @override
  String get noIconsFound => 'Keine Symbole gefunden';

  @override
  String get categoryEssential => 'Grundlagen';

  @override
  String get categoryFamily => 'Familie';

  @override
  String get categoryLeisure => 'Freizeit';

  @override
  String get categoryWeather => 'Wetter';

  @override
  String get categoryHome => 'Zuhause';

  @override
  String get categoryFood => 'Essen';

  @override
  String get categoryTravelItems => 'Reiseartikel';

  @override
  String get categoryHealth => 'Gesundheit';

  @override
  String get categoryTechnology => 'Technik';

  @override
  String get categoryWork => 'Arbeit';

  @override
  String get categoryClothing => 'Kleidung';

  @override
  String get categoryTravel => 'Reisen';
}
