// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Lista delle cose da fare';

  @override
  String get home => 'Home';

  @override
  String get openTodoList => 'Apri la mia lista di cose da fare';

  @override
  String get openChecklists => 'Apri le mie checklist';

  @override
  String get openIconCatalog => 'Apri il catalogo delle icone';

  @override
  String get changeLanguage => 'Cambia lingua';

  @override
  String get loadingLanguage => 'Caricamento della lingua…';

  @override
  String get languageLoadError => 'Impossibile caricare la lingua salvata.';

  @override
  String get languageSaveError =>
      'Impossibile salvare la lingua. La scelta non verrà mantenuta al riavvio dell\'app.';

  @override
  String get continueInFrench => 'Continua in francese';

  @override
  String get retry => 'Riprova';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get myTodoList => 'La mia lista di cose da fare';

  @override
  String get editTodo => 'Modifica attività';

  @override
  String get addTodo => 'Aggiungi attività';

  @override
  String get todoTitle => 'Titolo';

  @override
  String get description => 'Descrizione';

  @override
  String get todoDetails => 'Dettagli dell\'attività';

  @override
  String get deleteCompletedTodos => 'Elimina le attività completate';

  @override
  String get todoDeleted => 'Attività eliminata';

  @override
  String get undo => 'Annulla';

  @override
  String get tools => 'Strumenti';

  @override
  String get all => 'Tutte';

  @override
  String get leftToDo => 'Da fare';

  @override
  String openTaskCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count attività aperte',
      one: '1 attività aperta',
      zero: 'Nessuna attività aperta',
    );
    return '$_temp0';
  }

  @override
  String get todoPoints => 'Elementi da affrontare';

  @override
  String get emptyTodoDescription => 'Questa attività non contiene elementi.';

  @override
  String get emptyTodoTitle => 'Hai completato tutto';

  @override
  String get emptyTodoMessage => 'Aggiungi un\'attività per iniziare.';

  @override
  String get todoTitleRequired => 'Il titolo non può essere vuoto.';

  @override
  String get save => 'Salva';

  @override
  String get addTodoAction => 'Aggiungi attività';

  @override
  String get cancel => 'Annulla';

  @override
  String get delete => 'Elimina';

  @override
  String get modify => 'Modifica';

  @override
  String get deleteTodoConfirmation => 'Eliminare questa attività?';

  @override
  String deleteTodoConfirmationContent(String title) {
    return 'L\'attività «$title» verrà eliminata definitivamente.';
  }

  @override
  String get homeTooltip => 'Home';

  @override
  String get toolsTooltip => 'Strumenti';

  @override
  String get icon => 'Icona';

  @override
  String get iconCatalog => 'Catalogo delle icone';

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
  String get noIconsLoaded => 'Nessuna icona caricata.';

  @override
  String iconLoadError(String message) {
    return 'Impossibile caricare le icone: $message';
  }

  @override
  String get noIconsAvailable => 'Nessuna icona disponibile.';

  @override
  String get close => 'Chiudi';
}
