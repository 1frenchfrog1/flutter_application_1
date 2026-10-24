import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/icons/domain/entities/icon_entity.dart';
import '../bloc/cooklists_bloc.dart';
import '../bloc/cooklists_event.dart';
import '../datamodel/cook_list_data_model.dart';
import '../datamodel/cook_list_file_access.dart';
import '../l10n/cook_localization_context.dart';
import '../widgets/cook_icon_picker.dart';
import 'cook_step_image_selection_panel.dart';

class CookStepTransmittedData {
  final CookStep widgetCookStep;
  final String uuidStringToCreateFolder;
  final int stepIndex;

  const CookStepTransmittedData({
    required this.widgetCookStep,
    required this.uuidStringToCreateFolder,
    required this.stepIndex,
  });
}

class CookStepEditingPanel extends StatefulWidget {
  final CookStepTransmittedData cookStepTransmittedData;
  static const String routeName = '/editCookStep';

  const CookStepEditingPanel({super.key, required this.cookStepTransmittedData});

  @override
  State<CookStepEditingPanel> createState() => _CookStepEditingPanelState();
}

class _CookStepEditingPanelState extends State<CookStepEditingPanel> {
  final _formKey = GlobalKey<FormState>();
  final CookListStorage _storage = CookListStorage();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _notesController;
  late final CookStep _draft;
  File? _pickedImage;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _draft = widget.cookStepTransmittedData.widgetCookStep.copyStep();
    _titleController = TextEditingController(text: _draft.title);
    _descriptionController = TextEditingController(text: _draft.description);
    _notesController = TextEditingController(text: _draft.notes);
    _loadExistingImage();
  }

  Future<void> _loadExistingImage() async {
    final transmitted = widget.cookStepTransmittedData;
    final image = await _storage.readCookStepImage(
      transmitted.uuidStringToCreateFolder,
      _draft.image,
    );
    if (image != null && await image.exists() && mounted) {
      setState(() => _pickedImage = image);
    }
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
    final l10n = context.cookL10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.editStep)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          children: [
            _sectionLabel(context, l10n.stepTitle),
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
              decoration: _fieldDecoration(context, l10n.stepExample),
              validator: (value) => (value ?? '').trim().isEmpty
                  ? l10n.stepTitleRequired
                  : null,
            ),
            const SizedBox(height: 8),
            _sectionLabel(context, l10n.stepIcon),
            ListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              contentPadding: EdgeInsets.zero,
              leading: CookIconView(icon: _draft.icon),
              title: Text(l10n.chooseIcon),
              subtitle: Text(l10n.iconWillAppearInList),
              trailing: const Icon(Icons.chevron_right),
              onTap: _selectIcon,
            ),
            const SizedBox(height: 8),
            _sectionLabel(context, l10n.photo),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: ColoredBox(
                color: const Color(0xFFF2F2F2),
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: _pickedImage == null
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.image_outlined, size: 36),
                              const SizedBox(height: 8),
                              Text(l10n.noPhotoAdded),
                            ],
                          ),
                        )
                      : Image.file(_pickedImage!, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: _selectImage,
                  icon: const Icon(Icons.add_a_photo_outlined),
                  label: Text(
                    _pickedImage == null ? l10n.addPhoto : l10n.replace,
                  ),
                ),
                if (_pickedImage != null)
                  TextButton.icon(
                    onPressed: _clearImage,
                    icon: const Icon(Icons.delete_outline),
                    label: Text(l10n.removePhoto),
                  ),
              ],
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
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: const Color(0xFF303030)),
              decoration: _fieldDecoration(context, l10n.usefulDetails),
            ),
            const SizedBox(height: 8),
            _sectionLabel(context, l10n.notes),
            const SizedBox(height: 4),
            TextFormField(
              controller: _notesController,
              maxLength: 150,
              minLines: 2,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: const Color(0xFF303030)),
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
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _isSaving
                        ? null
                        : () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                    label: Text(l10n.cancel),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _isSaving ? null : _save,
                    icon: const Icon(Icons.check_rounded),
                    label: Text(_isSaving ? l10n.saving : l10n.save),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(BuildContext context, String label) => Text(
    label,
    style: Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
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

  void _clearImage() {
    setState(() {
      _pickedImage = null;
      _draft.clearImageUuid();
    });
  }

  Future<void> _selectImage() async {
    final image = await Navigator.of(context).push<File>(
      MaterialPageRoute(builder: (_) => const CookStepImageSelectionPanel()),
    );
    if (image != null && mounted) {
      setState(() {
        _pickedImage = image;
        _draft.setImageUuid();
      });
    }
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isSaving = true);
    try {
      final transmitted = widget.cookStepTransmittedData;
      if (_pickedImage != null && _draft.image != null) {
        await _storage.writeCookStepImage(
          _pickedImage!,
          transmitted.uuidStringToCreateFolder,
          _draft.image!,
        );
      }
      _draft
        ..title = _titleController.text.trim()
        ..description = _descriptionController.text.trim()
        ..notes = _notesController.text.trim();
      if (!mounted) return;
      context.read<CooklistsBloc>().add(
        CookStepSaved(
          transmitted.uuidStringToCreateFolder,
          transmitted.stepIndex,
          _draft,
        ),
      );
      Navigator.of(context).pop();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.cookL10n.photoSaveError)));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}
