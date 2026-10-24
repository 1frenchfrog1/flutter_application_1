// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'checklist_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ChecklistLocalizationsEn extends ChecklistLocalizations {
  ChecklistLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get retry => 'Retry';

  @override
  String get todoTitle => 'Title';

  @override
  String get description => 'Description';

  @override
  String get notes => 'Notes';

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
  String get homeTooltip => 'Home';

  @override
  String get myChecklists => 'My Checklists';

  @override
  String get unableToLoadChecklists => 'Unable to load checklists';

  @override
  String get evaluationTools => 'Evaluation tools';

  @override
  String get reload => 'Reload';

  @override
  String get addChecklist => 'Add checklist';

  @override
  String get evaluationPanel => 'Evaluation panel';

  @override
  String get back => 'Back';

  @override
  String get addSampleChecklists => 'Add sample checklists';

  @override
  String get reloadFromStorage => 'Reload from storage';

  @override
  String get deleteAllChecklists => 'Delete all checklists';

  @override
  String get editChecklist => 'Edit checklist';

  @override
  String get otherActions => 'More actions';

  @override
  String get duplicate => 'Duplicate';

  @override
  String get uncheckAll => 'Uncheck all';

  @override
  String get checklistName => 'Checklist name';

  @override
  String get checklistNameHint => 'E.g. Get ready for a trip';

  @override
  String get checklistNameRequired => 'Enter a name for this checklist.';

  @override
  String get checkpoints => 'Checkpoints';

  @override
  String get manageCheckpoints => 'Manage checkpoints';

  @override
  String checkpointCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count checkpoints',
      one: '1 checkpoint',
      zero: 'No checkpoints',
    );
    return '$_temp0';
  }

  @override
  String get iconChoice => 'Choose an icon';

  @override
  String get icon => 'Icon';

  @override
  String get chooseChecklistIcon => 'Choose an icon for the checklist';

  @override
  String get checklistDescriptionHint => 'What is this checklist for?';

  @override
  String get optionalNotes => 'Optional notes';

  @override
  String get saveChecklist => 'Save checklist';

  @override
  String get deleteChecklistConfirmation => 'Delete this checklist?';

  @override
  String get irreversibleAction => 'This action is permanent.';

  @override
  String get editCheckpoint => 'Edit checkpoint';

  @override
  String get editCheckpointTooltip => 'Edit checkpoint';

  @override
  String get removeCheckpoint => 'Remove checkpoint';

  @override
  String get addCheckpoint => 'Add checkpoint';

  @override
  String get deleteCheckpointConfirmation => 'Delete this checkpoint?';

  @override
  String get cannotUndo => 'This action cannot be undone.';

  @override
  String get checkpointTitleRequired => 'Enter a title for this checkpoint.';

  @override
  String get checkpointIcon => 'Checkpoint icon';

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
  String get usefulDetails => 'Useful details';

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
  String get selectCheckpointImage => 'Select checkpoint image';

  @override
  String get nothingSelected => 'No image selected';

  @override
  String get chooseImage => 'Choose image';

  @override
  String get select => 'Select';

  @override
  String notesLabel(String notes) {
    return 'Notes: $notes';
  }

  @override
  String get allCategories => 'All';

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
  String get passportExample => 'E.g. Passport';

  @override
  String get noIconsFound => 'No icons found';

  @override
  String get searchIcon => 'Search icons';

  @override
  String get clearSearch => 'Clear search';

  @override
  String get iconLoadingErrorTitle => 'Unable to load';

  @override
  String get close => 'Close';

  @override
  String get checklistIconPickerTitle => 'Choose an icon';
}
