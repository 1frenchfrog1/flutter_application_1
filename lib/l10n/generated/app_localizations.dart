import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In fr, this message translates to:
  /// **'Todo List'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get home;

  /// No description provided for @openTodoList.
  ///
  /// In fr, this message translates to:
  /// **'Mes todo-list'**
  String get openTodoList;

  /// No description provided for @openChecklists.
  ///
  /// In fr, this message translates to:
  /// **'Mes checklists'**
  String get openChecklists;

  /// No description provided for @openIconCatalog.
  ///
  /// In fr, this message translates to:
  /// **'Ouvrir le catalogue d’icônes'**
  String get openIconCatalog;

  /// No description provided for @changeLanguage.
  ///
  /// In fr, this message translates to:
  /// **'Changer la langue'**
  String get changeLanguage;

  /// No description provided for @loadingLanguage.
  ///
  /// In fr, this message translates to:
  /// **'Chargement de la langue…'**
  String get loadingLanguage;

  /// No description provided for @languageLoadError.
  ///
  /// In fr, this message translates to:
  /// **'Impossible de charger la langue enregistrée.'**
  String get languageLoadError;

  /// No description provided for @languageSaveError.
  ///
  /// In fr, this message translates to:
  /// **'La langue n’a pas pu être enregistrée. Votre choix ne sera pas conservé au prochain démarrage.'**
  String get languageSaveError;

  /// No description provided for @continueInFrench.
  ///
  /// In fr, this message translates to:
  /// **'Continuer en français'**
  String get continueInFrench;

  /// No description provided for @retry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get retry;

  /// No description provided for @languageFrench.
  ///
  /// In fr, this message translates to:
  /// **'Français'**
  String get languageFrench;

  /// No description provided for @languageEnglish.
  ///
  /// In fr, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageSpanish.
  ///
  /// In fr, this message translates to:
  /// **'Español'**
  String get languageSpanish;

  /// No description provided for @languageGerman.
  ///
  /// In fr, this message translates to:
  /// **'Deutsch'**
  String get languageGerman;

  /// No description provided for @languageItalian.
  ///
  /// In fr, this message translates to:
  /// **'Italiano'**
  String get languageItalian;

  /// No description provided for @myTodoList.
  ///
  /// In fr, this message translates to:
  /// **'Ma todo-list'**
  String get myTodoList;

  /// No description provided for @editTodo.
  ///
  /// In fr, this message translates to:
  /// **'Modifier la tâche'**
  String get editTodo;

  /// No description provided for @addTodo.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une tâche'**
  String get addTodo;

  /// No description provided for @todoTitle.
  ///
  /// In fr, this message translates to:
  /// **'Titre'**
  String get todoTitle;

  /// No description provided for @description.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @todoDetails.
  ///
  /// In fr, this message translates to:
  /// **'Détails de la tâche'**
  String get todoDetails;

  /// No description provided for @deleteCompletedTodos.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer les tâches terminées'**
  String get deleteCompletedTodos;

  /// No description provided for @todoDeleted.
  ///
  /// In fr, this message translates to:
  /// **'Tâche supprimée'**
  String get todoDeleted;

  /// No description provided for @undo.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get undo;

  /// No description provided for @tools.
  ///
  /// In fr, this message translates to:
  /// **'Outils'**
  String get tools;

  /// No description provided for @all.
  ///
  /// In fr, this message translates to:
  /// **'Toutes'**
  String get all;

  /// No description provided for @leftToDo.
  ///
  /// In fr, this message translates to:
  /// **'À faire'**
  String get leftToDo;

  /// No description provided for @openTaskCount.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =0{Aucune tâche ouverte} one{1 tâche ouverte} other{{count} tâches ouvertes}}'**
  String openTaskCount(int count);

  /// No description provided for @todoPoints.
  ///
  /// In fr, this message translates to:
  /// **'Points à traiter'**
  String get todoPoints;

  /// No description provided for @emptyTodoDescription.
  ///
  /// In fr, this message translates to:
  /// **'Aucun contenu pour cette tâche.'**
  String get emptyTodoDescription;

  /// No description provided for @emptyTodoTitle.
  ///
  /// In fr, this message translates to:
  /// **'Tout est en ordre'**
  String get emptyTodoTitle;

  /// No description provided for @emptyTodoMessage.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez une tâche pour commencer.'**
  String get emptyTodoMessage;

  /// No description provided for @todoTitleRequired.
  ///
  /// In fr, this message translates to:
  /// **'Le titre ne peut pas être vide.'**
  String get todoTitleRequired;

  /// No description provided for @save.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer'**
  String get save;

  /// No description provided for @addTodoAction.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter la tâche'**
  String get addTodoAction;

  /// No description provided for @cancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get delete;

  /// No description provided for @modify.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get modify;

  /// No description provided for @deleteTodoConfirmation.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer cette tâche ?'**
  String get deleteTodoConfirmation;

  /// No description provided for @deleteTodoConfirmationContent.
  ///
  /// In fr, this message translates to:
  /// **'La tâche « {title} » sera supprimée définitivement.'**
  String deleteTodoConfirmationContent(String title);

  /// No description provided for @homeTooltip.
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get homeTooltip;

  /// No description provided for @toolsTooltip.
  ///
  /// In fr, this message translates to:
  /// **'Outils'**
  String get toolsTooltip;

  /// No description provided for @icon.
  ///
  /// In fr, this message translates to:
  /// **'Icône'**
  String get icon;

  /// No description provided for @iconCatalog.
  ///
  /// In fr, this message translates to:
  /// **'Catalogue d’icônes'**
  String get iconCatalog;

  /// No description provided for @categoryEssential.
  ///
  /// In fr, this message translates to:
  /// **'Essentiel'**
  String get categoryEssential;

  /// No description provided for @categoryFamily.
  ///
  /// In fr, this message translates to:
  /// **'Famille'**
  String get categoryFamily;

  /// No description provided for @categoryLeisure.
  ///
  /// In fr, this message translates to:
  /// **'Loisirs'**
  String get categoryLeisure;

  /// No description provided for @categoryWeather.
  ///
  /// In fr, this message translates to:
  /// **'Météo'**
  String get categoryWeather;

  /// No description provided for @categoryHome.
  ///
  /// In fr, this message translates to:
  /// **'Maison'**
  String get categoryHome;

  /// No description provided for @categoryFood.
  ///
  /// In fr, this message translates to:
  /// **'Nourriture'**
  String get categoryFood;

  /// No description provided for @categoryTravelItems.
  ///
  /// In fr, this message translates to:
  /// **'Objets de voyage'**
  String get categoryTravelItems;

  /// No description provided for @categoryHealth.
  ///
  /// In fr, this message translates to:
  /// **'Santé'**
  String get categoryHealth;

  /// No description provided for @categoryTechnology.
  ///
  /// In fr, this message translates to:
  /// **'Technologie'**
  String get categoryTechnology;

  /// No description provided for @categoryWork.
  ///
  /// In fr, this message translates to:
  /// **'Travail'**
  String get categoryWork;

  /// No description provided for @categoryClothing.
  ///
  /// In fr, this message translates to:
  /// **'Vêtements'**
  String get categoryClothing;

  /// No description provided for @categoryTravel.
  ///
  /// In fr, this message translates to:
  /// **'Voyage'**
  String get categoryTravel;

  /// No description provided for @noIconsLoaded.
  ///
  /// In fr, this message translates to:
  /// **'Aucune icône chargée.'**
  String get noIconsLoaded;

  /// No description provided for @iconLoadError.
  ///
  /// In fr, this message translates to:
  /// **'Impossible de charger les icônes : {message}'**
  String iconLoadError(String message);

  /// No description provided for @noIconsAvailable.
  ///
  /// In fr, this message translates to:
  /// **'Aucune icône disponible.'**
  String get noIconsAvailable;

  /// No description provided for @close.
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get close;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es', 'fr', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
