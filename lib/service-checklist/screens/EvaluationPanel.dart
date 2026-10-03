import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/checklists_bloc.dart';
import '../bloc/checklists_event.dart';
import '../datamodel/CheckListDataModel.dart';

class EvaluationPanel extends StatelessWidget {
  final List<CheckList> allCheckListObject;
  static const String routeName = '/evaluationPanel';

  const EvaluationPanel({super.key, required this.allCheckListObject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: const Text('Evaluation panel'),
      ),
      body: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back'),
            ),
            FilledButton.icon(
              onPressed: () => context.read<ChecklistsBloc>().add(
                ChecklistsDemoDataRequested(),
              ),
              icon: const Icon(Icons.library_add),
              label: const Text('Add sample checklists'),
            ),
            OutlinedButton.icon(
              onPressed: () =>
                  context.read<ChecklistsBloc>().add(ChecklistsLoadRequested()),
              icon: const Icon(Icons.refresh),
              label: const Text('Reload from storage'),
            ),
            FilledButton.icon(
              onPressed: () =>
                  context.read<ChecklistsBloc>().add(ChecklistsCleared()),
              icon: const Icon(Icons.delete_forever),
              label: const Text('Delete all checklists'),
            ),
          ],
        ),
      ),
    );
  }
}
