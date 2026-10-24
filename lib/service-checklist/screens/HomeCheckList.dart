import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../l10n/checklist_localization_context.dart';
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
              tooltip: context.l10n.homeTooltip,
              icon: const Icon(Icons.home_outlined),
              onPressed: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst),
            ),
            title: Text(
              context.l10n.myChecklists,
              style: TextStyle(color: Colors.orange),
            ),
          ),
          body: state is ChecklistsLoadInProgress
              ? const Center(child: CircularProgressIndicator())
              : state is ChecklistsLoadFailure
              ? Center(child: Text(context.l10n.unableToLoadChecklists))
              : CheckListGridView(checklists: checklists),
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(child: Text(context.l10n.myChecklists)),
                ListTile(
                  leading: const Icon(Icons.assessment),
                  title: Text(context.l10n.evaluationTools),
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
                AboutListTile(
                  applicationName: context.l10n.myChecklists,
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
                tooltip: context.l10n.reload,
                child: const Icon(Icons.cloud_queue, color: Colors.black),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                heroTag: 'checklist-add',
                onPressed: () =>
                    context.read<ChecklistsBloc>().add(ChecklistCreated()),
                backgroundColor: Colors.orange,
                tooltip: context.l10n.addChecklist,
                child: const Icon(Icons.add, color: Colors.black),
              ),
            ],
          ),
        );
      },
    );
  }
}
