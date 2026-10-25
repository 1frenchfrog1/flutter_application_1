import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/icons/domain/entities/icon_entity.dart';
import '../bloc/cooklists_bloc.dart';
import '../bloc/cooklists_event.dart';
import '../datamodel/cook_classification.dart';
import '../datamodel/cook_list_data_model.dart';
import '../l10n/cook_localization_context.dart';
import '../widgets/cook_icon_picker.dart';
import 'cook_step_list_editing_panel.dart';

class CookListEditingPanel extends StatefulWidget {
  final CookList widgetCookList;
  static const String routeName = '/editCookList';

  const CookListEditingPanel({super.key, required this.widgetCookList});

  @override
  State<CookListEditingPanel> createState() => _CookListEditingPanelState();
}

class _CookListEditingPanelState extends State<CookListEditingPanel> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _notesController;
  late final TextEditingController _genreController;
  final _genreFocusNode = FocusNode();
  late final CookList _draft;

  @override
  void initState() {
    super.initState();
    _draft = CookList.fromJson(widget.widgetCookList.toJson());
    _titleController = TextEditingController(text: _draft.title);
    _descriptionController = TextEditingController(text: _draft.description);
    _notesController = TextEditingController(text: _draft.notes);
    _genreController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _notesController.dispose();
    _genreController.dispose();
    _genreFocusNode.dispose();
    super.dispose();
  }

  void _addLabel(String value) {
    final label = value.trim();
    _genreController.clear();
    if (label.isEmpty) return;
    final exists = _draft.labels.any(
      (l) => l.toLowerCase() == label.toLowerCase(),
    );
    if (!exists) setState(() => _draft.labels.add(label));
  }

  Widget _classificationSection(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final labels = cookClassificationLabels(languageCode);
    final textStyle = Theme.of(context).textTheme.bodyLarge
        ?.copyWith(color: const Color(0xFF303030));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel(context, labels.servings),
        Row(
          children: [
            IconButton(
              tooltip: '-',
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: _draft.servings > 1
                  ? () => setState(() => _draft.servings--)
                  : null,
            ),
            Text(
              labels.servingsCount(_draft.servings),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            IconButton(
              tooltip: '+',
              icon: const Icon(Icons.add_circle_outline),
              onPressed: _draft.servings < 99
                  ? () => setState(() => _draft.servings++)
                  : null,
            ),
          ],
        ),
        const SizedBox(height: 4),
        _sectionLabel(context, labels.type),
        const SizedBox(height: 4),
        Row(
          children: [
            for (final type in CookType.values)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: ChoiceChip(
                    padding: EdgeInsets.zero,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 2),
                    visualDensity: VisualDensity.compact,
                    showCheckmark: false,
                    label: SizedBox(
                      width: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(labels.typeLabel(type)),
                      ),
                    ),
                    selected: _draft.type == type,
                    onSelected: (selected) =>
                        setState(() => _draft.type = selected ? type : null),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        _sectionLabel(context, labels.genre),
        const SizedBox(height: 4),
        if (_draft.labels.isNotEmpty)
          Wrap(
            spacing: 6,
            runSpacing: 0,
            children: [
              for (final label in _draft.labels)
                InputChip(
                  label: Text(label),
                  visualDensity: VisualDensity.compact,
                  onDeleted: () => setState(() => _draft.labels.remove(label)),
                ),
            ],
          ),
        RawAutocomplete<String>(
          textEditingController: _genreController,
          focusNode: _genreFocusNode,
          onSelected: (value) => _addLabel(value),
          optionsBuilder: (value) {
            final query = value.text.trim().toLowerCase();
            final existing = _draft.labels.map((l) => l.toLowerCase()).toSet();
            return cookGenreSuggestions(languageCode, _draft.type)
                .where(
                  (name) =>
                      !existing.contains(name.toLowerCase()) &&
                      name.toLowerCase().contains(query),
                )
                .take(8);
          },
          fieldViewBuilder: (context, controller, focusNode, onSubmitted) =>
              TextFormField(
                controller: controller,
                focusNode: focusNode,
                maxLength: 40,
                textCapitalization: TextCapitalization.sentences,
                style: textStyle,
                decoration: _fieldDecoration(context, labels.genreHint)
                    .copyWith(
                      suffixIcon: IconButton(
                        tooltip: '+',
                        icon: const Icon(Icons.add),
                        onPressed: () => _addLabel(controller.text),
                      ),
                    ),
                onFieldSubmitted: (_) => _addLabel(controller.text),
              ),
          optionsViewBuilder: (context, onSelected, options) => Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 220,
                  maxWidth: 320,
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    for (final option in options)
                      ListTile(
                        dense: true,
                        title: Text(option),
                        onTap: () => onSelected(option),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.cookL10n;
    final cooklist = widget.widgetCookList;
    final total = cooklist.cookSteps.length;
    final checked = cooklist.cookSteps.where((step) => step.state).length;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.editCooklist),
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
            tooltip: l10n.otherActions,
            onSelected: (action) {
              if (action == 'clone') _cloneCooklist();
              if (action == 'uncheck') {
                context.read<CooklistsBloc>().add(
                  CookStepsUnchecked(cooklist.uuid),
                );
              }
              if (action == 'delete') _confirmDelete();
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'clone',
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.copy_outlined),
                  title: Text(l10n.duplicate),
                ),
              ),
              PopupMenuItem(
                value: 'uncheck',
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.check_box_outline_blank),
                  title: Text(l10n.uncheckAll),
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.delete_outline),
                  title: Text(l10n.delete),
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
            _sectionLabel(context, l10n.cooklistName),
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
              decoration: _fieldDecoration(context, l10n.cooklistNameHint),
              validator: (value) => (value ?? '').trim().isEmpty
                  ? l10n.cooklistNameRequired
                  : null,
            ),
            const SizedBox(height: 8),
            _classificationSection(context),
            const SizedBox(height: 8),
            _sectionLabel(context, l10n.steps),
            const SizedBox(height: 2),
            ListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.restaurant_menu),
              title: Text(l10n.manageSteps),
              subtitle: Text(l10n.stepCount(total)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      CookStepListEditingPanel(widgetCookList: cooklist),
                ),
              ),
            ),
            const SizedBox(height: 6),
            _sectionLabel(context, l10n.iconChoice),
            const SizedBox(height: 2),
            ListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              contentPadding: EdgeInsets.zero,
              leading: CookIconView(icon: _draft.icon),
              title: Text(l10n.icon),
              subtitle: Text(l10n.chooseCooklistIcon),
              trailing: const Icon(Icons.chevron_right),
              onTap: _selectIcon,
            ),
            const SizedBox(height: 8),
            _sectionLabel(context, l10n.description),
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
                l10n.cooklistDescriptionHint,
              ),
            ),
            const SizedBox(height: 8),
            _sectionLabel(context, l10n.optionalNotes),
            const SizedBox(height: 4),
            TextFormField(
              controller: _notesController,
              maxLength: 150,
              minLines: 2,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(color: const Color(0xFF303030)),
              decoration: _fieldDecoration(context, l10n.optionalNotes),
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
              label: Text(l10n.saveCooklist),
              onPressed: _saveCooklist,
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

  Future<void> _selectIcon() async {
    final icon = await showCookIconPicker(context);
    if (icon != null && mounted) {
      setState(() => _draft.icon = IconEntity(key: icon.key));
    }
  }

  void _saveCooklist() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    _addLabel(_genreController.text);
    _draft
      ..title = _titleController.text.trim()
      ..description = _descriptionController.text.trim()
      ..notes = _notesController.text.trim()
      ..updateDateTime();
    context.read<CooklistsBloc>().add(CooklistSaved(_draft));
    FocusScope.of(context).unfocus();
  }

  void _cloneCooklist() {
    context.read<CooklistsBloc>().add(CooklistCloned(_draft.uuid));
    Navigator.of(context).pop();
  }

  Future<void> _confirmDelete() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.cookL10n.deleteCooklistConfirmation),
        content: Text(context.cookL10n.irreversibleAction),
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
      context.read<CooklistsBloc>().add(CooklistDeleted(_draft.uuid));
      Navigator.of(context).pop();
    }
  }
}
