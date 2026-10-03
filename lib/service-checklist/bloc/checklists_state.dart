import '../datamodel/CheckListDataModel.dart';

abstract class ChecklistsState {}

class ChecklistsLoadInProgress extends ChecklistsState {}

class ChecklistsLoadSuccess extends ChecklistsState {
  final List<CheckList> checklists;

  ChecklistsLoadSuccess(List<CheckList> checklists)
    : checklists = List.unmodifiable(checklists);
}

class ChecklistsLoadFailure extends ChecklistsState {}
