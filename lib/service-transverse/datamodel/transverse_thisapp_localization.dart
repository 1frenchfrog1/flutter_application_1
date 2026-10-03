import 'package:flutter/widgets.dart';

class ThisAppLocalizations {
  const ThisAppLocalizations._();

  static ThisAppLocalizations of(BuildContext context) =>
      const ThisAppLocalizations._();

  String get my_To_Do_ListLocalText => 'Todo list';
  String get edit_ToDoLocalText => 'Edit todo';
  String get add_new_ToDoLocalText => 'Add todo';
  String get enter_new_ToDoLocalText => 'Title';
  String get enter_descriptionLocalText => 'Description';
  String get toDo_detailsLocalText => 'Todo details';
  String get delete_Completed_ToDosLocalText => 'Delete completed todos';
  String get toDo_deletedLocalText => 'Todo deleted';
  String get undoLocalText => 'Undo';
  String get toolsLocalText => 'Tools';
  String get allLocalText => 'All';
  String get left_To_DoLocalText => 'Open';
}
