import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/localization_context.dart';
import '../../features/icons/domain/entities/icon_entity.dart';
import '../bloc/checklists_bloc.dart';
import '../bloc/checklists_event.dart';
import '../datamodel/CheckListDataModel.dart';
import '../widgets/checklist_icon_picker.dart';
import 'CheckPointListEditingPanel.dart';

class CheckListEditingPanel extends StatefulWidget {
  final CheckList widgetCheckListObject;
  static const String routeName = '/editCheckList';

  const CheckListEditingPanel({super.key, required this.widgetCheckListObject});

  @override
  State<CheckListEditingPanel> createState() => _CheckListEditingPanelState();
}

class _CheckListEditingPanelState extends State<CheckListEditingPanel> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _notesController;
  late final CheckList _draft;

  @override
  void initState() {
    super.initState();
    _draft = CheckList.fromJson(widget.widgetCheckListObject.toJson());
    _titleController = TextEditingController(text: _draft.title);
    _descriptionController = TextEditingController(text: _draft.description);
    _notesController = TextEditingController(text: _draft.notes);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final checklist = widget.widgetCheckListObject;
    final total = checklist.checkListObjects.length;
    final checked = checklist.checkListObjects
        .where((checkpoint) => checkpoint.state)
        .length;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.editChecklist),
        actions: [
          SizedBox(
            width: 84,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LinearProgressIndicator(
                    value: total == 0 ? 0 : checked / total,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '$checked/$total',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
          ),
          PopupMenuButton<String>(
            tooltip: context.l10n.otherActions,
            onSelected: (action) {
              if (action == 'clone') _cloneChecklist();
              if (action == 'uncheck') {
                context.read<ChecklistsBloc>().add(
                  CheckpointsUnchecked(checklist.uuid),
                );
              }
              if (action == 'delete') _confirmDelete();
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'clone',
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.copy_outlined),
                  title: Text(context.l10n.duplicate),
                ),
              ),
              PopupMenuItem(
                value: 'uncheck',
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.check_box_outline_blank),
                  title: Text(context.l10n.uncheckAll),
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.delete_outline),
                  title: Text(context.l10n.delete),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          children: [
            _sectionLabel(context, context.l10n.checklistName),
            const SizedBox(height: 4),
            TextFormField(
              controller: _titleController,
              autofocus: true,
              maxLength: 40,
              textCapitalization: TextCapitalization.sentences,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF303030),
              ),
              decoration: _fieldDecoration(
                context,
                context.l10n.checklistNameHint,
              ),
              validator: (value) => (value ?? '').trim().isEmpty
                  ? context.l10n.checklistNameRequired
                  : null,
            ),
            const SizedBox(height: 8),
            _sectionLabel(context, context.l10n.checkpoints),
            const SizedBox(height: 2),
            ListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.checklist_outlined),
              title: Text(context.l10n.manageCheckpoints),
              subtitle: Text(context.l10n.checkpointCount(total)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CheckPointListEditingPanel(
                    widgetCheckListObject: checklist,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            _sectionLabel(context, context.l10n.iconChoice),
            const SizedBox(height: 2),
            ListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              contentPadding: EdgeInsets.zero,
              leading: _iconFor(_draft.icon),
              title: Text(context.l10n.icon),
              subtitle: Text(context.l10n.chooseChecklistIcon),
              trailing: const Icon(Icons.chevron_right),
              onTap: _selectIcon,
            ),
            const SizedBox(height: 8),
            _sectionLabel(context, context.l10n.description),
            const SizedBox(height: 4),
            TextFormField(
              controller: _descriptionController,
              maxLength: 150,
              minLines: 3,
              maxLines: 6,
              textCapitalization: TextCapitalization.sentences,
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(color: const Color(0xFF303030)),
              decoration: _fieldDecoration(
                context,
                context.l10n.checklistDescriptionHint,
              ),
            ),
            const SizedBox(height: 8),
            _sectionLabel(context, context.l10n.optionalNotes),
            const SizedBox(height: 4),
            TextFormField(
              controller: _notesController,
              maxLength: 150,
              minLines: 2,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(color: const Color(0xFF303030)),
              decoration: _fieldDecoration(context, context.l10n.optionalNotes),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedPadding(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: FilledButton.icon(
              icon: const Icon(Icons.save_outlined),
              label: Text(context.l10n.saveChecklist),
              onPressed: _saveChecklist,
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(BuildContext context, String label) => Text(
    label,
    style: Theme.of(context).textTheme.titleMedium
        ?.copyWith(fontWeight: FontWeight.w700),
  );

  InputDecoration _fieldDecoration(BuildContext context, String hintText) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide.none,
    );
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Color(0xFF666666)),
      filled: true,
      fillColor: const Color(0xFFF2F2F2),
      border: border,
      enabledBorder: border,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      counterStyle: const TextStyle(color: Color(0xFF777777)),
    );
  }

  Widget _iconFor(IconEntity icon) {
    return ChecklistIconView(icon: icon);
  }

  Future<void> _selectIcon() async {
    final icon = await showChecklistIconPicker(context);
    if (icon != null && mounted) {
      setState(() => _draft.icon = IconEntity(key: icon.key));
    }
  }

  void _saveChecklist() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    _draft
      ..title = _titleController.text.trim()
      ..description = _descriptionController.text.trim()
      ..notes = _notesController.text.trim()
      ..updateDateTime();
    context.read<ChecklistsBloc>().add(ChecklistSaved(_draft));
    FocusScope.of(context).unfocus();
  }

  void _cloneChecklist() {
    context.read<ChecklistsBloc>().add(ChecklistCloned(_draft.uuid));
    Navigator.of(context).pop();
  }

  Future<void> _confirmDelete() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.deleteChecklistConfirmation),
        content: Text(context.l10n.irreversibleAction),
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
      context.read<ChecklistsBloc>().add(ChecklistDeleted(_draft.uuid));
      Navigator.of(context).pop();
    }
  }
}
