import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todos_bloc.dart';
import '../bloc/todos_events.dart';

import '../../service-transverse/datamodel/transverse_thisapp_localization.dart';

class ToDoToolsScreen extends StatelessWidget {
  const ToDoToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ThisAppLocalizations.of(context).toDo_detailsLocalText,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Column(
          children: [
            FilledButton.icon(
              icon: const Icon(Icons.cleaning_services_outlined),
              onPressed: () {
                BlocProvider.of<TodosBloc>(context).add(ClearCompleted());
              },
              label: Text(
                ThisAppLocalizations.of(context)
                    .delete_Completed_ToDosLocalText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
