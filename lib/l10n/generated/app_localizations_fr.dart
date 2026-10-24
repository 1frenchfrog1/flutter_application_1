// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Todo List';

  @override
  String get home => 'Accueil';

  @override
  String get openTodoList => 'Mes todo-list';

  @override
  String get openChecklists => 'Mes checklists';

  @override
  String get openIconCatalog => 'Ouvrir le catalogue d’icônes';

  @override
  String get changeLanguage => 'Changer la langue';

  @override
  String get loadingLanguage => 'Chargement de la langue…';

  @override
  String get languageLoadError =>
      'Impossible de charger la langue enregistrée.';

  @override
  String get languageSaveError =>
      'La langue n’a pas pu être enregistrée. Votre choix ne sera pas conservé au prochain démarrage.';

  @override
  String get continueInFrench => 'Continuer en français';

  @override
  String get retry => 'Réessayer';

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
  String get myTodoList => 'Ma todo-list';

  @override
  String get editTodo => 'Modifier la tâche';

  @override
  String get addTodo => 'Ajouter une tâche';

  @override
  String get todoTitle => 'Titre';

  @override
  String get description => 'Description';

  @override
  String get todoDetails => 'Détails de la tâche';

  @override
  String get deleteCompletedTodos => 'Supprimer les tâches terminées';

  @override
  String get todoDeleted => 'Tâche supprimée';

  @override
  String get undo => 'Annuler';

  @override
  String get tools => 'Outils';

  @override
  String get all => 'Toutes';

  @override
  String get leftToDo => 'À faire';

  @override
  String openTaskCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tâches ouvertes',
      one: '1 tâche ouverte',
      zero: 'Aucune tâche ouverte',
    );
    return '$_temp0';
  }

  @override
  String get todoPoints => 'Points à traiter';

  @override
  String get emptyTodoDescription => 'Aucun contenu pour cette tâche.';

  @override
  String get emptyTodoTitle => 'Tout est en ordre';

  @override
  String get emptyTodoMessage => 'Ajoutez une tâche pour commencer.';

  @override
  String get todoTitleRequired => 'Le titre ne peut pas être vide.';

  @override
  String get save => 'Enregistrer';

  @override
  String get addTodoAction => 'Ajouter la tâche';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get modify => 'Modifier';

  @override
  String get deleteTodoConfirmation => 'Supprimer cette tâche ?';

  @override
  String deleteTodoConfirmationContent(String title) {
    return 'La tâche « $title » sera supprimée définitivement.';
  }

  @override
  String get homeTooltip => 'Accueil';

  @override
  String get toolsTooltip => 'Outils';

  @override
  String get icon => 'Icône';

  @override
  String get iconCatalog => 'Catalogue d’icônes';

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
  String get noIconsLoaded => 'Aucune icône chargée.';

  @override
  String iconLoadError(String message) {
    return 'Impossible de charger les icônes : $message';
  }

  @override
  String get noIconsAvailable => 'Aucune icône disponible.';

  @override
  String get close => 'Fermer';
}
