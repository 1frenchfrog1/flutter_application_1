import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/checklists_bloc.dart';
import '../bloc/checklists_event.dart';
import '../bloc/checklists_state.dart';
import '../datamodel/CheckListDataModel.dart';
import 'EvaluationPanel.dart';
import 'gridview.dart';

class HomeCheckList extends StatelessWidget {
  const HomeCheckList({super.key});

  static const String routeName = '/HomeCheckListRoute';

  @override
  Widget build(BuildContext context) {
    return const _ChecklistHomeContent();
  }
}

class _ChecklistHomeContent extends StatelessWidget {
  const _ChecklistHomeContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChecklistsBloc, ChecklistsState>(
      builder: (context, state) {
        final List<CheckList> checklists = state is ChecklistsLoadSuccess
            ? state.checklists
            : const [];

        return Scaffold(
          backgroundColor: Colors.grey[600],
          appBar: AppBar(
            backgroundColor: Colors.black26,
            leading: IconButton(
              tooltip: 'Accueil',
              icon: const Icon(Icons.home_outlined),
              onPressed: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst),
            ),
            title: const Text(
              'My Checklists',
              style: TextStyle(color: Colors.orange),
            ),
          ),
          body: state is ChecklistsLoadInProgress
              ? const Center(child: CircularProgressIndicator())
              : state is ChecklistsLoadFailure
              ? const Center(child: Text('Unable to load checklists'))
              : CheckListGridView(checklists: checklists),
          drawer: Drawer(
            child: ListView(
              children: [
                const DrawerHeader(child: Text('My Checklists')),
                ListTile(
                  leading: const Icon(Icons.assessment),
                  title: const Text('Evaluation tools'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            EvaluationPanel(allCheckListObject: checklists),
                      ),
                    );
                  },
                ),
                const AboutListTile(
                  applicationName: 'Application Name',
                  applicationVersion: 'v1.1.0',
                ),
              ],
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'checklist-reload',
                onPressed: () => context.read<ChecklistsBloc>().add(
                  ChecklistsLoadRequested(),
                ),
                backgroundColor: Colors.orange,
                tooltip: 'Reload',
                child: const Icon(Icons.cloud_queue, color: Colors.black),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                heroTag: 'checklist-add',
                onPressed: () =>
                    context.read<ChecklistsBloc>().add(ChecklistCreated()),
                backgroundColor: Colors.orange,
                tooltip: 'Add checklist',
                child: const Icon(Icons.add, color: Colors.black),
              ),
            ],
          ),
        );
      },
    );
  }
}
