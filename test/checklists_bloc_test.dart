import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/service-checklist/bloc/checklists_bloc.dart';
import 'package:flutter_application_1/service-checklist/bloc/checklists_event.dart';
import 'package:flutter_application_1/service-checklist/bloc/checklists_state.dart';
import 'package:flutter_application_1/service-checklist/datamodel/CheckListDataModel.dart';
import 'package:flutter_application_1/service-checklist/datamodel/checklists_repository.dart';
import 'package:flutter_application_1/service-checklist/datamodel/CheckListFileAccess.dart';
import 'package:flutter_application_1/service-checklist/screens/CheckPointListEditingPanel.dart';
import 'package:flutter_application_1/service-checklist/screens/CheckPointEditingPanel.dart';
import 'package:flutter_application_1/service-checklist/screens/ExpansionPanelListTabbedWidget.dart';
import 'package:flutter_application_1/service-checklist/screens/checkListEditingPanel.dart';
import 'package:flutter_application_1/service-checklist/screens/HomeCheckList.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/service-checklist/widgets/checklist_icon_picker.dart';
import 'package:flutter_application_1/features/icons/data/datasources/icon_local_data_source.dart';
import 'package:flutter_application_1/features/icons/di/icon_injection.dart';
import 'package:flutter_application_1/features/icons/domain/entities/icon_entity.dart';

