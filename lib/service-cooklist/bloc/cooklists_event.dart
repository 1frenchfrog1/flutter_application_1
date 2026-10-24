import '../datamodel/cook_list_data_model.dart';

abstract class CooklistsEvent {}

class CooklistsLoadRequested extends CooklistsEvent {}

class CooklistsDemoDataRequested extends CooklistsEvent {}

class CooklistsCleared extends CooklistsEvent {}

class CooklistCreated extends CooklistsEvent {}

class CooklistCloned extends CooklistsEvent {
  final String cooklistId;

  CooklistCloned(this.cooklistId);
}

class CooklistDeleted extends CooklistsEvent {
  final String cooklistId;

  CooklistDeleted(this.cooklistId);
}

class CooklistSaved extends CooklistsEvent {
  final CookList cooklist;

  CooklistSaved(this.cooklist);
}

class CookStepAdded extends CooklistsEvent {
  final String cooklistId;
  final int? afterIndex;

  CookStepAdded(this.cooklistId, {this.afterIndex});
}

class CookStepSaved extends CooklistsEvent {
  final String cooklistId;
  final int index;
  final CookStep step;

  CookStepSaved(this.cooklistId, this.index, this.step);
}

class CookStepDeleted extends CooklistsEvent {
  final String cooklistId;
  final int index;

  CookStepDeleted(this.cooklistId, this.index);
}

class CookStepReordered extends CooklistsEvent {
  final String cooklistId;
  final int oldIndex;
  final int newIndex;

  CookStepReordered(this.cooklistId, this.oldIndex, this.newIndex);
}

class CookStepStateChanged extends CooklistsEvent {
  final String cooklistId;
  final int index;
  final bool isChecked;

  CookStepStateChanged(this.cooklistId, this.index, this.isChecked);
}

class CookStepsUnchecked extends CooklistsEvent {
  final String cooklistId;

  CookStepsUnchecked(this.cooklistId);
}
