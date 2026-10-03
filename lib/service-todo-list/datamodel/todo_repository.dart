import 'dart:core';

import 'todo_entity.dart';

abstract class TodosRepository {
  Future<List<TodoEntity>> loadTodos();

  Future<void> saveTodos(List<TodoEntity> todos);
}
