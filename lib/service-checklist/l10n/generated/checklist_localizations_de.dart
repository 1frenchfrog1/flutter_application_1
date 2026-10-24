// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'checklist_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class ChecklistLocalizationsDe extends ChecklistLocalizations {
  ChecklistLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get todoTitle => 'Titel';

  @override
  String get description => 'Beschreibung';

  @override
  String get notes => 'Notizen';

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
  String get homeTooltip => 'Startseite';

  @override
  String get myChecklists => 'Meine Checklisten';

  @override
  String get unableToLoadChecklists => 'Checklisten konnten nicht geladen werden';

  @override
  String get evaluationTools => 'Auswertungswerkzeuge';

  @override
  String get reload => 'Neu laden';

  @override
  String get addChecklist => 'Checkliste hinzufügen';

  @override
  String get evaluationPanel => 'Auswertungsbereich';

  @override
  String get back => 'Zurück';

  @override
  String get addSampleChecklists => 'Beispiel-Checklisten hinzufügen';

  @override
  String get reloadFromStorage => 'Aus dem Speicher neu laden';

  @override
  String get deleteAllChecklists => 'Alle Checklisten löschen';

  @override
  String get editChecklist => 'Checkliste bearbeiten';

  @override
  String get otherActions => 'Weitere Aktionen';

  @override
  String get duplicate => 'Duplizieren';

  @override
  String get uncheckAll => 'Alle abwählen';

  @override
  String get checklistName => 'Name der Checkliste';

  @override
  String get checklistNameHint => 'Z. B. eine Reise vorbereiten';

  @override
  String get checklistNameRequired => 'Gib einen Namen für diese Checkliste ein.';

  @override
  String get checkpoints => 'Kontrollpunkte';

  @override
  String get manageCheckpoints => 'Kontrollpunkte verwalten';

  @override
  String checkpointCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Kontrollpunkte',
      one: '1 Kontrollpunkt',
      zero: 'Keine Kontrollpunkte',
    );
    return '$_temp0';
  }

  @override
  String get iconChoice => 'Symbol auswählen';

  @override
  String get icon => 'Symbol';

  @override
  String get chooseChecklistIcon => 'Wähle ein Symbol für die Checkliste';

  @override
  String get checklistDescriptionHint => 'Wofür ist diese Checkliste gedacht?';

  @override
  String get optionalNotes => 'Optionale Notizen';

  @override
  String get saveChecklist => 'Checkliste speichern';

  @override
  String get deleteChecklistConfirmation => 'Diese Checkliste löschen?';

  @override
  String get irreversibleAction => 'Diese Aktion ist endgültig.';

  @override
  String get editCheckpoint => 'Kontrollpunkt bearbeiten';

  @override
  String get editCheckpointTooltip => 'Kontrollpunkt bearbeiten';

  @override
  String get removeCheckpoint => 'Kontrollpunkt entfernen';

  @override
  String get addCheckpoint => 'Kontrollpunkt hinzufügen';

  @override
  String get deleteCheckpointConfirmation => 'Diesen Kontrollpunkt löschen?';

  @override
  String get cannotUndo => 'Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get checkpointTitleRequired => 'Gib einen Titel für diesen Kontrollpunkt ein.';

  @override
  String get checkpointIcon => 'Symbol des Kontrollpunkts';

  @override
  String get chooseIcon => 'Symbol auswählen';

  @override
  String get iconWillAppearInList => 'Es wird in der Liste angezeigt';

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
  String get usefulDetails => 'Nützliche Details';

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
  String get selectCheckpointImage => 'Bild für den Kontrollpunkt auswählen';

  @override
  String get nothingSelected => 'Kein Bild ausgewählt';

  @override
  String get chooseImage => 'Bild auswählen';

  @override
  String get select => 'Auswählen';

  @override
  String notesLabel(String notes) {
    return 'Notizen: $notes';
  }

  @override
  String get allCategories => 'Alle';

  @override
  String get categoryEssential => 'Grundlagen';

  @override
  String get categoryFamily => 'Familie';

  @override
  String get categoryLeisure => 'Freizeit';

  @override
  String get categoryWeather => 'Wetter';

  @override
  String get categoryHome => 'Haushalt';

  @override
  String get categoryFood => 'Lebensmittel';

  @override
  String get categoryTravelItems => 'Reiseutensilien';

  @override
  String get categoryHealth => 'Gesundheit';

  @override
  String get categoryTechnology => 'Technologie';

  @override
  String get categoryWork => 'Arbeit';

  @override
  String get categoryClothing => 'Kleidung';

  @override
  String get categoryTravel => 'Reisen';

  @override
  String get passportExample => 'Z. B. Reisepass';

  @override
  String get noIconsFound => 'Keine Symbole gefunden';

  @override
  String get searchIcon => 'Symbole suchen';

  @override
  String get clearSearch => 'Suche löschen';

  @override
  String get iconLoadingErrorTitle => 'Laden fehlgeschlagen';

  @override
  String get close => 'Schließen';

  @override
  String get checklistIconPickerTitle => 'Symbol auswählen';
}
