import 'package:equatable/equatable.dart';

import 'todo_apptab_states.dart';

abstract class ToDoTabEvent extends Equatable {
  const ToDoTabEvent();
}

class ToDoTabUpdated extends ToDoTabEvent {
  final ToDoAppTab tab;

  const ToDoTabUpdated(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'TabUpdated { tab: $tab }';
}
