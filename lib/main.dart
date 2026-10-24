import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/generated/app_localizations.dart';
import 'l10n/localization_context.dart';
import 'service-checklist/bloc/checklists_bloc.dart';
import 'service-checklist/bloc/checklists_event.dart';
import 'service-checklist/datamodel/checklists_repository.dart';
import 'service-checklist/l10n/generated/checklist_localizations.dart';
import 'service-checklist/screens/HomeCheckList.dart';
import 'service-cooklist/bloc/cooklists_bloc.dart';
import 'service-cooklist/bloc/cooklists_event.dart';
import 'service-cooklist/datamodel/cooklists_repository.dart';
import 'service-cooklist/l10n/cook_localization_context.dart';
import 'service-cooklist/l10n/generated/cook_localizations.dart';
import 'service-cooklist/screens/cook_home_screen.dart';
import 'service-todo-list/bloc/todos_bloc.dart';
import 'service-todo-list/bloc/todos_events.dart';
import 'service-todo-list/datamodel/todo_file_storage.dart';
import 'service-todo-list/screens/todo_listshome_screen.dart';
import 'features/icons/di/icon_injection.dart';

void main() {
  configureIconDependencies();
  runApp(const TodoApp());
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  static const _languagePreferenceKey = 'app_language_code';
  static const _supportedLocales = [
    Locale('fr'),
    Locale('en'),
    Locale('es'),
    Locale('de'),
    Locale('it'),
  ];

  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();
  Locale _locale = const Locale('fr');
  late Future<void> _localePreference;
  late Future<Directory> _documentsDirectory;

  @override
  void initState() {
    super.initState();
    _localePreference = _loadLocalePreference();
    _documentsDirectory = getApplicationDocumentsDirectory();
  }

  Future<void> _loadLocalePreference() async {
    final languageCode = await _preferences.getString(_languagePreferenceKey);
    if (languageCode == null) return;

    if (!_supportedLocales.any(
      (supportedLocale) => supportedLocale.languageCode == languageCode,
    )) {
      throw FormatException('Unsupported saved language: $languageCode');
    }

    if (mounted) {
      setState(() => _locale = Locale(languageCode));
    }
  }

  void _retryLocalePreferenceLoad() {
    setState(() => _localePreference = _loadLocalePreference());
  }

  void _continueWithDefaultLanguage() {
    setState(() => _localePreference = Future<void>.value());
  }

  Future<void> _changeLocale(BuildContext context, Locale locale) async {
    setState(() => _locale = locale);
    try {
      await _preferences.setString(_languagePreferenceKey, locale.languageCode);
    } catch (error) {
      debugPrint('Unable to save the selected application language: $error');
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.languageSaveError)));
    }
  }

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

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              ChecklistsBloc(repository: FileChecklistsRepository())
                ..add(ChecklistsLoadRequested()),
        ),
        BlocProvider(
          create: (_) =>
              CooklistsBloc(repository: FileCooklistsRepository())
                ..add(CooklistsLoadRequested()),
        ),
      ],
      child: MaterialApp(
        onGenerateTitle: (context) => context.l10n.appTitle,
        locale: _locale,
        supportedLocales: _supportedLocales,
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          ChecklistLocalizations.delegate,
          CookLocalizations.delegate,
        ],
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
        home: FutureBuilder<void>(
          future: _localePreference,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                appBar: AppBar(title: Text(context.l10n.home)),
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.l10n.languageLoadError,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: _retryLocalePreferenceLoad,
                          child: Text(context.l10n.retry),
                        ),
                        TextButton(
                          onPressed: _continueWithDefaultLanguage,
                          child: Text(context.l10n.continueInFrench),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            if (snapshot.connectionState != ConnectionState.done) {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 12),
                      Text(context.l10n.loadingLanguage),
                    ],
                  ),
                ),
              );
            }
            return FutureBuilder<Directory>(
              future: _documentsDirectory,
              builder: (context, directorySnapshot) {
                if (!directorySnapshot.hasData) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
                return TodoLandingPage(
                  directory: directorySnapshot.data!,
                  locale: _locale,
                  onLocaleSelected: (locale) => _changeLocale(context, locale),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class TodoLandingPage extends StatelessWidget {
  final Directory directory;
  final Locale locale;
  final ValueChanged<Locale>? onLocaleSelected;

  const TodoLandingPage({
    super.key,
    required this.directory,
    this.locale = const Locale('fr'),
    this.onLocaleSelected,
  });

  @override
  Widget build(BuildContext context) {
    final tileSize = MediaQuery.sizeOf(context).width / 3;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.home),
        actions: [
          if (onLocaleSelected != null)
            PopupMenuButton<Locale>(
              tooltip: context.l10n.changeLanguage,
              icon: const Icon(Icons.translate),
              onSelected: onLocaleSelected,
              itemBuilder: (context) => [
                _languageMenuItem(
                  const Locale('fr'),
                  locale,
                  context.l10n.languageFrench,
                ),
                _languageMenuItem(
                  const Locale('en'),
                  locale,
                  context.l10n.languageEnglish,
                ),
                _languageMenuItem(
                  const Locale('es'),
                  locale,
                  context.l10n.languageSpanish,
                ),
                _languageMenuItem(
                  const Locale('de'),
                  locale,
                  context.l10n.languageGerman,
                ),
                _languageMenuItem(
                  const Locale('it'),
                  locale,
                  context.l10n.languageItalian,
                ),
              ],
            ),
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: tileSize,
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 1,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              _HomeActionTile(
                icon: Icons.checklist,
                title: context.l10n.openTodoList,
                onTap: () {
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
              _HomeActionTile(
                icon: Icons.fact_check,
                title: context.l10n.openChecklists,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const HomeCheckList()),
                  );
                },
              ),
              _HomeActionTile(
                icon: Icons.restaurant_menu,
                title: context.cookL10n.myCooklists,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const HomeCookList()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem<Locale> _languageMenuItem(
    Locale itemLocale,
    Locale selectedLocale,
    String label,
  ) {
    return PopupMenuItem(
      value: itemLocale,
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: itemLocale == selectedLocale
                ? const Icon(Icons.check, size: 18)
                : null,
          ),
          Text(label),
        ],
      ),
    );
  }
}

class _HomeActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _HomeActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
