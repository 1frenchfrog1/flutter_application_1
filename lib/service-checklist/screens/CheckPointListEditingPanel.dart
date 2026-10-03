import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/checklists_bloc.dart';
import '../bloc/checklists_event.dart';
import '../bloc/checklists_state.dart';
import '../datamodel/CheckListDataModel.dart';
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
            padding: const EdgeInsets.symmetric(vertical: 8),
            onReorderItem: (oldIndex, newIndex) {
              context.read<ChecklistsBloc>().add(
                CheckpointReordered(checklist.uuid, oldIndex, newIndex),
              );
              setState(() => _selectedIndex = null);
            },
            itemBuilder: (context, index) {
              final checkpoint = checkpoints[index];
              return ListTile(
                key: ValueKey('${checklist.uuid}-$index-${checkpoint.title}'),
                selected: index == _selectedIndex,
                leading: _iconFor(checkpoint.icon),
                title: Text(checkpoint.title),
                subtitle: Text(
                  'Descr: ${checkpoint.description}\nNotes: ${checkpoint.notes}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  tooltip: 'Edit checkpoint',
                  icon: const Icon(Icons.more_vert),
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
                ),
                onTap: () => setState(
                  () => _selectedIndex = index == _selectedIndex ? null : index,
                ),
              );
            },
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'checkpoint-delete',
                tooltip: 'Remove checkpoint',
                backgroundColor: Colors.orange,
                onPressed: _selectedIndex == null
                    ? null
                    : () => _confirmDelete(checklist),
                child: const Icon(Icons.remove, color: Colors.black),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                heroTag: 'checkpoint-add',
                tooltip: 'Add checkpoint',
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
        title: const Text('Delete checkpoint?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
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

  Widget _iconFor(dynamic icon) {
    if (icon is FaIconData) return FaIcon(icon);
    if (icon is IconData) return Icon(icon);
    return const Icon(Icons.checklist);
  }
}
