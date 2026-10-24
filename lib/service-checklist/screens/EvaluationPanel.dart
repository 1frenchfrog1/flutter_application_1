import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/localization_context.dart';
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
        title: Text(context.l10n.evaluationPanel),
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
              label: Text(context.l10n.back),
            ),
            FilledButton.icon(
              onPressed: () => context.read<ChecklistsBloc>().add(
                ChecklistsDemoDataRequested(),
              ),
              icon: const Icon(Icons.library_add),
              label: Text(context.l10n.addSampleChecklists),
            ),
            OutlinedButton.icon(
              onPressed: () =>
                  context.read<ChecklistsBloc>().add(ChecklistsLoadRequested()),
              icon: const Icon(Icons.refresh),
              label: Text(context.l10n.reloadFromStorage),
            ),
            FilledButton.icon(
              onPressed: () =>
                  context.read<ChecklistsBloc>().add(ChecklistsCleared()),
              icon: const Icon(Icons.delete_forever),
              label: Text(context.l10n.deleteAllChecklists),
            ),
          ],
        ),
      ),
    );
  }
}
