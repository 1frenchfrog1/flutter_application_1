import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todos_bloc.dart';
import '../bloc/todos_events.dart';
import '../bloc/todo_filtered_state.dart';
import '../bloc/todo_filtered_bloc.dart';
import 'todo_dismissableItem_widget.dart';

import '../screens/todo_detail_screen.dart';
import 'todo_delete_snackbar_widget.dart';

import '../../service-transverse/datamodel/transverse_thisapp_localization.dart';

class FilteredTodos extends StatelessWidget {
  const FilteredTodos({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (context, state) {
        if (state is FilteredTodosLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FilteredTodosLoadCompleted) {
          final todos = state.filteredTodos;
          if (todos.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.task_alt_rounded,
                      size: 56,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Tout est en ordre',
                      style: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Ajoutez une tâche pour commencer.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 104),
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              final todo = todos[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TodoItem(
                  todo: todo,
                  onDismissed: (direction) {
                    BlocProvider.of<TodosBloc>(context).add(TodoDeleted(todo));
                    ScaffoldMessenger.of(context).showSnackBar(
                      DeleteTodoSnackBar(
                        todo: todo,
                        onUndo: () =>
                            BlocProvider.of<TodosBloc>(context)
                                .add(TodoAdded(todo)),
                        onOk: () =>
                            ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                        thisAppLocalizations: ThisAppLocalizations.of(context),
                      ),
                    );
                  },
                  onTap: () async {
                    final todosBloc = context.read<TodosBloc>();
                    final removedTodo = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return BlocProvider.value(
                            value: todosBloc,
                            child: DetailsScreen(todo: todo),
                          );
                        },
                      ),
                    );
                    if (removedTodo != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        DeleteTodoSnackBar(
                          todo: todo,
                          onUndo: () =>
                              BlocProvider.of<TodosBloc>(context)
                                  .add(TodoAdded(todo)),
                          onOk: () =>
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar(),
                          thisAppLocalizations: ThisAppLocalizations.of(
                            context,
                          ),
                        ),
                      );
                    }
                  },
                  onCheckboxChanged: (_) {
                    BlocProvider.of<TodosBloc>(context)
                        .add(TodoUpdated(todo.copyWith(state: !todo.state)));
                  },
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
