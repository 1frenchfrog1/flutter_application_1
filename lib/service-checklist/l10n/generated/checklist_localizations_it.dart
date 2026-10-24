// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'checklist_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class ChecklistLocalizationsIt extends ChecklistLocalizations {
  ChecklistLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get retry => 'Riprova';

  @override
  String get todoTitle => 'Titolo';

  @override
  String get description => 'Descrizione';

  @override
  String get notes => 'Note';

  @override
  String get tools => 'Strumenti';

  @override
  String get all => 'Tutte';

  @override
  String get leftToDo => 'Da fare';

  @override
  String get save => 'Salva';

  @override
  String get cancel => 'Annulla';

  @override
  String get delete => 'Elimina';

  @override
  String get homeTooltip => 'Home';

  @override
  String get myChecklists => 'Le mie checklist';

  @override
  String get unableToLoadChecklists => 'Impossibile caricare le checklist';

  @override
  String get evaluationTools => 'Strumenti di valutazione';

  @override
  String get reload => 'Ricarica';

  @override
  String get addChecklist => 'Aggiungi checklist';

  @override
  String get evaluationPanel => 'Pannello di valutazione';

  @override
  String get back => 'Indietro';

  @override
  String get addSampleChecklists => 'Aggiungi checklist di esempio';

  @override
  String get reloadFromStorage => 'Ricarica dall\'archivio';

  @override
  String get deleteAllChecklists => 'Elimina tutte le checklist';

  @override
  String get editChecklist => 'Modifica checklist';

  @override
  String get otherActions => 'Altre azioni';

  @override
  String get duplicate => 'Duplica';

  @override
  String get uncheckAll => 'Deseleziona tutto';

  @override
  String get checklistName => 'Nome della checklist';

  @override
  String get checklistNameHint => 'Es. Preparare un viaggio';

  @override
  String get checklistNameRequired => 'Inserisci un nome per questa checklist.';

  @override
  String get checkpoints => 'Punti di controllo';

  @override
  String get manageCheckpoints => 'Gestisci i punti di controllo';

  @override
  String checkpointCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count punti di controllo',
      one: '1 punto di controllo',
      zero: 'Nessun punto di controllo',
    );
    return '$_temp0';
  }

  @override
  String get iconChoice => 'Scegli un\'icona';

  @override
  String get icon => 'Icona';

  @override
  String get chooseChecklistIcon => 'Scegli un\'icona per la checklist';

  @override
  String get checklistDescriptionHint => 'A cosa serve questa checklist?';

  @override
  String get optionalNotes => 'Note facoltative';

  @override
  String get saveChecklist => 'Salva checklist';

  @override
  String get deleteChecklistConfirmation => 'Eliminare questa checklist?';

  @override
  String get irreversibleAction => 'Questa azione è definitiva.';

  @override
  String get editCheckpoint => 'Modifica punto di controllo';

  @override
  String get editCheckpointTooltip => 'Modifica punto di controllo';

  @override
  String get removeCheckpoint => 'Rimuovi punto di controllo';

  @override
  String get addCheckpoint => 'Aggiungi punto di controllo';

  @override
  String get deleteCheckpointConfirmation => 'Eliminare questo punto di controllo?';

  @override
  String get cannotUndo => 'Questa azione non può essere annullata.';

  @override
  String get checkpointTitleRequired => 'Inserisci un titolo per questo punto di controllo.';

  @override
  String get checkpointIcon => 'Icona del punto di controllo';

  @override
  String get chooseIcon => 'Scegli un\'icona';

  @override
  String get iconWillAppearInList => 'Apparirà nell\'elenco';

  @override
  String get photo => 'Foto';

  @override
  String get noPhotoAdded => 'Nessuna foto aggiunta';

  @override
  String get addPhoto => 'Aggiungi foto';

  @override
  String get replace => 'Sostituisci';

  @override
  String get removePhoto => 'Rimuovi foto';

  @override
  String get usefulDetails => 'Dettagli utili';

  @override
  String get saving => 'Salvataggio…';

  @override
  String get photoSaveError => 'Impossibile salvare la foto.';

  @override
  String get selectImageSource => 'Seleziona la sorgente dell\'immagine';

  @override
  String get camera => 'Fotocamera';

  @override
  String get gallery => 'Galleria';

  @override
  String get selectCheckpointImage => 'Seleziona un\'immagine per il punto di controllo';

  @override
  String get nothingSelected => 'Nessuna immagine selezionata';

  @override
  String get chooseImage => 'Scegli un\'immagine';

  @override
  String get select => 'Seleziona';

  @override
  String notesLabel(String notes) {
    return 'Note: $notes';
  }

  @override
  String get allCategories => 'Tutte';

  @override
  String get categoryEssential => 'Elementi essenziali';

  @override
  String get categoryFamily => 'Famiglia';

  @override
  String get categoryLeisure => 'Tempo libero';

  @override
  String get categoryWeather => 'Meteo';

  @override
  String get categoryHome => 'Casa';

  @override
  String get categoryFood => 'Cibo';

  @override
  String get categoryTravelItems => 'Accessori da viaggio';

  @override
  String get categoryHealth => 'Salute';

  @override
  String get categoryTechnology => 'Tecnologia';

  @override
  String get categoryWork => 'Lavoro';

  @override
  String get categoryClothing => 'Abbigliamento';

  @override
  String get categoryTravel => 'Viaggio';

  @override
  String get passportExample => 'Es. Passaporto';

  @override
  String get noIconsFound => 'Nessuna icona trovata';

  @override
  String get searchIcon => 'Cerca icone';

  @override
  String get clearSearch => 'Cancella ricerca';

  @override
  String get iconLoadingErrorTitle => 'Impossibile caricare';

  @override
  String get close => 'Chiudi';

  @override
  String get checklistIconPickerTitle => 'Scegli un\'icona';
}
