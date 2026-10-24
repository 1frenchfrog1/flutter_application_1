// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'cook_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class CookLocalizationsEn extends CookLocalizations {
  CookLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get myCooklists => 'My Cooklists';

  @override
  String get homeTooltip => 'Home';

  @override
  String get unableToLoadCooklists => 'Unable to load cooklists';

  @override
  String get evaluationTools => 'Evaluation tools';

  @override
  String get reload => 'Reload';

  @override
  String get addCooklist => 'Add cooklist';

  @override
  String get evaluationPanel => 'Evaluation panel';

  @override
  String get back => 'Back';

  @override
  String get addSampleCooklists => 'Add sample recipes';

  @override
  String get reloadFromStorage => 'Reload from storage';

  @override
  String get deleteAllCooklists => 'Delete all cooklists';

  @override
  String get editCooklist => 'Edit cooklist';

  @override
  String get otherActions => 'More actions';

  @override
  String get duplicate => 'Duplicate';

  @override
  String get uncheckAll => 'Uncheck all';

  @override
  String get cooklistName => 'Recipe name';

  @override
  String get cooklistNameHint => 'E.g. Potato gratin';

  @override
  String get cooklistNameRequired => 'Enter a name for this recipe.';

  @override
  String get steps => 'Steps';

  @override
  String get manageSteps => 'Manage steps';

  @override
  String stepCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count steps',
      one: '1 step',
      zero: 'No steps',
    );
    return '$_temp0';
  }

  @override
  String get iconChoice => 'Choose an icon';

  @override
  String get icon => 'Icon';

  @override
  String get chooseCooklistIcon => 'Choose an icon for the recipe';

  @override
  String get cooklistDescriptionHint => 'What is this recipe about?';

  @override
  String get optionalNotes => 'Optional notes';

  @override
  String get saveCooklist => 'Save cooklist';

  @override
  String get deleteCooklistConfirmation => 'Delete this cooklist?';

  @override
  String get irreversibleAction => 'This action is permanent.';

  @override
  String get editStep => 'Edit step';

  @override
  String get editStepTooltip => 'Edit step';

  @override
  String get removeStep => 'Remove step';

  @override
  String get addStep => 'Add step';

  @override
  String get deleteStepConfirmation => 'Delete this step?';

  @override
  String get cannotUndo => 'This action cannot be undone.';

  @override
  String get stepTitle => 'Title';

  @override
  String get stepTitleRequired => 'Enter a title for this step.';

  @override
  String get stepExample => 'E.g. Sauté the onions';

  @override
  String get stepIcon => 'Step icon';

  @override
  String get chooseIcon => 'Choose an icon';

  @override
  String get iconWillAppearInList => 'It will appear in the list';

  @override
  String get photo => 'Photo';

  @override
  String get noPhotoAdded => 'No photo added';

  @override
  String get addPhoto => 'Add photo';

  @override
  String get replace => 'Replace';

  @override
  String get removePhoto => 'Remove photo';

  @override
  String get description => 'Description';

  @override
  String get usefulDetails => 'Useful details';

  @override
  String get notes => 'Notes';

  @override
  String notesLabel(String notes) {
    return 'Notes: $notes';
  }

  @override
  String get saving => 'Saving…';

  @override
  String get photoSaveError => 'Unable to save the photo.';

  @override
  String get selectImageSource => 'Select image source';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get selectStepImage => 'Select step image';

  @override
  String get nothingSelected => 'No image selected';

  @override
  String get chooseImage => 'Choose image';

  @override
  String get select => 'Select';

  @override
  String get tools => 'Tools';

  @override
  String get all => 'All';

  @override
  String get leftToDo => 'To do';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get retry => 'Retry';

  @override
  String get close => 'Close';

  @override
  String get iconLoadingErrorTitle => 'Unable to load';

  @override
  String get cooklistIconPickerTitle => 'Choose an icon';

  @override
  String get searchIcon => 'Search icons';

  @override
  String get clearSearch => 'Clear search';

  @override
  String get allCategories => 'All';

  @override
  String get noIconsFound => 'No icons found';

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
}