void main() {
  setUpAll(configureIconDependencies);

  test('icon catalog prioritizes packing, travel, and food', () async {
    final icons = await IconLocalDataSourceImpl().fetchIcons();
    final labels = icons.map((icon) => icon.label).toSet();
    final officeIcons = icons.where((icon) => icon.category == 'Travail');

    expect(
      labels,
      containsAll([
        'T-shirt',
        'Veste',
        'Pantalon',
        'Pantalon court',
        'Short',
        'Chemise',
      ]),
    );
    expect(
      labels,
      containsAll(['Passeport', 'Gourde', 'Chargeur', 'Trousse de toilette']),
    );
    expect(labels, containsAll(['Petit-déjeuner', 'Déjeuner', 'Pizza', 'Riz']));
    expect(officeIcons, hasLength(4));
    expect(
      labels.where((label) => label.startsWith('Ancienne icône')),
      isEmpty,
    );
  });

  test(
    'checklist icons persist only their key and load legacy metadata',
    () async {
      final icons = await IconLocalDataSourceImpl().fetchIcons();
      for (final icon in icons) {
        final entity = icon.toEntity();
        expect(iconToJSONString(entity), {'key': icon.key}, reason: icon.label);
        expect(
          iconFromJSONString(iconToJSONString(entity)),
          IconEntity(key: icon.key),
          reason: icon.label,
        );
        expect(
          iconFromJSONString(icon.toJson()),
          IconEntity(key: icon.key),
          reason: 'Legacy metadata must still load for ${icon.label}.',
        );
      }
    },
  );

  test(
    'loads, mutates and persists checklists through the repository',
    () async {
      final repository = _MemoryChecklistsRepository();
      final bloc = ChecklistsBloc(repository: repository);
      addTearDown(bloc.close);

      final loaded = bloc.stream.firstWhere(
        (state) => state is ChecklistsLoadSuccess,
      );
      bloc.add(ChecklistsLoadRequested());
      await loaded;

      final created = bloc.stream.firstWhere(
        (state) => state is ChecklistsLoadSuccess,
      );
      bloc.add(ChecklistCreated());
      final state = await created as ChecklistsLoadSuccess;

      expect(state.checklists, hasLength(1));
      expect(repository.savedChecklists, hasLength(1));
      expect(state.checklists.single.checkListObjects, hasLength(1));
      expect(
        state.checklists.single.checkListObjects.single.description,
        isEmpty,
      );
      expect(state.checklists.single.checkListObjects.single.notes, isEmpty);

      final checklist = state.checklists.single;
      final changed = bloc.stream.firstWhere(
        (state) => state is ChecklistsLoadSuccess,
      );
      bloc.add(CheckpointStateChanged(checklist.uuid, 0, true));
      final updated = await changed as ChecklistsLoadSuccess;

      expect(updated.checklists.single.checkListObjects.single.state, isTrue);
      expect(
        repository.savedChecklists.single.checkListObjects.single.state,
        isTrue,
      );
    },
  );

  test('demo checklists use key-only icons from the catalog', () async {
    final catalog = await IconLocalDataSourceImpl().fetchIcons();
    final repository = _MemoryChecklistsRepository();
    final bloc = ChecklistsBloc(repository: repository);
    addTearDown(bloc.close);

    final loaded = bloc.stream.firstWhere(
      (state) => state is ChecklistsLoadSuccess,
    );
    bloc.add(ChecklistsLoadRequested());
    await loaded;

    final demoLoaded = bloc.stream.firstWhere(
      (state) => state is ChecklistsLoadSuccess,
    );
    bloc.add(ChecklistsDemoDataRequested());
    final state = await demoLoaded as ChecklistsLoadSuccess;

    expect(state.checklists, hasLength(3));
    for (final checklist in state.checklists) {
      final icon = checklist.icon;
      expect(catalog.any((candidate) => candidate.key == icon.key), isTrue);
      expect(iconToJSONString(icon), {'key': icon.key});

      for (final checkpoint in checklist.checkListObjects) {
        final checkpointIcon = checkpoint.icon;
        expect(
          catalog.any((candidate) => candidate.key == checkpointIcon.key),
          isTrue,
        );
        expect(iconToJSONString(checkpointIcon), {'key': checkpointIcon.key});
      }
    }
  });

  test('legacy font icons migrate to catalog keys when matched', () {
    final legacyIconKeys = {
      'material|MaterialIcons|e15b': 'essentiel-checklist',
    };
    final restored = iconFromJSONString({
      'codePoint': 0xe15b,
      'fontFamily': 'MaterialIcons',
      'fontPackage': null,
      'matchTextDirection': false,
    }, legacyIconKeys: legacyIconKeys);

    expect(restored, const IconEntity(key: 'essentiel-checklist'));
    expect(iconToJSONString(restored), {'key': 'essentiel-checklist'});
  });

  test(
    'file storage migrates legacy icons and saves only catalog keys',
    () async {
      final storage = _MemoryAppCheckListStorage(
        jsonEncode({
          'allCheckLists': [
            {
              'checkListTitle': 'Legacy checklist',
              'checkListIcon': {
                'codePoint': 0xe15b,
                'fontFamily': 'MaterialIcons',
                'fontPackage': null,
                'matchTextDirection': false,
              },
              'checkListObjects': [
                {
                  'actionTitle': 'Legacy checkpoint',
                  'actionIcon': {
                    'codePoint': 0xe15b,
                    'fontFamily': 'MaterialIcons',
                    'fontPackage': null,
                    'matchTextDirection': false,
                  },
                },
              ],
            },
          ],
        }),
      );
      final repository = FileChecklistsRepository(storage: storage);

      final checklists = await repository.loadChecklists();
      expect(checklists.single.icon.key, 'essentiel-checklist');
      expect(
        checklists.single.checkListObjects.single.icon.key,
        'essentiel-checklist',
      );

      await repository.saveChecklists(checklists);
      final saved = jsonDecode(storage.savedContents!) as Map<String, dynamic>;
      final savedChecklist =
          (saved['allCheckLists'] as List).single as Map<String, dynamic>;
      expect(savedChecklist['checkListIcon'], {'key': 'essentiel-checklist'});
      final savedAction =
          (savedChecklist['checkListObjects'] as List).single
              as Map<String, dynamic>;
      expect(savedAction['actionIcon'], {'key': 'essentiel-checklist'});
    },
  );

  test(
    'unmatched legacy icons fail explicitly instead of using a fallback',
    () {
      expect(
        () => iconFromJSONString({
          'codePoint': 0xdead,
          'fontFamily': 'UnknownIcons',
        }),
        throwsFormatException,
      );
    },
  );

  test('reorders checkpoints using the supplied destination index', () async {
    final checklist = CheckList(
      'Packing',
      const IconEntity(key: 'essentiel-checklist'),
      '',
      '',
    );
    checklist.checkListObjects = [
      ActionObject(title: 'First'),
      ActionObject(title: 'Second'),
      ActionObject(title: 'Third'),
    ];
    final repository = _MemoryChecklistsRepository()
      ..savedChecklists = [checklist];
    final bloc = ChecklistsBloc(repository: repository);
    addTearDown(bloc.close);

    final loaded = bloc.stream.firstWhere(
      (state) => state is ChecklistsLoadSuccess,
    );
    bloc.add(ChecklistsLoadRequested());
    await loaded;

    final reordered = bloc.stream.firstWhere(
      (state) => state is ChecklistsLoadSuccess,
    );
    bloc.add(CheckpointReordered(checklist.uuid, 0, 2));
    final state = await reordered as ChecklistsLoadSuccess;

    expect(state.checklists.single.checkListObjects.map((item) => item.title), [
      'Second',
      'Third',
      'First',
    ]);
  });

  test('saving checklist fields keeps newer checkpoint changes', () async {
    final checklist = CheckList(
      'Packing',
      const IconEntity(key: 'essentiel-checklist'),
      '',
      '',
    );
    checklist.checkListObjects = [ActionObject(title: 'Passport')];
    final repository = _MemoryChecklistsRepository()
      ..savedChecklists = [checklist];
    final bloc = ChecklistsBloc(repository: repository);
    addTearDown(bloc.close);

    final loaded = bloc.stream.firstWhere(
      (state) => state is ChecklistsLoadSuccess,
    );
    bloc.add(ChecklistsLoadRequested());
    final initial = await loaded as ChecklistsLoadSuccess;
    final staleDraft = CheckList.fromJson(initial.checklists.single.toJson())
      ..title = 'Travel';

    final checked = bloc.stream.firstWhere(
      (state) => state is ChecklistsLoadSuccess,
    );
    bloc.add(CheckpointStateChanged(checklist.uuid, 0, true));
    await checked;

    final saved = bloc.stream.firstWhere(
      (state) => state is ChecklistsLoadSuccess,
    );
    bloc.add(ChecklistSaved(staleDraft));
    final state = await saved as ChecklistsLoadSuccess;

    expect(state.checklists.single.title, 'Travel');
    expect(state.checklists.single.checkListObjects.single.state, isTrue);
  });

  testWidgets('detail route inherits the app-scoped checklist BLoC', (
    tester,
  ) async {
    final checklist = CheckList(
      'Route test',
      const IconEntity(key: 'essentiel-checklist'),
      '',
      '',
    );
    checklist.checkListObjects = [ActionObject(title: 'Checkpoint')];
    final repository = _MemoryChecklistsRepository()
      ..savedChecklists = [checklist];

    await tester.pumpWidget(
      BlocProvider(
        create: (_) =>
            ChecklistsBloc(repository: repository)
              ..add(ChecklistsLoadRequested()),
        child: const MaterialApp(home: HomeCheckList()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Route test'));
    await tester.pumpAndSettle();

    expect(find.text('Toutes'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('adding a checkpoint renders without an icon type error', (
    tester,
  ) async {
    final checklist = CheckList(
      'Add test',
      const IconEntity(key: 'essentiel-checklist'),
      '',
      '',
    );
    final repository = _MemoryChecklistsRepository()
      ..savedChecklists = [checklist];

    await tester.pumpWidget(
      BlocProvider(
        create: (_) =>
            ChecklistsBloc(repository: repository)
              ..add(ChecklistsLoadRequested()),
        child: MaterialApp(
          home: CheckPointListEditingPanel(widgetCheckListObject: checklist),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Ajouter un point de contrôle'));
    await tester.pumpAndSettle();

    expect(find.text('New checkpoint'), findsOneWidget);
    expect(
      repository.savedChecklists.single.checkListObjects.single.description,
      isEmpty,
    );
    expect(
      repository.savedChecklists.single.checkListObjects.single.notes,
      isEmpty,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('checkpoints without details cannot be expanded', (tester) async {
    final checklist =
        CheckList(
            'Expansion test',
            const IconEntity(key: 'essentiel-checklist'),
            '',
            '',
          )
          ..checkListObjects = [
            ActionObject(title: 'Empty checkpoint'),
            ActionObject(
              title: 'Checkpoint with notes',
              notes: 'Bring a charger',
            ),
          ];
    final repository = _MemoryChecklistsRepository()
      ..savedChecklists = [checklist];

    await tester.pumpWidget(
      BlocProvider(
        create: (_) =>
            ChecklistsBloc(repository: repository)
              ..add(ChecklistsLoadRequested()),
        child: MaterialApp(
          home: ExpansionPanelListTabbedWidget(
            widgetCheckListObject: checklist,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ExpansionTile), findsOneWidget);
    await tester.tap(find.text('Empty checkpoint'));
    await tester.pumpAndSettle();
    expect(find.byType(ExpansionTile), findsOneWidget);

    await tester.tap(find.text('Checkpoint with notes'));
    await tester.pumpAndSettle();
    expect(find.text('Notes : Bring a charger'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('checklist home returns to the service selector', (tester) async {
    final repository = _MemoryChecklistsRepository();

    await tester.pumpWidget(
      BlocProvider(
        create: (_) =>
            ChecklistsBloc(repository: repository)
              ..add(ChecklistsLoadRequested()),
        child: MaterialApp(
          home: TodoLandingPage(directory: Directory.systemTemp),
        ),
      ),
    );
    await tester.tap(find.text('Ouvrir mes checklists'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Accueil'));
    await tester.pumpAndSettle();

    expect(find.text('Ouvrir ma todo-list'), findsOneWidget);
    expect(find.text('Ouvrir mes checklists'), findsOneWidget);
  });

  testWidgets('todo home returns to the service selector', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: TodoLandingPage(directory: Directory.systemTemp)),
    );
    await tester.tap(find.text('Ouvrir ma todo-list'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.tap(find.byTooltip('Accueil'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Ouvrir ma todo-list'), findsOneWidget);
    expect(find.text('Ouvrir mes checklists'), findsOneWidget);
  });

  testWidgets('checklist form requires a title', (tester) async {
    final checklist = CheckList(
      '',
      const IconEntity(key: 'essentiel-checklist'),
      '',
      '',
    );
    final repository = _MemoryChecklistsRepository()
      ..savedChecklists = [checklist];

    await tester.pumpWidget(
      BlocProvider(
        create: (_) =>
            ChecklistsBloc(repository: repository)
              ..add(ChecklistsLoadRequested()),
        child: MaterialApp(
          home: CheckListEditingPanel(widgetCheckListObject: checklist),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Enregistrer la checklist'));
    await tester.pumpAndSettle();

    expect(find.text('Saisissez un nom pour la checklist.'), findsOneWidget);
    expect(repository.savedChecklists.single.title, isEmpty);
  });

  testWidgets('checkpoint form requires a title', (tester) async {
    final checklist = CheckList(
      'Packing',
      const IconEntity(key: 'essentiel-checklist'),
      '',
      '',
    );
    final checkpoint = ActionObject(title: '');
    checklist.checkListObjects = [checkpoint];
    final repository = _MemoryChecklistsRepository()
      ..savedChecklists = [checklist];

    await tester.pumpWidget(
      BlocProvider(
        create: (_) =>
            ChecklistsBloc(repository: repository)
              ..add(ChecklistsLoadRequested()),
        child: MaterialApp(
          home: CheckPointEditingPanel(
            checkPointTransmittedData: CheckPointTransmittedData(
              widgetActionObject: checkpoint,
              uuidStringToCreateFolder: checklist.uuid,
              checkpointIndex: 0,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Enregistrer'));
    await tester.pumpAndSettle();

    expect(find.text('Saisissez un titre pour ce point.'), findsOneWidget);
    expect(
      repository.savedChecklists.single.checkListObjects.single.title,
      isEmpty,
    );
  });

  testWidgets('checkpoint icon selection is saved with the checkpoint', (
    tester,
  ) async {
    final checklist = CheckList(
      'Packing',
      const IconEntity(key: 'essentiel-checklist'),
      '',
      '',
    );
    final checkpoint = ActionObject(title: 'Passport');
    checklist.checkListObjects = [checkpoint];
    final repository = _MemoryChecklistsRepository()
      ..savedChecklists = [checklist];
    final selectedIcon = (await IconLocalDataSourceImpl().fetchIcons())[1]
        .toEntity();

    await tester.pumpWidget(
      BlocProvider(
        create: (_) =>
            ChecklistsBloc(repository: repository)
              ..add(ChecklistsLoadRequested()),
        child: MaterialApp(
          home: CheckPointEditingPanel(
            checkPointTransmittedData: CheckPointTransmittedData(
              widgetActionObject: checkpoint,
              uuidStringToCreateFolder: checklist.uuid,
              checkpointIndex: 0,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Choisir une icône'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.byTooltip('${selectedIcon.label} · ${selectedIcon.category}'),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Enregistrer'));
    await tester.pumpAndSettle();

    final persistedIcon =
        repository.savedChecklists.single.checkListObjects.single.icon;
    expect(persistedIcon, IconEntity(key: selectedIcon.key));
  });

  testWidgets('key-only checklist icons resolve with the current catalog', (
    tester,
  ) async {
    final icon = (await IconLocalDataSourceImpl().fetchIcons()).first;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChecklistIconView(icon: IconEntity(key: icon.key)),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (widget) => widget is Icon && widget.icon?.codePoint == 0xe15b,
      ),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('icon picker searches through the categorized catalog', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: ChecklistIconPickerDialog()),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'telephone');
    await tester.pumpAndSettle();

    expect(find.byTooltip('Téléphone · Technologie'), findsOneWidget);
    expect(find.byTooltip('Avion · Voyage'), findsNothing);
  });
}

class _MemoryChecklistsRepository implements ChecklistsRepository {
  List<CheckList> savedChecklists = [];

  @override
  Future<List<CheckList>> loadChecklists() async => savedChecklists;

  @override
  Future<void> saveChecklists(List<CheckList> checklists) async {
    savedChecklists = checklists;
  }
}

class _MemoryAppCheckListStorage extends AppCheckListStorage {
  _MemoryAppCheckListStorage(this.contents);

  final String contents;
  String? savedContents;

  @override
  Future<String> readAllCheckLists() async => contents;

  @override
  Future<File> writeAllCheckLists(String contents) async {
    savedContents = contents;
    return File('memory-checklists.json');
  }
}
