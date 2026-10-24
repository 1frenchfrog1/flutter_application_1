import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cooklists_bloc.dart';
import '../bloc/cooklists_event.dart';
import '../datamodel/cook_list_data_model.dart';
import '../l10n/cook_localization_context.dart';

class CookEvaluationPanel extends StatelessWidget {
  final List<CookList> allCookLists;
  static const String routeName = '/cookEvaluationPanel';

  const CookEvaluationPanel({super.key, required this.allCookLists});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text(context.cookL10n.evaluationPanel),
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
              label: Text(context.cookL10n.back),
            ),
            FilledButton.icon(
              onPressed: () => context.read<CooklistsBloc>().add(
                CooklistsDemoDataRequested(),
              ),
              icon: const Icon(Icons.library_add),
              label: Text(context.cookL10n.addSampleCooklists),
            ),
            OutlinedButton.icon(
              onPressed: () =>
                  context.read<CooklistsBloc>().add(CooklistsLoadRequested()),
              icon: const Icon(Icons.refresh),
              label: Text(context.cookL10n.reloadFromStorage),
            ),
            FilledButton.icon(
              onPressed: () =>
                  context.read<CooklistsBloc>().add(CooklistsCleared()),
              icon: const Icon(Icons.delete_forever),
              label: Text(context.cookL10n.deleteAllCooklists),
            ),
          ],
        ),
      ),
    );
  }
}
