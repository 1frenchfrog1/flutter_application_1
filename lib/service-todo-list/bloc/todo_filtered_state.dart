import 'package:equatable/equatable.dart';

import '../datamodel/todo_models.dart';

abstract class FilteredTodosState extends Equatable {
  const FilteredTodosState();

  @override
  List<Object> get props => [];
}

class FilteredTodosLoadInProgress extends FilteredTodosState {}

class FilteredTodosLoadCompleted extends FilteredTodosState {
  final List<ToDoActionModel> filteredTodos;
  final VisibilityFilter activeFilter;

  const FilteredTodosLoadCompleted(this.filteredTodos, this.activeFilter);

  @override
  List<Object> get props => [filteredTodos, activeFilter];

  @override
  String toString() {
    return 'FilteredTodosLoadSuccess { filteredTodos: $filteredTodos, activeFilter: $activeFilter }';
  }
}
