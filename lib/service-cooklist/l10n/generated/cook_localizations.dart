import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'cook_localizations_de.dart';
import 'cook_localizations_en.dart';
import 'cook_localizations_es.dart';
import 'cook_localizations_fr.dart';
import 'cook_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of CookLocalizations
/// returned by `CookLocalizations.of(context)`.
///
/// Applications need to include `CookLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/cook_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: CookLocalizations.localizationsDelegates,
///   supportedLocales: CookLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the CookLocalizations.supportedLocales
/// property.
abstract class CookLocalizations {
  CookLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static CookLocalizations? of(BuildContext context) {
    return Localizations.of<CookLocalizations>(context, CookLocalizations);
  }

  static const LocalizationsDelegate<CookLocalizations> delegate = _CookLocalizationsDelegate();

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

  /// No description provided for @myCooklists.
  ///
  /// In fr, this message translates to:
  /// **'Mes Cooklists'**
  String get myCooklists;

  /// No description provided for @homeTooltip.
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get homeTooltip;

  /// No description provided for @unableToLoadCooklists.
  ///
  /// In fr, this message translates to:
  /// **'Impossible de charger les cooklists'**
  String get unableToLoadCooklists;

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

  /// No description provided for @addCooklist.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une cooklist'**
  String get addCooklist;

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

  /// No description provided for @addSampleCooklists.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter des recettes d’exemple'**
  String get addSampleCooklists;

  /// No description provided for @reloadFromStorage.
  ///
  /// In fr, this message translates to:
  /// **'Recharger depuis le stockage'**
  String get reloadFromStorage;

  /// No description provided for @deleteAllCooklists.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer toutes les cooklists'**
  String get deleteAllCooklists;

  /// No description provided for @editCooklist.
  ///
  /// In fr, this message translates to:
  /// **'Modifier la cooklist'**
  String get editCooklist;

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

  /// No description provided for @cooklistName.
  ///
  /// In fr, this message translates to:
  /// **'Nom de la recette'**
  String get cooklistName;

  /// No description provided for @cooklistNameHint.
  ///
  /// In fr, this message translates to:
  /// **'Ex. Gratin dauphinois'**
  String get cooklistNameHint;

  /// No description provided for @cooklistNameRequired.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez un nom pour la recette.'**
  String get cooklistNameRequired;

  /// No description provided for @steps.
  ///
  /// In fr, this message translates to:
  /// **'Étapes'**
  String get steps;

  /// No description provided for @manageSteps.
  ///
  /// In fr, this message translates to:
  /// **'Gérer les étapes'**
  String get manageSteps;

  /// No description provided for @stepCount.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =0{Aucune étape} one{1 étape} other{{count} étapes}}'**
  String stepCount(int count);

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

  /// No description provided for @chooseCooklistIcon.
  ///
  /// In fr, this message translates to:
  /// **'Choisir un symbole pour la recette'**
  String get chooseCooklistIcon;

  /// No description provided for @cooklistDescriptionHint.
  ///
  /// In fr, this message translates to:
  /// **'Quelle est cette recette ?'**
  String get cooklistDescriptionHint;

  /// No description provided for @optionalNotes.
  ///
  /// In fr, this message translates to:
  /// **'Notes facultatives'**
  String get optionalNotes;

  /// No description provided for @saveCooklist.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer la cooklist'**
  String get saveCooklist;

  /// No description provided for @deleteCooklistConfirmation.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer la cooklist ?'**
  String get deleteCooklistConfirmation;

  /// No description provided for @irreversibleAction.
  ///
  /// In fr, this message translates to:
  /// **'Cette action est définitive.'**
  String get irreversibleAction;

  /// No description provided for @editStep.
  ///
  /// In fr, this message translates to:
  /// **'Modifier l’étape'**
  String get editStep;

  /// No description provided for @editStepTooltip.
  ///
  /// In fr, this message translates to:
  /// **'Modifier l’étape'**
  String get editStepTooltip;

  /// No description provided for @removeStep.
  ///
  /// In fr, this message translates to:
  /// **'Retirer l’étape'**
  String get removeStep;

  /// No description provided for @addStep.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une étape'**
  String get addStep;

  /// No description provided for @ingredients.
  ///
  /// In fr, this message translates to:
  /// **'Ingrédients'**
  String get ingredients;

  /// No description provided for @noIngredients.
  ///
  /// In fr, this message translates to:
  /// **'Aucun ingrédient'**
  String get noIngredients;

  /// No description provided for @editIngredients.
  ///
  /// In fr, this message translates to:
  /// **'Modifier les ingrédients'**
  String get editIngredients;

  /// No description provided for @editIngredient.
  ///
  /// In fr, this message translates to:
  /// **'Modifier l\'ingrédient'**
  String get editIngredient;

  /// No description provided for @addIngredient.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un ingrédient'**
  String get addIngredient;

  /// No description provided for @removeIngredient.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer l\'ingrédient'**
  String get removeIngredient;

  /// No description provided for @deleteIngredientConfirmation.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer cet ingrédient ?'**
  String get deleteIngredientConfirmation;

