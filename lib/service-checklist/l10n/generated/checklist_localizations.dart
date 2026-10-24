import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'checklist_localizations_de.dart';
import 'checklist_localizations_en.dart';
import 'checklist_localizations_es.dart';
import 'checklist_localizations_fr.dart';
import 'checklist_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ChecklistLocalizations
/// returned by `ChecklistLocalizations.of(context)`.
///
/// Applications need to include `ChecklistLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/checklist_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ChecklistLocalizations.localizationsDelegates,
///   supportedLocales: ChecklistLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the ChecklistLocalizations.supportedLocales
/// property.
abstract class ChecklistLocalizations {
  ChecklistLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ChecklistLocalizations? of(BuildContext context) {
    return Localizations.of<ChecklistLocalizations>(context, ChecklistLocalizations);
  }

  static const LocalizationsDelegate<ChecklistLocalizations> delegate = _ChecklistLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
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
    Locale('it')
  ];

  /// No description provided for @retry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get retry;

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

  /// No description provided for @notes.
  ///
  /// In fr, this message translates to:
  /// **'Notes'**
  String get notes;

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

  /// No description provided for @save.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer'**
  String get save;

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

  /// No description provided for @homeTooltip.
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get homeTooltip;

  /// No description provided for @myChecklists.
  ///
  /// In fr, this message translates to:
  /// **'Mes checklists'**
  String get myChecklists;

  /// No description provided for @unableToLoadChecklists.
  ///
  /// In fr, this message translates to:
  /// **'Impossible de charger les checklists'**
  String get unableToLoadChecklists;

  /// No description provided for @evaluationTools.
  ///
  /// In fr, this message translates to:
  /// **'Outils d’évaluation'**
  String get evaluationTools;

  /// No description provided for @reload.
  ///
  /// In fr, this message translates to:
  /// **'Recharger'**
  String get reload;

  /// No description provided for @addChecklist.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une checklist'**
  String get addChecklist;

  /// No description provided for @evaluationPanel.
  ///
  /// In fr, this message translates to:
  /// **'Panneau d’évaluation'**
  String get evaluationPanel;

  /// No description provided for @back.
  ///
  /// In fr, this message translates to:
  /// **'Retour'**
  String get back;

  /// No description provided for @addSampleChecklists.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter des checklists d’exemple'**
  String get addSampleChecklists;

  /// No description provided for @reloadFromStorage.
  ///
  /// In fr, this message translates to:
  /// **'Recharger depuis le stockage'**
  String get reloadFromStorage;

  /// No description provided for @deleteAllChecklists.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer toutes les checklists'**
  String get deleteAllChecklists;

  /// No description provided for @editChecklist.
  ///
  /// In fr, this message translates to:
  /// **'Modifier la checklist'**
  String get editChecklist;

  /// No description provided for @otherActions.
  ///
  /// In fr, this message translates to:
  /// **'Autres actions'**
  String get otherActions;

  /// No description provided for @duplicate.
  ///
  /// In fr, this message translates to:
  /// **'Dupliquer'**
  String get duplicate;

  /// No description provided for @uncheckAll.
  ///
  /// In fr, this message translates to:
  /// **'Tout décocher'**
  String get uncheckAll;

  /// No description provided for @checklistName.
  ///
  /// In fr, this message translates to:
  /// **'Nom de la checklist'**
  String get checklistName;

  /// No description provided for @checklistNameHint.
  ///
  /// In fr, this message translates to:
  /// **'Ex. Préparer un voyage'**
  String get checklistNameHint;

  /// No description provided for @checklistNameRequired.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez un nom pour la checklist.'**
  String get checklistNameRequired;

  /// No description provided for @checkpoints.
  ///
  /// In fr, this message translates to:
  /// **'Points de contrôle'**
  String get checkpoints;

  /// No description provided for @manageCheckpoints.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les points de contrôle'**
  String get manageCheckpoints;

  /// No description provided for @checkpointCount.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =0{Aucun point} one{1 point} other{{count} points}}'**
  String checkpointCount(int count);

  /// No description provided for @iconChoice.
  ///
  /// In fr, this message translates to:
  /// **'Choix de l’icône'**
  String get iconChoice;

  /// No description provided for @icon.
  ///
  /// In fr, this message translates to:
  /// **'Icône'**
  String get icon;

  /// No description provided for @chooseChecklistIcon.
  ///
  /// In fr, this message translates to:
  /// **'Choisir un symbole pour la checklist'**
  String get chooseChecklistIcon;

  /// No description provided for @checklistDescriptionHint.
  ///
  /// In fr, this message translates to:
  /// **'À quoi sert cette checklist ?'**
  String get checklistDescriptionHint;

  /// No description provided for @optionalNotes.
  ///
  /// In fr, this message translates to:
  /// **'Notes facultatives'**
  String get optionalNotes;

  /// No description provided for @saveChecklist.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer la checklist'**
  String get saveChecklist;

  /// No description provided for @deleteChecklistConfirmation.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer la checklist ?'**
  String get deleteChecklistConfirmation;

  /// No description provided for @irreversibleAction.
  ///
  /// In fr, this message translates to:
  /// **'Cette action est définitive.'**
  String get irreversibleAction;

  /// No description provided for @editCheckpoint.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le point'**
  String get editCheckpoint;

  /// No description provided for @editCheckpointTooltip.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le point de contrôle'**
  String get editCheckpointTooltip;

  /// No description provided for @removeCheckpoint.
  ///
  /// In fr, this message translates to:
  /// **'Retirer le point de contrôle'**
  String get removeCheckpoint;

  /// No description provided for @addCheckpoint.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un point de contrôle'**
  String get addCheckpoint;

  /// No description provided for @deleteCheckpointConfirmation.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer le point de contrôle ?'**
  String get deleteCheckpointConfirmation;

  /// No description provided for @cannotUndo.
  ///
  /// In fr, this message translates to:
  /// **'Cette action ne peut pas être annulée.'**
  String get cannotUndo;

  /// No description provided for @checkpointTitleRequired.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez un titre pour ce point.'**
  String get checkpointTitleRequired;

  /// No description provided for @checkpointIcon.
  ///
  /// In fr, this message translates to:
  /// **'Icône du point de contrôle'**
  String get checkpointIcon;

  /// No description provided for @chooseIcon.
  ///
  /// In fr, this message translates to:
  /// **'Choisir une icône'**
  String get chooseIcon;

  /// No description provided for @iconWillAppearInList.
  ///
  /// In fr, this message translates to:
  /// **'Elle apparaîtra dans la liste'**
  String get iconWillAppearInList;

  /// No description provided for @photo.
  ///
  /// In fr, this message translates to:
  /// **'Photo'**
  String get photo;

  /// No description provided for @noPhotoAdded.
  ///
  /// In fr, this message translates to:
  /// **'Aucune photo ajoutée'**
  String get noPhotoAdded;

  /// No description provided for @addPhoto.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une photo'**
  String get addPhoto;

  /// No description provided for @replace.
  ///
  /// In fr, this message translates to:
  /// **'Remplacer'**
  String get replace;

  /// No description provided for @removePhoto.
  ///
  /// In fr, this message translates to:
  /// **'Retirer la photo'**
  String get removePhoto;

  /// No description provided for @usefulDetails.
  ///
  /// In fr, this message translates to:
  /// **'Détails utiles'**
  String get usefulDetails;

  /// No description provided for @saving.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrement…'**
  String get saving;

  /// No description provided for @photoSaveError.
  ///
  /// In fr, this message translates to:
  /// **'Impossible d’enregistrer la photo.'**
  String get photoSaveError;

  /// No description provided for @selectImageSource.
  ///
  /// In fr, this message translates to:
  /// **'Sélectionner la source de l’image'**
  String get selectImageSource;

  /// No description provided for @camera.
  ///
  /// In fr, this message translates to:
  /// **'Appareil photo'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In fr, this message translates to:
  /// **'Galerie'**
  String get gallery;

  /// No description provided for @selectCheckpointImage.
  ///
  /// In fr, this message translates to:
  /// **'Sélectionner une image pour le point'**
  String get selectCheckpointImage;

  /// No description provided for @nothingSelected.
  ///
  /// In fr, this message translates to:
  /// **'Aucune image sélectionnée'**
  String get nothingSelected;

  /// No description provided for @chooseImage.
  ///
  /// In fr, this message translates to:
  /// **'Choisir une image'**
  String get chooseImage;

  /// No description provided for @select.
  ///
  /// In fr, this message translates to:
  /// **'Sélectionner'**
  String get select;

  /// No description provided for @notesLabel.
  ///
  /// In fr, this message translates to:
  /// **'Notes : {notes}'**
  String notesLabel(String notes);

  /// No description provided for @allCategories.
  ///
  /// In fr, this message translates to:
  /// **'Tout'**
  String get allCategories;

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

  /// No description provided for @passportExample.
  ///
  /// In fr, this message translates to:
  /// **'Ex. Passeport'**
  String get passportExample;

  /// No description provided for @noIconsFound.
  ///
  /// In fr, this message translates to:
  /// **'Aucune icône trouvée'**
  String get noIconsFound;

  /// No description provided for @searchIcon.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher une icône'**
  String get searchIcon;

  /// No description provided for @clearSearch.
  ///
  /// In fr, this message translates to:
  /// **'Effacer la recherche'**
  String get clearSearch;

  /// No description provided for @iconLoadingErrorTitle.
  ///
  /// In fr, this message translates to:
  /// **'Chargement impossible'**
  String get iconLoadingErrorTitle;

  /// No description provided for @close.
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get close;

  /// No description provided for @checklistIconPickerTitle.
  ///
  /// In fr, this message translates to:
  /// **'Choisir une icône'**
  String get checklistIconPickerTitle;
}

class _ChecklistLocalizationsDelegate extends LocalizationsDelegate<ChecklistLocalizations> {
  const _ChecklistLocalizationsDelegate();

  @override
  Future<ChecklistLocalizations> load(Locale locale) {
    return SynchronousFuture<ChecklistLocalizations>(lookupChecklistLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'es', 'fr', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_ChecklistLocalizationsDelegate old) => false;
}

ChecklistLocalizations lookupChecklistLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return ChecklistLocalizationsDe();
    case 'en': return ChecklistLocalizationsEn();
    case 'es': return ChecklistLocalizationsEs();
    case 'fr': return ChecklistLocalizationsFr();
    case 'it': return ChecklistLocalizationsIt();
  }

  throw FlutterError(
    'ChecklistLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
