class TodoEntity {
  final bool state;
  final String id;
  final String description;
  final String title;

  TodoEntity(this.state, this.id, this.description, this.title);

  @override
  int get hashCode =>
      state.hashCode ^ title.hashCode ^ description.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoEntity &&
          runtimeType == other.runtimeType &&
          state == other.state &&
          title == other.title &&
          description == other.description &&
          id == other.id;

  Map<String, Object> toJson() {
    return {
      'todoState': state,
      'todoId': id,
      'todoDescription': description,
      'todoTitle': title,
    };
  }

  @override
  String toString() {
    return 'TodoEntity{state: $state, title: $title, description: $description, id: $id}';
  }

  static TodoEntity fromJson(Map<String, dynamic> json) {
    return TodoEntity(
      json['todoState'] as bool? ?? false,
      json['todoId'] as String? ?? '',
      json['todoDescription'] as String? ?? '',
      json['todoTitle'] as String? ?? '',
    );
  }
}