  /// No description provided for @ingredientName.
  ///
  /// In fr, this message translates to:
  /// **'Ingrédient'**
  String get ingredientName;

  /// No description provided for @ingredientNameExample.
  ///
  /// In fr, this message translates to:
  /// **'Farine, crème, œufs…'**
  String get ingredientNameExample;

  /// No description provided for @ingredientNameRequired.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez le nom de l\'ingrédient'**
  String get ingredientNameRequired;

  /// No description provided for @ingredientQuantity.
  ///
  /// In fr, this message translates to:
  /// **'Quantité'**
  String get ingredientQuantity;

  /// No description provided for @ingredientQuantityInvalid.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez un nombre valide'**
  String get ingredientQuantityInvalid;

  /// No description provided for @ingredientUnit.
  ///
  /// In fr, this message translates to:
  /// **'Unité'**
  String get ingredientUnit;

  /// No description provided for @utensils.
  ///
  /// In fr, this message translates to:
  /// **'Ustensiles & outils'**
  String get utensils;

  /// No description provided for @noUtensils.
  ///
  /// In fr, this message translates to:
  /// **'Aucun ustensile'**
  String get noUtensils;

  /// No description provided for @editUtensils.
  ///
  /// In fr, this message translates to:
  /// **'Modifier les ustensiles & outils'**
  String get editUtensils;

  /// No description provided for @editUtensil.
  ///
  /// In fr, this message translates to:
  /// **'Modifier l\'ustensile'**
  String get editUtensil;

  /// No description provided for @addUtensil.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un ustensile'**
  String get addUtensil;

  /// No description provided for @removeUtensil.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer l\'ustensile'**
  String get removeUtensil;

  /// No description provided for @deleteUtensilConfirmation.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer cet ustensile ?'**
  String get deleteUtensilConfirmation;

  /// No description provided for @utensilName.
  ///
  /// In fr, this message translates to:
  /// **'Ustensile ou outil'**
  String get utensilName;

  /// No description provided for @utensilNameExample.
  ///
  /// In fr, this message translates to:
  /// **'Bol, four, fouet…'**
  String get utensilNameExample;

  /// No description provided for @utensilNameRequired.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez le nom de l\'ustensile'**
  String get utensilNameRequired;

  /// No description provided for @deleteStepConfirmation.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer l’étape ?'**
  String get deleteStepConfirmation;

  /// No description provided for @cannotUndo.
  ///
  /// In fr, this message translates to:
  /// **'Cette action ne peut pas être annulée.'**
  String get cannotUndo;

  /// No description provided for @stepTitle.
  ///
  /// In fr, this message translates to:
  /// **'Titre'**
  String get stepTitle;

  /// No description provided for @stepTitleRequired.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez un titre pour cette étape.'**
  String get stepTitleRequired;

  /// No description provided for @stepExample.
  ///
  /// In fr, this message translates to:
  /// **'Ex. Faire revenir les oignons'**
  String get stepExample;

  /// No description provided for @stepIcon.
  ///
  /// In fr, this message translates to:
  /// **'Icône de l’étape'**
  String get stepIcon;

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

  /// No description provided for @description.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @usefulDetails.
  ///
  /// In fr, this message translates to:
  /// **'Détails utiles'**
  String get usefulDetails;

  /// No description provided for @notes.
  ///
  /// In fr, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @notesLabel.
  ///
  /// In fr, this message translates to:
  /// **'Notes : {notes}'**
  String notesLabel(String notes);

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

  /// No description provided for @selectStepImage.
  ///
  /// In fr, this message translates to:
  /// **'Sélectionner une image pour l’étape'**
  String get selectStepImage;

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

  /// No description provided for @retry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get retry;

  /// No description provided for @close.
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get close;

  /// No description provided for @iconLoadingErrorTitle.
  ///
  /// In fr, this message translates to:
  /// **'Chargement impossible'**
  String get iconLoadingErrorTitle;

  /// No description provided for @cooklistIconPickerTitle.
  ///
  /// In fr, this message translates to:
  /// **'Choisir une icône'**
  String get cooklistIconPickerTitle;

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

  /// No description provided for @allCategories.
  ///
  /// In fr, this message translates to:
  /// **'Tout'**
  String get allCategories;

  /// No description provided for @noIconsFound.
  ///
  /// In fr, this message translates to:
  /// **'Aucune icône trouvée'**
  String get noIconsFound;

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
}

class _CookLocalizationsDelegate extends LocalizationsDelegate<CookLocalizations> {
  const _CookLocalizationsDelegate();

  @override
  Future<CookLocalizations> load(Locale locale) {
    return SynchronousFuture<CookLocalizations>(lookupCookLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'es', 'fr', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_CookLocalizationsDelegate old) => false;
}

CookLocalizations lookupCookLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return CookLocalizationsDe();
    case 'en': return CookLocalizationsEn();
    case 'es': return CookLocalizationsEs();
    case 'fr': return CookLocalizationsFr();
    case 'it': return CookLocalizationsIt();
  }

  throw FlutterError(
    'CookLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
