import 'package:flutter/material.dart';

import '../l10n/cook_localization_context.dart';
import 'cook_utensil_editing_panel.dart';

/// Edits a working copy of the utensils and returns it on back navigation.
class CookUtensilListEditingPanel extends StatefulWidget {
  final String stepTitle;
  final List<String> utensils;

  const CookUtensilListEditingPanel({
    super.key,
    required this.stepTitle,
    required this.utensils,
  });

  @override
  State<CookUtensilListEditingPanel> createState() =>
      _CookUtensilListEditingPanelState();
}

class _CookUtensilListEditingPanelState
    extends State<CookUtensilListEditingPanel> {
  late final List<_UtensilEntry> _entries = widget.utensils
      .map(_UtensilEntry.new)
      .toList();
  int? _selectedIndex;

  Future<String?> _edit(String utensil) => Navigator.of(context).push<String>(
    MaterialPageRoute(
      builder: (_) => CookUtensilEditingPanel(utensil: utensil),
    ),
  );

  Future<void> _add() async {
    final created = await _edit('');
    if (created == null || !mounted) return;
    setState(() {
      final index = _selectedIndex;
      final entry = _UtensilEntry(created);
      if (index == null) {
        _entries.add(entry);
      } else {
        _entries.insert(index + 1, entry);
      }
      _selectedIndex = null;
    });
  }

  Future<void> _editAt(int index) async {
    final updated = await _edit(_entries[index].name);
    if (updated != null && mounted) {
      setState(() => _entries[index].name = updated);
    }
  }

  Future<void> _confirmDelete() async {
    final index = _selectedIndex;
    if (index == null) return;
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.cookL10n.deleteUtensilConfirmation),
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
      setState(() {
        _entries.removeAt(index);
        _selectedIndex = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<List<String>>(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          Navigator.of(context).pop(_entries.map((e) => e.name).toList());
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[600],
        appBar: AppBar(
          backgroundColor: Colors.black26,
          title: Text('${widget.stepTitle} - ${context.cookL10n.utensils}'),
        ),
        body: ReorderableListView.builder(
          itemCount: _entries.length,
          padding: const EdgeInsets.only(top: 8),
          onReorderItem: (oldIndex, newIndex) => setState(() {
            _entries.insert(newIndex, _entries.removeAt(oldIndex));
            _selectedIndex = null;
          }),
          itemBuilder: (context, index) {
            final entry = _entries[index];
            return Card(
              key: ObjectKey(entry),
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
                title: Text(entry.name),
                trailing: IconButton(
                  tooltip: context.cookL10n.editUtensil,
                  visualDensity: VisualDensity.compact,
                  onPressed: () => _editAt(index),
                  icon: const Icon(Icons.more_vert),
                ),
                onTap: () => setState(
                  () => _selectedIndex = index == _selectedIndex ? null : index,
                ),
              ),
            );
          },
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'cookutensil-delete',
              tooltip: context.cookL10n.removeUtensil,
              backgroundColor: Colors.orange,
              onPressed: _selectedIndex == null ? null : _confirmDelete,
              child: const Icon(Icons.remove, color: Colors.black),
            ),
            const SizedBox(width: 8),
            FloatingActionButton(
              heroTag: 'cookutensil-add',
              tooltip: context.cookL10n.addUtensil,
              backgroundColor: Colors.orange,
              onPressed: _add,
              child: const Icon(Icons.add, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class _UtensilEntry {
  String name;

  _UtensilEntry(this.name);
}
