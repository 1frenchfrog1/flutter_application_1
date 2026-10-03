import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/checklists_bloc.dart';
import '../bloc/checklists_event.dart';
import '../datamodel/CheckListDataModel.dart';
import '../datamodel/CheckListFileAccess.dart';
import 'CheckPointImageSelectionPanel.dart';
import '../widgets/checklist_icon_picker.dart';

class CheckPointTransmittedData {
  final ActionObject widgetActionObject;
  final String uuidStringToCreateFolder;
  final int checkpointIndex;

  const CheckPointTransmittedData({
    required this.widgetActionObject,
    required this.uuidStringToCreateFolder,
    required this.checkpointIndex,
  });
}

class CheckPointEditingPanel extends StatefulWidget {
  final CheckPointTransmittedData checkPointTransmittedData;
  static const String routeName = '/editCheckPoint';

  const CheckPointEditingPanel({
    super.key,
    required this.checkPointTransmittedData,
  });

  @override
  State<CheckPointEditingPanel> createState() => _CheckPointEditingPanelState();
}

class _CheckPointEditingPanelState extends State<CheckPointEditingPanel> {
  final _formKey = GlobalKey<FormState>();
  final AppCheckListStorage _storage = AppCheckListStorage();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _notesController;
  late final ActionObject _draft;
  File? _pickedImage;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _draft = widget.checkPointTransmittedData.widgetActionObject.copyAction();
    _titleController = TextEditingController(text: _draft.title);
    _descriptionController = TextEditingController(text: _draft.description);
    _notesController = TextEditingController(text: _draft.notes);
    _loadExistingImage();
  }

  Future<void> _loadExistingImage() async {
    final transmitted = widget.checkPointTransmittedData;
    final image = await _storage.readCheckPointImage(
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
    return Scaffold(
      appBar: AppBar(title: const Text('Modifier le point')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          children: [
            _sectionLabel(context, 'Titre'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _titleController,
              autofocus: true,
              maxLength: 40,
              textCapitalization: TextCapitalization.sentences,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF303030),
              ),
              decoration: _fieldDecoration(context, 'Ex. Passeport'),
              validator: (value) => (value ?? '').trim().isEmpty
                  ? 'Saisissez un titre pour ce point.'
                  : null,
            ),
            const SizedBox(height: 16),
            _sectionLabel(context, 'Icône du point de contrôle'),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: _iconFor(_draft.icon),
              title: const Text('Choisir une icône'),
              subtitle: const Text('Elle apparaîtra dans la liste'),
              trailing: const Icon(Icons.chevron_right),
              onTap: _selectIcon,
            ),
            const SizedBox(height: 16),
            _sectionLabel(context, 'Photo'),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: ColoredBox(
                color: const Color(0xFFF2F2F2),
                child: SizedBox(
                  height: 190,
                  width: double.infinity,
                  child: _pickedImage == null
                      ? const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.image_outlined, size: 36),
                              SizedBox(height: 8),
                              Text('Aucune photo ajoutée'),
                            ],
                          ),
                        )
                      : Image.file(_pickedImage!, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: _selectImage,
                  icon: const Icon(Icons.add_a_photo_outlined),
                  label: Text(
                    _pickedImage == null ? 'Ajouter une photo' : 'Remplacer',
                  ),
                ),
                if (_pickedImage != null)
                  TextButton.icon(
                    onPressed: _clearImage,
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Retirer'),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            _sectionLabel(context, 'Description'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              maxLength: 150,
              minLines: 3,
              maxLines: 6,
              textCapitalization: TextCapitalization.sentences,
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(color: const Color(0xFF303030)),
              decoration: _fieldDecoration(context, 'Détails utiles'),
            ),
            const SizedBox(height: 16),
            _sectionLabel(context, 'Notes'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _notesController,
              maxLength: 150,
              minLines: 2,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(color: const Color(0xFF303030)),
              decoration: _fieldDecoration(context, 'Notes facultatives'),
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
                    label: const Text('Annuler'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _isSaving ? null : _save,
                    icon: const Icon(Icons.check_rounded),
                    label: Text(
                      _isSaving ? 'Enregistrement...' : 'Enregistrer',
                    ),
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
      contentPadding: const EdgeInsets.all(18),
      counterStyle: const TextStyle(color: Color(0xFF777777)),
    );
  }

  Widget _iconFor(dynamic icon) {
    if (icon is FaIconData) return FaIcon(icon);
    if (icon is IconData) return Icon(icon);
    return const Icon(Icons.checklist);
  }

  Future<void> _selectIcon() async {
    final icon = await showChecklistIconPicker(context);
    if (icon != null && mounted) setState(() => _draft.icon = icon);
  }

  void _clearImage() {
    setState(() {
      _pickedImage = null;
      _draft.clearImageUuid();
    });
  }

  Future<void> _selectImage() async {
    final image = await Navigator.of(context).push<File>(
      MaterialPageRoute(builder: (_) => const CheckPointImageSelectionPanel()),
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
      final transmitted = widget.checkPointTransmittedData;
      if (_pickedImage != null && _draft.image != null) {
        await _storage.writeCheckPointImage(
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
      context.read<ChecklistsBloc>().add(
        CheckpointSaved(
          transmitted.uuidStringToCreateFolder,
          transmitted.checkpointIndex,
          _draft,
        ),
      );
      Navigator.of(context).pop();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Impossible d’enregistrer la photo.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}
