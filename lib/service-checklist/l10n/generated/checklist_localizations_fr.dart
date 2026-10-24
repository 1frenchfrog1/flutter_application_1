// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'checklist_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class ChecklistLocalizationsFr extends ChecklistLocalizations {
  ChecklistLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get retry => 'Réessayer';

  @override
  String get todoTitle => 'Titre';

  @override
  String get description => 'Description';

  @override
  String get notes => 'Notes';

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
  String get homeTooltip => 'Accueil';

  @override
  String get myChecklists => 'Mes checklists';

  @override
  String get unableToLoadChecklists => 'Impossible de charger les checklists';

  @override
  String get evaluationTools => 'Outils d’évaluation';

  @override
  String get reload => 'Recharger';

  @override
  String get addChecklist => 'Ajouter une checklist';

  @override
  String get evaluationPanel => 'Panneau d’évaluation';

  @override
  String get back => 'Retour';

  @override
  String get addSampleChecklists => 'Ajouter des checklists d’exemple';

  @override
  String get reloadFromStorage => 'Recharger depuis le stockage';

  @override
  String get deleteAllChecklists => 'Supprimer toutes les checklists';

  @override
  String get editChecklist => 'Modifier la checklist';

  @override
  String get otherActions => 'Autres actions';

  @override
  String get duplicate => 'Dupliquer';

  @override
  String get uncheckAll => 'Tout décocher';

  @override
  String get checklistName => 'Nom de la checklist';

  @override
  String get checklistNameHint => 'Ex. Préparer un voyage';

  @override
  String get checklistNameRequired => 'Saisissez un nom pour la checklist.';

  @override
  String get checkpoints => 'Points de contrôle';

  @override
  String get manageCheckpoints => 'Gérer les points de contrôle';

  @override
  String checkpointCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count points',
      one: '1 point',
      zero: 'Aucun point',
    );
    return '$_temp0';
  }

  @override
  String get iconChoice => 'Choix de l’icône';

  @override
  String get icon => 'Icône';

  @override
  String get chooseChecklistIcon => 'Choisir un symbole pour la checklist';

  @override
  String get checklistDescriptionHint => 'À quoi sert cette checklist ?';

  @override
  String get optionalNotes => 'Notes facultatives';

  @override
  String get saveChecklist => 'Enregistrer la checklist';

  @override
  String get deleteChecklistConfirmation => 'Supprimer la checklist ?';

  @override
  String get irreversibleAction => 'Cette action est définitive.';

  @override
  String get editCheckpoint => 'Modifier le point';

  @override
  String get editCheckpointTooltip => 'Modifier le point de contrôle';

  @override
  String get removeCheckpoint => 'Retirer le point de contrôle';

  @override
  String get addCheckpoint => 'Ajouter un point de contrôle';

  @override
  String get deleteCheckpointConfirmation => 'Supprimer le point de contrôle ?';

  @override
  String get cannotUndo => 'Cette action ne peut pas être annulée.';

  @override
  String get checkpointTitleRequired => 'Saisissez un titre pour ce point.';

  @override
  String get checkpointIcon => 'Icône du point de contrôle';

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
  String get usefulDetails => 'Détails utiles';

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
  String get selectCheckpointImage => 'Sélectionner une image pour le point';

  @override
  String get nothingSelected => 'Aucune image sélectionnée';

  @override
  String get chooseImage => 'Choisir une image';

  @override
  String get select => 'Sélectionner';

  @override
  String notesLabel(String notes) {
    return 'Notes : $notes';
  }

  @override
  String get allCategories => 'Tout';

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

  @override
  String get passportExample => 'Ex. Passeport';

  @override
  String get noIconsFound => 'Aucune icône trouvée';

  @override
  String get searchIcon => 'Rechercher une icône';

  @override
  String get clearSearch => 'Effacer la recherche';

  @override
  String get iconLoadingErrorTitle => 'Chargement impossible';

  @override
  String get close => 'Fermer';

  @override
  String get checklistIconPickerTitle => 'Choisir une icône';
}
