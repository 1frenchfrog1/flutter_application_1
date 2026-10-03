import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'service-checklist/bloc/checklists_bloc.dart';
import 'service-checklist/bloc/checklists_event.dart';
import 'service-checklist/datamodel/checklists_repository.dart';
import 'service-checklist/screens/HomeCheckList.dart';
import 'service-todo-list/bloc/todos_bloc.dart';
import 'service-todo-list/bloc/todos_events.dart';
import 'service-todo-list/datamodel/todo_file_storage.dart';
import 'service-todo-list/screens/todo_listshome_screen.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    const background = Color(0xFF303030);
    const surface = Color(0xFF3B3B3B);
    const warmText = Color(0xFFFFD7A8);
    const orange = Color(0xFFFF8C00);
    const buttonGray = Color(0xFFE6E6E6);
    const buttonGrayText = Color(0xFF303030);
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: orange,
          brightness: Brightness.dark,
        ).copyWith(
          primary: orange,
          onPrimary: Colors.black,
          secondary: orange,
          onSecondary: Colors.black,
          surface: surface,
          onSurface: warmText,
        );

    return BlocProvider(
      create: (_) =>
          ChecklistsBloc(repository: FileChecklistsRepository())
            ..add(ChecklistsLoadRequested()),
      child: MaterialApp(
        title: 'Todo List',
        theme: ThemeData(
          colorScheme: colorScheme,
          useMaterial3: true,
          scaffoldBackgroundColor: background,
          textTheme: ThemeData.dark().textTheme.apply(
            bodyColor: warmText,
            displayColor: warmText,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: background,
            foregroundColor: warmText,
            surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 0,
          ),
          cardTheme: CardThemeData(
            margin: EdgeInsets.zero,
            elevation: 0,
            color: surface,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(18)),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(color: Color(0xFFB8B8B8)),
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              backgroundColor: orange,
              foregroundColor: Colors.black,
              disabledBackgroundColor: buttonGray,
              disabledForegroundColor: buttonGrayText,
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: orange,
            foregroundColor: Colors.black,
            disabledElevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonGray,
              foregroundColor: buttonGrayText,
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: orange,
              side: const BorderSide(color: orange),
            ),
          ),
        ),
        home: FutureBuilder<Directory>(
          future: getApplicationDocumentsDirectory(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            return TodoLandingPage(directory: snapshot.data!);
          },
        ),
      ),
    );
  }
}

class TodoLandingPage extends StatelessWidget {
  final Directory directory;

  const TodoLandingPage({super.key, required this.directory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accueil')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton.icon(
              icon: const Icon(Icons.checklist),
              label: const Text('Ouvrir ma todo-list'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => TodosBloc(
                        todosRepository: ToDoFileStorage(
                          'todos',
                          () async => directory,
                        ),
                      )..add(TodosLoadedSuccessfully()),
                      child: const HomeToDoList(),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              icon: const Icon(Icons.fact_check),
              label: const Text('Ouvrir mes checklists'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const HomeCheckList()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
