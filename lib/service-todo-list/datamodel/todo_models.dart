import 'package:equatable/equatable.dart';

import 'todo_entity.dart';

import 'package:uuid/uuid.dart';

enum VisibilityFilter { all, active, completed }

class ToDoActionModel extends Equatable {
  final bool state;
  final String id;
  final String description;
  final String title;

  ToDoActionModel(
    this.title, {
    this.state = false,
    String? description,
    String? id,
  }) : description = description ?? '',
       id = id ?? const Uuid().v4();

  ToDoActionModel copyWith({
    bool? state,
    String? id,
    String? description,
    String? title,
  }) {
    return ToDoActionModel(
      title ?? this.title,
      state: state ?? this.state,
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [state, id, description, title];

  @override
  String toString() {
    return 'Todo { complete: $state, task: $title, note: $description, id: $id }';
  }

  TodoEntity toEntity() {
    return TodoEntity(state, id, description, title);
  }

  static ToDoActionModel fromEntity(TodoEntity entity) {
    return ToDoActionModel(
      entity.title,
      state: entity.state,
      description: entity.description,
      id: entity.id.isEmpty ? const Uuid().v4() : entity.id,
    );
  }
}
