import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todos_bloc.dart';
import '../bloc/todos_events.dart';
import '../bloc/todos_states.dart';
import '../datamodel/todo_models.dart';

import 'todo_addedit_screen.dart';

import '../../service-transverse/datamodel/transverse_thisapp_localization.dart';

class DetailsScreen extends StatelessWidget {
  final ToDoActionModel initialTodo;

  const DetailsScreen({super.key, required ToDoActionModel todo})
    : initialTodo = todo;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        final todo = state is TodosLoadCompleted
            ? (state as TodosLoadCompleted).todos
                      .where((item) => item.id == initialTodo.id)
                      .firstOrNull ??
                  initialTodo
            : initialTodo;
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
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        todo.title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    Checkbox(
                      value: todo.state,
                      onChanged: (_) {
                        context.read<TodosBloc>().add(
                          TodoUpdated(todo.copyWith(state: !todo.state)),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Points à traiter',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: const Color(0xFFF2F2F2),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(18),
                        child: Text(
                          todo.description.isEmpty
                              ? 'Aucun contenu pour cette todo.'
                              : todo.description,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: const Color(0xFF303030)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.delete_outline_rounded),
                      label: const Text('Supprimer'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.error,
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                      onPressed: () async {
                        final shouldDelete = await showDialog<bool>(
                          context: context,
                          builder: (dialogContext) => AlertDialog(
                            title: const Text('Supprimer la todo ?'),
                            content: Text(
                              'La todo « ${todo.title} » sera définitivement supprimée.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(dialogContext, false),
                                child: const Text('Annuler'),
                              ),
                              FilledButton(
                                style: FilledButton.styleFrom(
                                  backgroundColor: Theme.of(dialogContext)
                                      .colorScheme
                                      .error,
                                  foregroundColor: Theme.of(dialogContext)
                                      .colorScheme
                                      .onError,
                                ),
                                onPressed: () =>
                                    Navigator.pop(dialogContext, true),
                                child: const Text('Supprimer'),
                              ),
                            ],
                          ),
                        );

                        if (shouldDelete == true && context.mounted) {
                          context.read<TodosBloc>().add(TodoDeleted(todo));
                          Navigator.pop(context, todo);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text('Modifier'),
                      onPressed: () {
                        final todosBloc = context.read<TodosBloc>();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => AddEditScreen(
                              onSave: (task, note) {
                                todosBloc.add(
                                  TodoUpdated(
                                    todo.copyWith(
                                      title: task,
                                      description: note,
                                    ),
                                  ),
                                );
                              },
                              isEditing: true,
                              todo: todo,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
