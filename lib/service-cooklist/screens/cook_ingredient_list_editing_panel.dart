import 'package:flutter/material.dart';

import '../datamodel/cook_list_data_model.dart';
import '../l10n/cook_localization_context.dart';
import 'cook_ingredient_editing_panel.dart';

/// Edits a working copy of the ingredients and returns it on back navigation.
class CookIngredientListEditingPanel extends StatefulWidget {
  final String stepTitle;
  final List<CookIngredient> ingredients;

  const CookIngredientListEditingPanel({
    super.key,
    required this.stepTitle,
    required this.ingredients,
  });

  @override
  State<CookIngredientListEditingPanel> createState() =>
      _CookIngredientListEditingPanelState();
}

class _CookIngredientListEditingPanelState
    extends State<CookIngredientListEditingPanel> {
  late final List<CookIngredient> _ingredients = widget.ingredients
      .map((ingredient) => ingredient.copy())
      .toList();
  int? _selectedIndex;

  Future<CookIngredient?> _edit(CookIngredient ingredient) =>
      Navigator.of(context).push<CookIngredient>(
        MaterialPageRoute(
          builder: (_) => CookIngredientEditingPanel(ingredient: ingredient),
        ),
      );

  Future<void> _add() async {
    final created = await _edit(CookIngredient());
    if (created == null || !mounted) return;
    setState(() {
      final index = _selectedIndex;
      if (index == null) {
        _ingredients.add(created);
      } else {
        _ingredients.insert(index + 1, created);
      }
      _selectedIndex = null;
    });
  }

  Future<void> _editAt(int index) async {
    final updated = await _edit(_ingredients[index]);
    if (updated != null && mounted) {
      setState(() => _ingredients[index] = updated);
    }
  }

  Future<void> _confirmDelete() async {
    final index = _selectedIndex;
    if (index == null) return;
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.cookL10n.deleteIngredientConfirmation),
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
        _ingredients.removeAt(index);
        _selectedIndex = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<List<CookIngredient>>(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Navigator.of(context).pop(_ingredients);
      },
      child: Scaffold(
        backgroundColor: Colors.grey[600],
        appBar: AppBar(
          backgroundColor: Colors.black26,
          title: Text('${widget.stepTitle} - ${context.cookL10n.ingredients}'),
        ),
        body: ReorderableListView.builder(
          itemCount: _ingredients.length,
          padding: const EdgeInsets.only(top: 8),
          onReorderItem: (oldIndex, newIndex) => setState(() {
            _ingredients.insert(newIndex, _ingredients.removeAt(oldIndex));
            _selectedIndex = null;
          }),
          itemBuilder: (context, index) {
            final ingredient = _ingredients[index];
            return Card(
              key: ObjectKey(ingredient),
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
                title: Text(ingredient.name),
                subtitle: Text(ingredient.quantityWithUnit),
                trailing: IconButton(
                  tooltip: context.cookL10n.editIngredient,
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
              heroTag: 'cookingredient-delete',
              tooltip: context.cookL10n.removeIngredient,
              backgroundColor: Colors.orange,
              onPressed: _selectedIndex == null ? null : _confirmDelete,
              child: const Icon(Icons.remove, color: Colors.black),
            ),
            const SizedBox(width: 8),
            FloatingActionButton(
              heroTag: 'cookingredient-add',
              tooltip: context.cookL10n.addIngredient,
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
