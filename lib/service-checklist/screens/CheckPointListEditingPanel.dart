import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../l10n/checklist_localization_context.dart';
import '../../features/icons/domain/entities/icon_entity.dart';
import '../bloc/checklists_bloc.dart';
import '../bloc/checklists_event.dart';
import '../bloc/checklists_state.dart';
import '../datamodel/CheckListDataModel.dart';
import '../widgets/checklist_icon_picker.dart';
import 'CheckPointEditingPanel.dart';

class CheckPointListEditingPanel extends StatefulWidget {
  final CheckList widgetCheckListObject;
  static const String routeName = '/editCheckPoints';

  const CheckPointListEditingPanel({
    super.key,
    required this.widgetCheckListObject,
  });

  @override
  State<CheckPointListEditingPanel> createState() =>
      _CheckPointListEditingPanelState();
}

class _CheckPointListEditingPanelState
    extends State<CheckPointListEditingPanel> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChecklistsBloc, ChecklistsState>(
      builder: (context, state) {
        if (state is! ChecklistsLoadSuccess) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final checklist = state.checklists.firstWhere(
          (item) => item.uuid == widget.widgetCheckListObject.uuid,
          orElse: () => widget.widgetCheckListObject,
        );
        final checkpoints = checklist.checkListObjects;

        return Scaffold(
          backgroundColor: Colors.grey[600],
          appBar: AppBar(
            backgroundColor: Colors.black26,
            title: Text(checklist.title),
          ),
          body: ReorderableListView.builder(
            itemCount: checkpoints.length,
            padding: const EdgeInsets.only(top: 8),
            onReorderItem: (oldIndex, newIndex) {
              context.read<ChecklistsBloc>().add(
                CheckpointReordered(checklist.uuid, oldIndex, newIndex),
              );
              setState(() => _selectedIndex = null);
            },
            itemBuilder: (context, index) {
              final checkpoint = checkpoints[index];
              return Card(
                key: ValueKey('${checklist.uuid}-$index-${checkpoint.title}'),
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
                  leading: _iconFor(checkpoint.icon),
                  title: Text(
                    checkpoint.title,
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontSize: 17),
                  ),
                  trailing: IconButton(
                    tooltip: context.l10n.editCheckpointTooltip,
                    visualDensity: VisualDensity.compact,
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CheckPointEditingPanel(
                          checkPointTransmittedData: CheckPointTransmittedData(
                            widgetActionObject: checkpoint,
                            uuidStringToCreateFolder: checklist.uuid,
                            checkpointIndex: index,
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
                heroTag: 'checkpoint-delete',
                tooltip: context.l10n.removeCheckpoint,
                backgroundColor: Colors.orange,
                onPressed: _selectedIndex == null
                    ? null
                    : () => _confirmDelete(checklist),
                child: const Icon(Icons.remove, color: Colors.black),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                heroTag: 'checkpoint-add',
                tooltip: context.l10n.addCheckpoint,
                backgroundColor: Colors.orange,
                onPressed: () {
                  context.read<ChecklistsBloc>().add(
                    CheckpointAdded(checklist.uuid, afterIndex: _selectedIndex),
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

  Future<void> _confirmDelete(CheckList checklist) async {
    final index = _selectedIndex;
    if (index == null) return;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.deleteCheckpointConfirmation),
        content: Text(context.l10n.cannotUndo),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.l10n.delete),
          ),
        ],
      ),
    );
    if (shouldDelete == true && mounted) {
      context.read<ChecklistsBloc>().add(
        CheckpointDeleted(checklist.uuid, index),
      );
      setState(() => _selectedIndex = null);
    }
  }

  Widget _iconFor(IconEntity icon) {
    return ChecklistIconView(icon: icon);
  }
}
