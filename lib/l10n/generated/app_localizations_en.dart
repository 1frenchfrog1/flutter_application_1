// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Todo List';

  @override
  String get home => 'Home';

  @override
  String get openTodoList => 'Open my todo list';

  @override
  String get openChecklists => 'Open my checklists';

  @override
  String get openIconCatalog => 'Open icon catalog';

  @override
  String get changeLanguage => 'Change language';

  @override
  String get loadingLanguage => 'Loading language…';

  @override
  String get languageLoadError => 'Unable to load the saved language.';

  @override
  String get languageSaveError =>
      'The language could not be saved. Your choice will not be kept after restarting the app.';

  @override
  String get continueInFrench => 'Continue in French';

  @override
  String get retry => 'Retry';

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
  String get myTodoList => 'My todo list';

  @override
  String get editTodo => 'Edit task';

  @override
  String get addTodo => 'Add task';

  @override
  String get todoTitle => 'Title';

  @override
  String get description => 'Description';

  @override
  String get todoDetails => 'Task details';

  @override
  String get deleteCompletedTodos => 'Delete completed tasks';

  @override
  String get todoDeleted => 'Task deleted';

  @override
  String get undo => 'Undo';

  @override
  String get tools => 'Tools';

  @override
  String get all => 'All';

  @override
  String get leftToDo => 'To do';

  @override
  String openTaskCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count open tasks',
      one: '1 open task',
      zero: 'No open tasks',
    );
    return '$_temp0';
  }

  @override
  String get todoPoints => 'Items to address';

  @override
  String get emptyTodoDescription => 'There is no content for this task.';

  @override
  String get emptyTodoTitle => 'You\'re all caught up';

  @override
  String get emptyTodoMessage => 'Add a task to get started.';

  @override
  String get todoTitleRequired => 'The title can\'t be empty.';

  @override
  String get save => 'Save';

  @override
  String get addTodoAction => 'Add task';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get modify => 'Edit';

  @override
  String get deleteTodoConfirmation => 'Delete this task?';

  @override
  String deleteTodoConfirmationContent(String title) {
    return 'The task “$title” will be permanently deleted.';
  }

  @override
  String get homeTooltip => 'Home';

  @override
  String get toolsTooltip => 'Tools';

  @override
  String get icon => 'Icon';

  @override
  String get iconCatalog => 'Icon catalog';

  @override
  String get categoryEssential => 'Essentials';

  @override
  String get categoryFamily => 'Family';

  @override
  String get categoryLeisure => 'Leisure';

  @override
  String get categoryWeather => 'Weather';

  @override
  String get categoryHome => 'Home';

  @override
  String get categoryFood => 'Food';

  @override
  String get categoryTravelItems => 'Travel items';

  @override
  String get categoryHealth => 'Health';

  @override
  String get categoryTechnology => 'Technology';

  @override
  String get categoryWork => 'Work';

  @override
  String get categoryClothing => 'Clothing';

  @override
  String get categoryTravel => 'Travel';

  @override
  String get noIconsLoaded => 'No icons loaded.';

  @override
  String iconLoadError(String message) {
    return 'Unable to load icons: $message';
  }

  @override
  String get noIconsAvailable => 'No icons available.';

  @override
  String get close => 'Close';
}
