// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'cook_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class CookLocalizationsIt extends CookLocalizations {
  CookLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get myCooklists => 'Le mie Cooklist';

  @override
  String get homeTooltip => 'Home';

  @override
  String get unableToLoadCooklists => 'Impossibile caricare le cooklist';

  @override
  String get evaluationTools => 'Strumenti di valutazione';

  @override
  String get reload => 'Ricarica';

  @override
  String get addCooklist => 'Aggiungi cooklist';

  @override
  String get evaluationPanel => 'Pannello di valutazione';

  @override
  String get back => 'Indietro';

  @override
  String get addSampleCooklists => 'Aggiungi ricette di esempio';

  @override
  String get reloadFromStorage => 'Ricarica dall\'archivio';

  @override
  String get deleteAllCooklists => 'Elimina tutte le cooklist';

  @override
  String get editCooklist => 'Modifica cooklist';

  @override
  String get otherActions => 'Altre azioni';

  @override
  String get duplicate => 'Duplica';

  @override
  String get uncheckAll => 'Deseleziona tutto';

  @override
  String get cooklistName => 'Nome della ricetta';

  @override
  String get cooklistNameHint => 'Es. Gratin di patate';

  @override
  String get cooklistNameRequired => 'Inserisci un nome per la ricetta.';

  @override
  String get steps => 'Passaggi';

  @override
  String get manageSteps => 'Gestisci i passaggi';

  @override
  String stepCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count passaggi',
      one: '1 passaggio',
      zero: 'Nessun passaggio',
    );
    return '$_temp0';
  }

  @override
  String get iconChoice => 'Scegli un\'icona';

  @override
  String get icon => 'Icona';

  @override
  String get chooseCooklistIcon => 'Scegli un\'icona per la ricetta';

  @override
  String get cooklistDescriptionHint => 'Di cosa parla questa ricetta?';

  @override
  String get optionalNotes => 'Note facoltative';

  @override
  String get saveCooklist => 'Salva cooklist';

  @override
  String get deleteCooklistConfirmation => 'Eliminare questa cooklist?';

  @override
  String get irreversibleAction => 'Questa azione è definitiva.';

  @override
  String get editStep => 'Modifica passaggio';

  @override
  String get editStepTooltip => 'Modifica passaggio';

  @override
  String get removeStep => 'Rimuovi passaggio';

  @override
  String get addStep => 'Aggiungi passaggio';

  @override
  String get deleteStepConfirmation => 'Eliminare questo passaggio?';

  @override
  String get cannotUndo => 'Questa azione non può essere annullata.';

  @override
  String get stepTitle => 'Titolo';

  @override
  String get stepTitleRequired => 'Inserisci un titolo per questo passaggio.';

  @override
  String get stepExample => 'Es. Soffriggere le cipolle';

  @override
  String get stepIcon => 'Icona del passaggio';

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
  String get description => 'Descrizione';

  @override
  String get usefulDetails => 'Dettagli utili';

  @override
  String get notes => 'Note';

  @override
  String notesLabel(String notes) {
    return 'Note: $notes';
  }

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
  String get selectStepImage => 'Seleziona un\'immagine per il passaggio';

  @override
  String get nothingSelected => 'Nessuna immagine selezionata';

  @override
  String get chooseImage => 'Scegli un\'immagine';

  @override
  String get select => 'Seleziona';

  @override
  String get tools => 'Strumenti';

  @override
  String get all => 'Tutti';

  @override
  String get leftToDo => 'Da fare';

  @override
  String get save => 'Salva';

  @override
  String get cancel => 'Annulla';

  @override
  String get delete => 'Elimina';

  @override
  String get retry => 'Riprova';

  @override
  String get close => 'Chiudi';

  @override
  String get iconLoadingErrorTitle => 'Impossibile caricare';

  @override
  String get cooklistIconPickerTitle => 'Scegli un\'icona';

  @override
  String get searchIcon => 'Cerca icone';

  @override
  String get clearSearch => 'Cancella ricerca';

  @override
  String get allCategories => 'Tutte';

  @override
  String get noIconsFound => 'Nessuna icona trovata';

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
}
