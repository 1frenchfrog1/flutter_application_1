import '../datamodel/CheckListDataModel.dart';

abstract class ChecklistsEvent {}

class ChecklistsLoadRequested extends ChecklistsEvent {}

class ChecklistsDemoDataRequested extends ChecklistsEvent {}

class ChecklistsCleared extends ChecklistsEvent {}

class ChecklistCreated extends ChecklistsEvent {}

class ChecklistCloned extends ChecklistsEvent {
  final String checklistId;

  ChecklistCloned(this.checklistId);
}

class ChecklistDeleted extends ChecklistsEvent {
  final String checklistId;

  ChecklistDeleted(this.checklistId);
}

class ChecklistSaved extends ChecklistsEvent {
  final CheckList checklist;

  ChecklistSaved(this.checklist);
}

class CheckpointAdded extends ChecklistsEvent {
  final String checklistId;
  final int? afterIndex;

  CheckpointAdded(this.checklistId, {this.afterIndex});
}

class CheckpointSaved extends ChecklistsEvent {
  final String checklistId;
  final int index;
  final ActionObject checkpoint;

  CheckpointSaved(this.checklistId, this.index, this.checkpoint);
}

class CheckpointDeleted extends ChecklistsEvent {
  final String checklistId;
  final int index;

  CheckpointDeleted(this.checklistId, this.index);
}

class CheckpointReordered extends ChecklistsEvent {
  final String checklistId;
  final int oldIndex;
  final int newIndex;

  CheckpointReordered(this.checklistId, this.oldIndex, this.newIndex);
}

class CheckpointStateChanged extends ChecklistsEvent {
  final String checklistId;
  final int index;
  final bool isChecked;

  CheckpointStateChanged(this.checklistId, this.index, this.isChecked);
}

class CheckpointsUnchecked extends ChecklistsEvent {
  final String checklistId;

  CheckpointsUnchecked(this.checklistId);
}
