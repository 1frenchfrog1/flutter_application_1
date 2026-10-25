import 'package:bloc/bloc.dart';

import '../../features/icons/di/icon_injection.dart';
import '../../features/icons/domain/entities/icon_entity.dart';
import '../../features/icons/domain/usecases/get_dynamic_icons_use_case.dart';
import '../datamodel/cook_list_data_model.dart';
import '../datamodel/cooklists_repository.dart';
import 'cooklists_event.dart';
import 'cooklists_state.dart';

class CooklistsBloc extends Bloc<CooklistsEvent, CooklistsState> {
  final CooklistsRepository repository;

  CooklistsBloc({required this.repository})
    : super(CooklistsLoadInProgress()) {
    on<CooklistsLoadRequested>(_loadCooklists);
    on<CooklistsDemoDataRequested>((event, emit) async {
      final icons = await iconGetIt<GetDynamicIconsUseCase>()();
      await _updateCooklists(emit, (cooklists) {
        final collection = AppCookLists()..allCookLists = cooklists;
        collection.addDemoCooklists(icons);
        return collection.allCookLists;
      });
    });
    on<CooklistsCleared>((event, emit) async {
      await _updateCooklists(emit, (_) => []);
    });
    on<CooklistCreated>((event, emit) async {
      await _updateCooklists(emit, (cooklists) {
        final collection = AppCookLists()..allCookLists = cooklists;
        collection.addNewCooklist();
        return collection.allCookLists;
      });
    });
    on<CooklistCloned>((event, emit) async {
      await _updateCooklists(emit, (cooklists) {
        final source = _findCooklist(cooklists, event.cooklistId);
        final clone = source.copyCooklist()..title += ' [CLONE]';
        return [...cooklists, clone];
      });
    });
    on<CooklistDeleted>((event, emit) async {
      await _updateCooklists(
        emit,
        (cooklists) => cooklists
            .where((cooklist) => cooklist.uuid != event.cooklistId)
            .toList(),
      );
    });
    on<CooklistSaved>((event, emit) async {
      await _updateCooklists(emit, (cooklists) {
        return cooklists.map((cooklist) {
          if (cooklist.uuid != event.cooklist.uuid) return cooklist;
          return _copyCooklist(cooklist)
            ..title = event.cooklist.title
            ..icon = IconEntity(key: event.cooklist.icon.key)
            ..description = event.cooklist.description
            ..notes = event.cooklist.notes
            ..servings = event.cooklist.servings
            ..type = event.cooklist.type
            ..labels = List.of(event.cooklist.labels)
            ..dateTime = event.cooklist.dateTime;
        }).toList();
      });
    });
    on<CookStepAdded>((event, emit) async {
      await _updateCooklists(emit, (cooklists) {
        _findCooklist(cooklists, event.cooklistId).addNewStep(event.afterIndex);
        return cooklists;
      });
    });
    on<CookStepSaved>((event, emit) async {
      await _updateCooklists(emit, (cooklists) {
        final saved = _findCooklist(
          cooklists,
          event.cooklistId,
        ).cookSteps[event.index];
        saved.updateWithStep(event.step);
        saved.state = event.step.state;
        return cooklists;
      });
    });
    on<CookStepDeleted>((event, emit) async {
      await _updateCooklists(emit, (cooklists) {
        _findCooklist(
          cooklists,
          event.cooklistId,
        ).cookSteps.removeAt(event.index);
        return cooklists;
      });
    });
    on<CookStepReordered>((event, emit) async {
      await _updateCooklists(emit, (cooklists) {
        final steps = _findCooklist(cooklists, event.cooklistId).cookSteps;
        final step = steps.removeAt(event.oldIndex);
        steps.insert(event.newIndex, step);
        return cooklists;
      });
    });
    on<CookStepStateChanged>((event, emit) async {
      await _updateCooklists(emit, (cooklists) {
        _findCooklist(cooklists, event.cooklistId)
                .cookSteps[event.index]
                .state =
            event.isChecked;
        return cooklists;
      });
    });
    on<CookStepsUnchecked>((event, emit) async {
      await _updateCooklists(emit, (cooklists) {
        for (final step in _findCooklist(
          cooklists,
          event.cooklistId,
        ).cookSteps) {
          step.state = false;
        }
        return cooklists;
      });
    });
  }

  Future<void> _loadCooklists(
    CooklistsLoadRequested event,
    Emitter<CooklistsState> emit,
  ) async {
    try {
      emit(CooklistsLoadSuccess(await repository.loadCooklists()));
    } catch (_) {
      emit(CooklistsLoadFailure());
    }
  }

  Future<void> _updateCooklists(
    Emitter<CooklistsState> emit,
    List<CookList> Function(List<CookList>) update,
  ) async {
    final current = state;
    if (current is! CooklistsLoadSuccess) return;

    final cooklists = current.cooklists.map(_copyCooklist).toList();
    try {
      final updated = update(cooklists);
      await repository.saveCooklists(updated);
      emit(CooklistsLoadSuccess(updated));
    } catch (_) {
      emit(current);
    }
  }

  CookList _findCooklist(List<CookList> cooklists, String id) {
    return cooklists.firstWhere((cooklist) => cooklist.uuid == id);
  }

  CookList _copyCooklist(CookList cooklist) {
    return CookList.fromJson(cooklist.toJson());
  }
}
