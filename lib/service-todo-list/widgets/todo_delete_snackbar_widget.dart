import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../datamodel/todo_models.dart';

class DeleteTodoSnackBar extends SnackBar {
  final AppLocalizations thisAppLocalizations;

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
                 thisAppLocalizations.todoDeleted,
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
           label: thisAppLocalizations.undo,
           onPressed: onUndo,
         ),
       );
}
