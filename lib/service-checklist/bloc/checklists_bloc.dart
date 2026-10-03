import 'package:bloc/bloc.dart';

import '../datamodel/CheckListDataModel.dart';
import '../datamodel/checklists_repository.dart';
import 'checklists_event.dart';
import 'checklists_state.dart';

class ChecklistsBloc extends Bloc<ChecklistsEvent, ChecklistsState> {
  final ChecklistsRepository repository;

  ChecklistsBloc({required this.repository})
    : super(ChecklistsLoadInProgress()) {
    on<ChecklistsLoadRequested>(_loadChecklists);
    on<ChecklistsDemoDataRequested>((event, emit) async {
      await _updateChecklists(emit, (checklists) {
        final collection = AppCheckLists()..allCheckLists = checklists;
        collection.ivvqFillAppCheckList('Sample');
        return collection.allCheckLists;
      });
    });
    on<ChecklistsCleared>((event, emit) async {
      await _updateChecklists(emit, (_) => []);
    });
    on<ChecklistCreated>((event, emit) async {
      await _updateChecklists(emit, (checklists) {
        final collection = AppCheckLists()..allCheckLists = checklists;
        collection.addNewChecklist();
        return collection.allCheckLists;
      });
    });
    on<ChecklistCloned>((event, emit) async {
      await _updateChecklists(emit, (checklists) {
        final source = _findChecklist(checklists, event.checklistId);
        final clone = source.copyChecklist()..title += ' [CLONE]';
        return [...checklists, clone];
      });
    });
    on<ChecklistDeleted>((event, emit) async {
      await _updateChecklists(
        emit,
        (checklists) => checklists
            .where((checklist) => checklist.uuid != event.checklistId)
            .toList(),
      );
    });
    on<ChecklistSaved>((event, emit) async {
      await _updateChecklists(emit, (checklists) {
        return checklists.map((checklist) {
          if (checklist.uuid != event.checklist.uuid) return checklist;
          final updated = _copyChecklist(checklist)
            ..title = event.checklist.title
            ..icon = event.checklist.icon
            ..description = event.checklist.description
            ..notes = event.checklist.notes
            ..dateTime = event.checklist.dateTime;
          return updated;
        }).toList();
      });
    });
    on<CheckpointAdded>((event, emit) async {
      await _updateChecklists(emit, (checklists) {
        final checklist = _findChecklist(checklists, event.checklistId);
        checklist.addNewActionObject(event.afterIndex);
        return checklists;
      });
    });
    on<CheckpointSaved>((event, emit) async {
      await _updateChecklists(emit, (checklists) {
        _findChecklist(checklists, event.checklistId)
            .checkListObjects[event.index]
            .updateWithActionObject(event.checkpoint);
        final saved = _findChecklist(
          checklists,
          event.checklistId,
        ).checkListObjects[event.index];
        saved.state = event.checkpoint.state;
        return checklists;
      });
    });
    on<CheckpointDeleted>((event, emit) async {
      await _updateChecklists(emit, (checklists) {
        _findChecklist(
          checklists,
          event.checklistId,
        ).checkListObjects.removeAt(event.index);
        return checklists;
      });
    });
    on<CheckpointReordered>((event, emit) async {
      await _updateChecklists(emit, (checklists) {
        final items = _findChecklist(
          checklists,
          event.checklistId,
        ).checkListObjects;
        final item = items.removeAt(event.oldIndex);
        items.insert(event.newIndex, item);
        return checklists;
      });
    });
    on<CheckpointStateChanged>((event, emit) async {
      await _updateChecklists(emit, (checklists) {
        _findChecklist(
          checklists,
          event.checklistId,
        ).checkListObjects[event.index].state = event.isChecked;
        return checklists;
      });
    });
    on<CheckpointsUnchecked>((event, emit) async {
      await _updateChecklists(emit, (checklists) {
        for (final checkpoint in _findChecklist(
          checklists,
          event.checklistId,
        ).checkListObjects) {
          checkpoint.state = false;
        }
        return checklists;
      });
    });
  }

  Future<void> _loadChecklists(
    ChecklistsLoadRequested event,
    Emitter<ChecklistsState> emit,
  ) async {
    try {
      emit(ChecklistsLoadSuccess(await repository.loadChecklists()));
    } catch (_) {
      emit(ChecklistsLoadFailure());
    }
  }

  Future<void> _updateChecklists(
    Emitter<ChecklistsState> emit,
    List<CheckList> Function(List<CheckList>) update,
  ) async {
    final current = state;
    if (current is! ChecklistsLoadSuccess) return;

    final checklists = current.checklists.map(_copyChecklist).toList();
    try {
      final updated = update(checklists);
      await repository.saveChecklists(updated);
      emit(ChecklistsLoadSuccess(updated));
    } catch (_) {
      emit(current);
    }
  }

  CheckList _findChecklist(List<CheckList> checklists, String id) {
    return checklists.firstWhere((checklist) => checklist.uuid == id);
  }

  CheckList _copyChecklist(CheckList checklist) {
    return CheckList.fromJson(checklist.toJson());
  }
}
