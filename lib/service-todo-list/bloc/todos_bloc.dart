import 'package:bloc/bloc.dart';

import '../datamodel/todo_models.dart';
import 'todos_states.dart';
import 'todos_events.dart';
import '../datamodel/todo_repository.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepository todosRepository;

  TodosBloc({required this.todosRepository}) : super(TodosLoadInProgress()) {
    on<TodosLoadedSuccessfully>((event, emit) async {
      try {
        final todos = await todosRepository.loadTodos();
        emit(
          TodosLoadCompleted(todos.map(ToDoActionModel.fromEntity).toList()),
        );
      } catch (_) {
        emit(TodosLoadFailure());
      }
    });
    on<TodoAdded>(_addTodo);
    on<TodoUpdated>(_updateTodo);
    on<TodoDeleted>(_deleteTodo);
    on<ToggleAll>(_toggleAll);
    on<ClearCompleted>(_clearCompleted);
  }

  Future<void> _addTodo(TodoAdded event, Emitter<TodosState> emit) async {
    if (state is TodosLoadCompleted) {
      final todos = List<ToDoActionModel>.from(
        (state as TodosLoadCompleted).todos,
      )..add(event.todo);
      await _saveTodos(todos);
      emit(TodosLoadCompleted(todos));
    }
  }

  Future<void> _updateTodo(TodoUpdated event, Emitter<TodosState> emit) async {
    if (state is TodosLoadCompleted) {
      final todos = (state as TodosLoadCompleted).todos
          .map((todo) => todo.id == event.todo.id ? event.todo : todo)
          .toList();
      await _saveTodos(todos);
      emit(TodosLoadCompleted(todos));
    }
  }

  Future<void> _deleteTodo(TodoDeleted event, Emitter<TodosState> emit) async {
    if (state is TodosLoadCompleted) {
      final todos = (state as TodosLoadCompleted).todos
          .where((todo) => todo.id != event.todo.id)
          .toList();
      await _saveTodos(todos);
      emit(TodosLoadCompleted(todos));
    }
  }

  Future<void> _toggleAll(ToggleAll event, Emitter<TodosState> emit) async {
    if (state is TodosLoadCompleted) {
      final current = (state as TodosLoadCompleted).todos;
      final complete =
          current.isNotEmpty && current.every((todo) => todo.state);
      final todos = current
          .map((todo) => todo.copyWith(state: !complete))
          .toList();
      await _saveTodos(todos);
      emit(TodosLoadCompleted(todos));
    }
  }

  Future<void> _clearCompleted(
    ClearCompleted event,
    Emitter<TodosState> emit,
  ) async {
    if (state is TodosLoadCompleted) {
      final todos = (state as TodosLoadCompleted).todos
          .where((todo) => !todo.state)
          .toList();
      await _saveTodos(todos);
      emit(TodosLoadCompleted(todos));
    }
  }

  Future<void> _saveTodos(List<ToDoActionModel> todos) {
    return todosRepository.saveTodos(
      todos.map((todo) => todo.toEntity()).toList(),
    );
  }
}
