import 'dart:async';

import 'package:bloc/bloc.dart';

import 'todos_bloc.dart';
import 'todos_states.dart';
import 'todo_filtered_state.dart';
import 'todo_filtered_event.dart';
import '../datamodel/todo_models.dart';
import 'todo_apptab_states.dart';
import 'todo_apptab_bloc.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final TodosBloc todosBloc;
  final ToDoTabBloc toDoTabBloc;
  StreamSubscription<TodosState>? _todosSubscription;
  StreamSubscription<ToDoAppTab>? _tabSubscription;

  FilteredTodosBloc({required this.todosBloc, required this.toDoTabBloc})
    : super(
        todosBloc.state is TodosLoadCompleted
            ? FilteredTodosLoadCompleted(
                (todosBloc.state as TodosLoadCompleted).todos,
                VisibilityFilter.all,
              )
            : FilteredTodosLoadInProgress(),
      ) {
    on<FilterUpdated>((event, emit) => _emitFiltered(emit, event.filter));
    on<FilteredTodosUpdated>(
      (event, emit) => _emitFiltered(
        emit,
        state is FilteredTodosLoadCompleted
            ? (state as FilteredTodosLoadCompleted).activeFilter
            : VisibilityFilter.all,
      ),
    );
    _todosSubscription = todosBloc.stream.listen((state) {
      if (!isClosed && state is TodosLoadCompleted) {
        add(FilteredTodosUpdated(state.todos));
      }
    });
    _tabSubscription = toDoTabBloc.stream.listen((tab) {
      if (isClosed) return;
      if (tab == ToDoAppTab.allToDos) {
        add(FilterUpdated(VisibilityFilter.all));
      }
      if (tab == ToDoAppTab.openToDos) {
        add(FilterUpdated(VisibilityFilter.active));
      }
    });
  }

  void _emitFiltered(
    Emitter<FilteredTodosState> emit,
    VisibilityFilter filter,
  ) {
    if (todosBloc.state is TodosLoadCompleted) {
      emit(
        FilteredTodosLoadCompleted(
          _mapTodosToFilteredTodos(
            (todosBloc.state as TodosLoadCompleted).todos,
            filter,
          ),
          filter,
        ),
      );
    }
  }

  List<ToDoActionModel> _mapTodosToFilteredTodos(
    List<ToDoActionModel> todos,
    VisibilityFilter filter,
  ) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !todo.state;
      } else {
        return todo.state;
      }
    }).toList();
  }

  @override
  Future<void> close() async {
    await _todosSubscription?.cancel();
    await _tabSubscription?.cancel();
    return super.close();
  }
}
