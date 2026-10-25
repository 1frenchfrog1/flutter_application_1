import 'package:flutter/material.dart';

import '../datamodel/cook_list_data_model.dart';
import '../datamodel/cook_name_suggestions.dart';
import '../l10n/cook_localization_context.dart';

class CookIngredientEditingPanel extends StatefulWidget {
  final CookIngredient ingredient;

  const CookIngredientEditingPanel({super.key, required this.ingredient});

  @override
  State<CookIngredientEditingPanel> createState() =>
      _CookIngredientEditingPanelState();
}

class _CookIngredientEditingPanelState
    extends State<CookIngredientEditingPanel> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  final _nameFocusNode = FocusNode();
  late final TextEditingController _quantityController;
  late final TextEditingController _unitController;

  @override
  void initState() {
    super.initState();
    final ingredient = widget.ingredient;
    _nameController = TextEditingController(text: ingredient.name);
    _quantityController = TextEditingController(
      text: ingredient.quantity == 0 ? '' : ingredient.formattedQuantity,
    );
    _unitController = TextEditingController(text: ingredient.unit);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  double? _parseQuantity(String text) =>
      double.tryParse(text.trim().replaceAll(',', '.'));

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    Navigator.of(context).pop(
      CookIngredient(
        name: _nameController.text.trim(),
        quantity: _parseQuantity(_quantityController.text) ?? 0,
        unit: _unitController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.cookL10n;
    final suggestions = cookIngredientSuggestions(
      Localizations.localeOf(context).languageCode,
    );
    return Scaffold(
      appBar: AppBar(title: Text(l10n.editIngredient)),
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
                          labelText: l10n.ingredientName,
                          hintText: l10n.ingredientNameExample,
                        ),
                        validator: (value) => (value ?? '').trim().isEmpty
                            ? l10n.ingredientNameRequired
                            : null,
                        onFieldSubmitted: (_) => onFieldSubmitted(),
                      ),
              textEditingController: _nameController,
              focusNode: _nameFocusNode,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _quantityController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(labelText: l10n.ingredientQuantity),
              validator: (value) {
                final text = (value ?? '').trim();
                if (text.isEmpty) return null;
                final parsed = _parseQuantity(text);
                return parsed == null || parsed < 0 || !parsed.isFinite
                    ? l10n.ingredientQuantityInvalid
                    : null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _unitController,
              maxLength: 20,
              decoration: InputDecoration(labelText: l10n.ingredientUnit),
            ),
            Wrap(
              spacing: 8,
              children: [
                for (final unit in commonIngredientUnits)
                  ActionChip(
                    label: Text(unit),
                    onPressed: () => _unitController.text = unit,
                  ),
              ],
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
