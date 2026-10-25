import 'package:flutter/material.dart';

import '../datamodel/cook_name_suggestions.dart';
import '../l10n/cook_localization_context.dart';

class CookUtensilEditingPanel extends StatefulWidget {
  final String utensil;

  const CookUtensilEditingPanel({super.key, required this.utensil});

  @override
  State<CookUtensilEditingPanel> createState() =>
      _CookUtensilEditingPanelState();
}

class _CookUtensilEditingPanelState extends State<CookUtensilEditingPanel> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  final _nameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.utensil);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    Navigator.of(context).pop(_nameController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.cookL10n;
    final suggestions = cookUtensilSuggestions(
      Localizations.localeOf(context).languageCode,
    );
    return Scaffold(
      appBar: AppBar(title: Text(l10n.editUtensil)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          children: [
            Autocomplete<String>(
              optionsBuilder: (textEditingValue) {
                final query = textEditingValue.text.trim().toLowerCase();
                if (query.isEmpty) return const Iterable<String>.empty();
                return suggestions
                    .where((name) => name.toLowerCase().contains(query))
                    .take(8);
              },
              onSelected: (value) => _nameController.text = value,
              fieldViewBuilder:
                  (context, controller, focusNode, onFieldSubmitted) =>
                      TextFormField(
                        controller: controller,
                        focusNode: focusNode,
                        autofocus: true,
                        maxLength: 40,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: l10n.utensilName,
                          hintText: l10n.utensilNameExample,
                        ),
                        validator: (value) => (value ?? '').trim().isEmpty
                            ? l10n.utensilNameRequired
                            : null,
                        onFieldSubmitted: (_) {
                          onFieldSubmitted();
                          _save();
                        },
                      ),
              textEditingController: _nameController,
              focusNode: _nameFocusNode,
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
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                    label: Text(l10n.cancel),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _save,
                    icon: const Icon(Icons.check_rounded),
                    label: Text(l10n.save),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
