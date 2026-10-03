import 'package:flutter/material.dart';

import '../datamodel/todo_models.dart';

import '../../service-transverse/datamodel/transverse_thisapp_localization.dart';

class DeleteTodoSnackBar extends SnackBar {
  final ThisAppLocalizations thisAppLocalizations;

  DeleteTodoSnackBar({
    super.key,
    required ToDoActionModel todo,
    required VoidCallback onUndo,
    required VoidCallback onOk,
    required this.thisAppLocalizations,
  }) : super(
         content: Row(
           children: [
             Expanded(
               child: Text(
                 thisAppLocalizations.toDo_deletedLocalText,
                 maxLines: 1,
                 overflow: TextOverflow.ellipsis,
               ),
             ),
             TextButton(
               onPressed: onOk,
               style: TextButton.styleFrom(foregroundColor: Colors.grey),
               child: const Text('OK'),
             ),
           ],
         ),
         duration: Duration(seconds: 2),
         action: SnackBarAction(
           label: thisAppLocalizations.undoLocalText,
           onPressed: onUndo,
         ),
       );
}
