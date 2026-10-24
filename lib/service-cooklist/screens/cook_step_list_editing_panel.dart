import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cooklists_bloc.dart';
import '../bloc/cooklists_event.dart';
import '../bloc/cooklists_state.dart';
import '../datamodel/cook_list_data_model.dart';
import '../l10n/cook_localization_context.dart';
import '../widgets/cook_icon_picker.dart';
import 'cook_step_editing_panel.dart';

class CookStepListEditingPanel extends StatefulWidget {
  final CookList widgetCookList;
  static const String routeName = '/editCookSteps';

  const CookStepListEditingPanel({super.key, required this.widgetCookList});

  @override
  State<CookStepListEditingPanel> createState() =>
      _CookStepListEditingPanelState();
}

class _CookStepListEditingPanelState extends State<CookStepListEditingPanel> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CooklistsBloc, CooklistsState>(
      builder: (context, state) {
        if (state is! CooklistsLoadSuccess) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final cooklist = state.cooklists.firstWhere(
          (item) => item.uuid == widget.widgetCookList.uuid,
          orElse: () => widget.widgetCookList,
        );
        final steps = cooklist.cookSteps;

        return Scaffold(
          backgroundColor: Colors.grey[600],
          appBar: AppBar(
            backgroundColor: Colors.black26,
            title: Text(cooklist.title),
          ),
          body: ReorderableListView.builder(
            itemCount: steps.length,
            padding: const EdgeInsets.only(top: 8),
            onReorderItem: (oldIndex, newIndex) {
              context.read<CooklistsBloc>().add(
                CookStepReordered(cooklist.uuid, oldIndex, newIndex),
              );
              setState(() => _selectedIndex = null);
            },
            itemBuilder: (context, index) {
              final step = steps[index];
              return Card(
                key: ValueKey('${cooklist.uuid}-$index-${step.title}'),
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: const BorderSide(color: Colors.orange, width: 0.7),
                ),
                child: ListTile(
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  selected: index == _selectedIndex,
                  leading: CookIconView(icon: step.icon),
                  title: Text(
                    step.title,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(fontSize: 17),
                  ),
                  trailing: IconButton(
                    tooltip: context.cookL10n.editStepTooltip,
                    visualDensity: VisualDensity.compact,
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CookStepEditingPanel(
                          cookStepTransmittedData: CookStepTransmittedData(
                            widgetCookStep: step,
                            uuidStringToCreateFolder: cooklist.uuid,
                            stepIndex: index,
                          ),
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.more_vert),
                  ),
                  onTap: () => setState(
                    () =>
                        _selectedIndex = index == _selectedIndex ? null : index,
                  ),
                ),
              );
            },
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'cookstep-delete',
                tooltip: context.cookL10n.removeStep,
                backgroundColor: Colors.orange,
                onPressed: _selectedIndex == null
                    ? null
                    : () => _confirmDelete(cooklist),
                child: const Icon(Icons.remove, color: Colors.black),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                heroTag: 'cookstep-add',
                tooltip: context.cookL10n.addStep,
                backgroundColor: Colors.orange,
                onPressed: () {
                  context.read<CooklistsBloc>().add(
                    CookStepAdded(cooklist.uuid, afterIndex: _selectedIndex),
                  );
                  setState(() => _selectedIndex = null);
                },
                child: const Icon(Icons.add, color: Colors.black),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _confirmDelete(CookList cooklist) async {
    final index = _selectedIndex;
    if (index == null) return;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.cookL10n.deleteStepConfirmation),
        content: Text(context.cookL10n.cannotUndo),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.cookL10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.cookL10n.delete),
          ),
        ],
      ),
    );
    if (shouldDelete == true && mounted) {
      context.read<CooklistsBloc>().add(CookStepDeleted(cooklist.uuid, index));
      setState(() => _selectedIndex = null);
    }
  }
}
