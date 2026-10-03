import 'package:flutter/material.dart';

import '../datamodel/todo_models.dart';

import '../../service-transverse/datamodel/transverse_thisapp_localization.dart';

typedef OnSaveCallback = Function(String title, String description);

class AddEditScreen extends StatefulWidget {
  final OnSaveCallback onSave;
  final bool isEditing;
  final ToDoActionModel? todo;

  const AddEditScreen({
    super.key,
    required this.onSave,
    required this.isEditing,
    this.todo,
  });

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing
              ? ThisAppLocalizations.of(context).edit_ToDoLocalText
              : ThisAppLocalizations.of(context).add_new_ToDoLocalText,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Titre',
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: isEditing ? widget.todo?.title ?? '' : '',
                autofocus: !isEditing,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF303030),
                ),
                textCapitalization: TextCapitalization.sentences,
                decoration: _fieldDecoration(
                  context,
                  ThisAppLocalizations.of(context).enter_new_ToDoLocalText,
                ),
                validator: (val) {
                  return (val ?? '').trim().isEmpty ? 'is empty' : null;
                },
                onSaved: (value) => _title = value ?? '',
              ),
              const SizedBox(height: 20),
              Text(
                'Points à traiter',
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: TextFormField(
                  initialValue: isEditing ? widget.todo?.description ?? '' : '',
                  expands: true,
                  maxLines: null,
                  style: Theme.of(context).textTheme.bodyLarge
                      ?.copyWith(color: const Color(0xFF303030)),
                  textAlignVertical: TextAlignVertical.top,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: _fieldDecoration(
                    context,
                    ThisAppLocalizations.of(context).enter_descriptionLocalText,
                  ),
                  onSaved: (value) => _description = value ?? '',
                ),
              ),
            ],
          ),
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
              icon: Icon(isEditing ? Icons.check_rounded : Icons.add_rounded),
              label: Text(isEditing ? 'Enregistrer' : 'Ajouter la todo'),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  widget.onSave(_title, _description);
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

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
    );
  }
}
