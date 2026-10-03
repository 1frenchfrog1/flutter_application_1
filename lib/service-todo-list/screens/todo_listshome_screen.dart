import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/device_connectivity_well.dart';
import '../datamodel/todo_models.dart';
import '../bloc/todos_well.dart';

import '../bloc/todo_filtered_bloc.dart';
import '../bloc/todos_states.dart';
import 'todo_addedit_screen.dart';

import '../widgets/todo_filteredlistview_widget.dart';

import '../bloc/todo_apptab_states.dart';
import '../bloc/todo_apptab_events.dart';
import '../bloc/todo_apptab_bloc.dart';
import 'todo_tools_screen.dart';

import '../../service-transverse/datamodel/transverse_thisapp_localization.dart';

class HomeToDoList extends StatelessWidget {
  static const String routeName = "/HomeToDoList";

  const HomeToDoList({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<ToDoTabBloc>(
          create: (context) => ToDoTabBloc(
            //ToDoAppTab: BlocProvider.of<TodosBloc>(context),
          ),
        ),
        BlocProvider<FilteredTodosBloc>(
          create: (context) => FilteredTodosBloc(
            todosBloc: BlocProvider.of<TodosBloc>(context),
            toDoTabBloc: BlocProvider.of<ToDoTabBloc>(context),
          ),
        ),
        BlocProvider<ToDoConnectivityBloc>(
          create: (_) => ToDoConnectivityBloc(),
        ),
      ],
      child: HomeToDoBody(),
    );
  }
}

class HomeToDoBody extends StatelessWidget {
  const HomeToDoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ToDoTabBloc, ToDoAppTab, ToDoAppTab>(
      selector: (tab) => tab,
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ThisAppLocalizations.of(context).my_To_Do_ListLocalText,
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                BlocSelector<TodosBloc, TodosState, int>(
                  selector: (state) => state is TodosLoadCompleted
                      ? state.todos.where((todo) => !todo.state).length
                      : 0,
                  builder: (context, count) {
                    return Text(
                      '$count tâche${count == 1 ? '' : 's'} ouverte${count == 1 ? '' : 's'}',
                      style: Theme.of(context).textTheme.bodySmall,
                    );
                  },
                ),
              ],
            ),
            actions: <Widget>[
              IconButton(
                tooltip: 'Outils',
                icon: const Icon(Icons.tune_rounded),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<TodosBloc>(),
                        child: const ToDoToolsScreen(),
                      ),
                    ),
                  );
                },
              ),
              BlocSelector<ToDoConnectivityBloc, ToDoConnectivityState, bool>(
                selector: (state) => state is ToDoIsConnected,
                builder: (context, isConnected) {
                  if (isConnected) {
                    return const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.wifi_outlined, color: Colors.green),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.wifi_off, color: Colors.grey),
                    );
                  }
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                  child: SegmentedButton<ToDoAppTab>(
                    segments: const [
                      ButtonSegment(
                        value: ToDoAppTab.allToDos,
                        label: Text('Toutes'),
                        icon: Icon(Icons.list_alt_rounded),
                      ),
                      ButtonSegment(
                        value: ToDoAppTab.openToDos,
                        label: Text('À faire'),
                        icon: Icon(Icons.radio_button_unchecked),
                      ),
                    ],
                    selected: {
                      activeTab == ToDoAppTab.openToDos
                          ? ToDoAppTab.openToDos
                          : ToDoAppTab.allToDos,
                    },
                    onSelectionChanged: (selection) {
                      context.read<ToDoTabBloc>().add(
                        ToDoTabUpdated(selection.first),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color?>((
                        states,
                      ) {
                        return states.contains(WidgetState.selected)
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white;
                      }),
                      foregroundColor: WidgetStateProperty.resolveWith<Color?>((
                        states,
                      ) {
                        return states.contains(WidgetState.selected)
                            ? Colors.black
                            : const Color(0xFF303030);
                      }),
                      side: WidgetStateProperty.all(
                        const BorderSide(color: Color(0xFFBDBDBD)),
                      ),
                    ),
                    expandedInsets: EdgeInsets.zero,
                  ),
                ),
                const Expanded(child: FilteredTodos()),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: BlocSelector<TodosBloc, TodosState, bool>(
                selector: (state) => state is TodosLoadCompleted,
                builder: (context, isReady) {
                  return FilledButton.icon(
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Ajouter'),
                    onPressed: isReady
                        ? () {
                            final todosBloc = context.read<TodosBloc>();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) {
                                  return AddEditScreen(
                                    isEditing: false,
                                    onSave: (title, description) {
                                      todosBloc.add(
                                        TodoAdded(
                                          ToDoActionModel(
                                            title,
                                            description: description,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          }
                        : null,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
