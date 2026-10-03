import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/checklists_bloc.dart';
import '../bloc/checklists_event.dart';
import '../bloc/checklists_state.dart';
import '../datamodel/CheckListDataModel.dart';
import '../datamodel/CheckListFileAccess.dart';
import 'checkListEditingPanel.dart';

class ExpansionPanelListTabbedWidget extends StatefulWidget {
  static const String routeName = '/testTab';
  final CheckList widgetCheckListObject;

  const ExpansionPanelListTabbedWidget({
    super.key,
    required this.widgetCheckListObject,
  });

  @override
  State<ExpansionPanelListTabbedWidget> createState() =>
      _ExpansionPanelListTabbedWidgetState();
}

class _ExpansionPanelListTabbedWidgetState
    extends State<ExpansionPanelListTabbedWidget> {
  final PageController _pageController = PageController(initialPage: 1);
  final AppCheckListStorage _storage = AppCheckListStorage();
  final Map<String, Future<File?>> _imageLoads = {};
  int _selectedIndex = 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChecklistsBloc, ChecklistsState>(
      builder: (context, state) {
        if (state is ChecklistsLoadInProgress) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is ChecklistsLoadFailure) {
          return const Scaffold(
            body: Center(child: Text('Unable to load checklists')),
          );
        }
        if (state is! ChecklistsLoadSuccess) {
          return const SizedBox.shrink();
        }

        final checklist = state.checklists.firstWhere(
          (item) => item.uuid == widget.widgetCheckListObject.uuid,
          orElse: () => widget.widgetCheckListObject,
        );
        return Scaffold(
          backgroundColor: Colors.grey[600],
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) => setState(() => _selectedIndex = index),
            children: [
              CheckListEditingPanel(widgetCheckListObject: checklist),
              _checkpointList(checklist, showCompleted: true),
              _checkpointList(checklist, showCompleted: false),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black26,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Tools'),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_box),
                label: 'All',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_box_outline_blank),
                label: 'Left To Do',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.white70,
            onTap: (index) {
              setState(() => _selectedIndex = index);
              _pageController.jumpToPage(index);
            },
          ),
        );
      },
    );
  }

  Widget _checkpointList(CheckList checklist, {required bool showCompleted}) {
    final indexedCheckpoints = checklist.checkListObjects
        .asMap()
        .entries
        .where((entry) => showCompleted || !entry.value.state)
        .toList(growable: false);

    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text(checklist.title),
        actions: [_ProgressIndicator(checklist: checklist)],
      ),
      body: ListView.builder(
        itemCount: indexedCheckpoints.length,
        itemBuilder: (context, visibleIndex) {
          final entry = indexedCheckpoints[visibleIndex];
          final checkpoint = entry.value;
          return Card(
            key: ValueKey('${checklist.uuid}-${entry.key}'),
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ExpansionTile(
              leading: _iconFor(checkpoint.icon),
              title: Text(checkpoint.title),
              trailing: Checkbox(
                value: checkpoint.state,
                activeColor: Colors.orange,
                onChanged: (value) {
                  context.read<ChecklistsBloc>().add(
                    CheckpointStateChanged(
                      checklist.uuid,
                      entry.key,
                      value ?? false,
                    ),
                  );
                },
              ),
              children: [
                if (checkpoint.image != null)
                  FutureBuilder<File?>(
                    future: _imageLoads.putIfAbsent(
                      '${checklist.uuid}/${checkpoint.image}',
                      () => _storage.readCheckPointImage(
                        checklist.uuid,
                        checkpoint.image,
                      ),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.file(
                          snapshot.data!,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ListTile(
                  title: Text(checkpoint.description),
                  subtitle: Text('Notes: ${checkpoint.notes}'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _iconFor(dynamic icon) {
    if (icon is FaIconData) return FaIcon(icon);
    if (icon is IconData) return Icon(icon);
    return const Icon(Icons.checklist);
  }
}

class _ProgressIndicator extends StatelessWidget {
  final CheckList checklist;

  const _ProgressIndicator({required this.checklist});

  @override
  Widget build(BuildContext context) {
    final total = checklist.checkListObjects.length;
    final checked = checklist.checkListObjects
        .where((checkpoint) => checkpoint.state)
        .length;
    final progress = total == 0 ? 0.0 : checked / total;

    return SizedBox(
      width: 76,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(value: progress),
            Text('$checked/$total'),
          ],
        ),
      ),
    );
  }
}
