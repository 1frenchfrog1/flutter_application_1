import 'package:equatable/equatable.dart';

import '../datamodel/todo_models.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

class TodosLoadInProgress extends TodosState {}

class TodosLoadCompleted extends TodosState {
  final List<ToDoActionModel> todos;

  const TodosLoadCompleted([this.todos = const []]);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodosLoadSuccess { todos: $todos }';
}

class TodosLoadFailure extends TodosState {}
