// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'cook_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class CookLocalizationsFr extends CookLocalizations {
  CookLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get myCooklists => 'Mes Cooklists';

  @override
  String get homeTooltip => 'Accueil';

  @override
  String get unableToLoadCooklists => 'Impossible de charger les cooklists';

  @override
  String get evaluationTools => 'Outils d’évaluation';

  @override
  String get reload => 'Recharger';

  @override
  String get addCooklist => 'Ajouter une cooklist';

  @override
  String get evaluationPanel => 'Panneau d’évaluation';

  @override
  String get back => 'Retour';

  @override
  String get addSampleCooklists => 'Ajouter des recettes d’exemple';

  @override
  String get reloadFromStorage => 'Recharger depuis le stockage';

  @override
  String get deleteAllCooklists => 'Supprimer toutes les cooklists';

  @override
  String get editCooklist => 'Modifier la cooklist';

  @override
  String get otherActions => 'Autres actions';

  @override
  String get duplicate => 'Dupliquer';

  @override
  String get uncheckAll => 'Tout décocher';

  @override
  String get cooklistName => 'Nom de la recette';

  @override
  String get cooklistNameHint => 'Ex. Gratin dauphinois';

  @override
  String get cooklistNameRequired => 'Saisissez un nom pour la recette.';

  @override
  String get steps => 'Étapes';

  @override
  String get manageSteps => 'Gérer les étapes';

  @override
  String stepCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count étapes',
      one: '1 étape',
      zero: 'Aucune étape',
    );
    return '$_temp0';
  }

  @override
  String get iconChoice => 'Choix de l’icône';

  @override
  String get icon => 'Icône';

  @override
  String get chooseCooklistIcon => 'Choisir un symbole pour la recette';

  @override
  String get cooklistDescriptionHint => 'Quelle est cette recette ?';

  @override
  String get optionalNotes => 'Notes facultatives';

  @override
  String get saveCooklist => 'Enregistrer la cooklist';

  @override
  String get deleteCooklistConfirmation => 'Supprimer la cooklist ?';

  @override
  String get irreversibleAction => 'Cette action est définitive.';

  @override
  String get editStep => 'Modifier l’étape';

  @override
  String get editStepTooltip => 'Modifier l’étape';

  @override
  String get removeStep => 'Retirer l’étape';

  @override
  String get addStep => 'Ajouter une étape';

  @override
  String get deleteStepConfirmation => 'Supprimer l’étape ?';

  @override
  String get cannotUndo => 'Cette action ne peut pas être annulée.';

  @override
  String get stepTitle => 'Titre';

  @override
  String get stepTitleRequired => 'Saisissez un titre pour cette étape.';

  @override
  String get stepExample => 'Ex. Faire revenir les oignons';

  @override
  String get stepIcon => 'Icône de l’étape';

  @override
  String get chooseIcon => 'Choisir une icône';

  @override
  String get iconWillAppearInList => 'Elle apparaîtra dans la liste';

  @override
  String get photo => 'Photo';

  @override
  String get noPhotoAdded => 'Aucune photo ajoutée';

  @override
  String get addPhoto => 'Ajouter une photo';

  @override
  String get replace => 'Remplacer';

  @override
  String get removePhoto => 'Retirer la photo';

  @override
  String get description => 'Description';

  @override
  String get usefulDetails => 'Détails utiles';

  @override
  String get notes => 'Notes';

  @override
  String notesLabel(String notes) {
    return 'Notes : $notes';
  }

  @override
  String get saving => 'Enregistrement…';

  @override
  String get photoSaveError => 'Impossible d’enregistrer la photo.';

  @override
  String get selectImageSource => 'Sélectionner la source de l’image';

  @override
  String get camera => 'Appareil photo';

  @override
  String get gallery => 'Galerie';

  @override
  String get selectStepImage => 'Sélectionner une image pour l’étape';

  @override
  String get nothingSelected => 'Aucune image sélectionnée';

  @override
  String get chooseImage => 'Choisir une image';

  @override
  String get select => 'Sélectionner';

  @override
  String get tools => 'Outils';

  @override
  String get all => 'Toutes';

  @override
  String get leftToDo => 'À faire';

  @override
  String get save => 'Enregistrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get retry => 'Réessayer';

  @override
  String get close => 'Fermer';

  @override
  String get iconLoadingErrorTitle => 'Chargement impossible';

  @override
  String get cooklistIconPickerTitle => 'Choisir une icône';

  @override
  String get searchIcon => 'Rechercher une icône';

  @override
  String get clearSearch => 'Effacer la recherche';

  @override
  String get allCategories => 'Tout';

  @override
  String get noIconsFound => 'Aucune icône trouvée';

  @override
  String get categoryEssential => 'Essentiel';

  @override
  String get categoryFamily => 'Famille';

  @override
  String get categoryLeisure => 'Loisirs';

  @override
  String get categoryWeather => 'Météo';

  @override
  String get categoryHome => 'Maison';

  @override
  String get categoryFood => 'Nourriture';

  @override
  String get categoryTravelItems => 'Objets de voyage';

  @override
  String get categoryHealth => 'Santé';

  @override
  String get categoryTechnology => 'Technologie';

  @override
  String get categoryWork => 'Travail';

  @override
  String get categoryClothing => 'Vêtements';

  @override
  String get categoryTravel => 'Voyage';
}
