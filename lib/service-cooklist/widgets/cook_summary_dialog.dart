import 'package:flutter/material.dart';

import '../datamodel/cook_list_data_model.dart';

const _labels = {
  'fr': (
    'Bilan de la recette',
    'Ingrédients',
    'Ustensiles & outils',
    'Aucun ingrédient',
    'Aucun ustensile',
    'Fermer',
    'Afficher le bilan',
  ),
  'en': (
    'Recipe summary',
    'Ingredients',
    'Utensils & tools',
    'No ingredients',
    'No utensils',
    'Close',
    'Show summary',
  ),
  'de': (
    'Rezeptübersicht',
    'Zutaten',
    'Utensilien & Werkzeuge',
    'Keine Zutaten',
    'Keine Utensilien',
    'Schließen',
    'Übersicht anzeigen',
  ),
  'es': (
    'Resumen de la receta',
    'Ingredientes',
    'Utensilios y herramientas',
    'Sin ingredientes',
    'Sin utensilios',
    'Cerrar',
    'Mostrar resumen',
  ),
  'it': (
    'Riepilogo della ricetta',
    'Ingredienti',
    'Utensili e strumenti',
    'Nessun ingrediente',
    'Nessun utensile',
    'Chiudi',
    'Mostra riepilogo',
  ),
};

(String, String, String, String, String, String, String) cookSummaryLabels(
  BuildContext context,
) => _labels[Localizations.localeOf(context).languageCode] ?? _labels['en']!;

/// Totals ingredients (same name and unit, case-insensitive) and lists
/// distinct utensils across every step of [cooklist].
Future<void> showCookSummaryDialog(BuildContext context, CookList cooklist) {
  final ingredients = <String, CookIngredient>{};
  final utensils = <String, String>{};
  for (final step in cooklist.cookSteps) {
    for (final ingredient in step.ingredients) {
      final name = ingredient.name.trim();
      if (name.isEmpty) continue;
      final unit = ingredient.unit.trim();
      final key = '${name.toLowerCase()}|${unit.toLowerCase()}';
      final existing = ingredients[key];
      if (existing == null) {
        ingredients[key] = CookIngredient(
          name: name,
          quantity: ingredient.quantity,
          unit: unit,
        );
      } else {
        existing.quantity += ingredient.quantity;
      }
    }
    for (final utensil in step.utensils) {
      final name = utensil.trim();
      if (name.isNotEmpty) utensils.putIfAbsent(name.toLowerCase(), () => name);
    }
  }

  final labels = cookSummaryLabels(context);
  final headerStyle = Theme.of(context).textTheme.titleMedium
      ?.copyWith(fontWeight: FontWeight.bold);

  return showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
      contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      title: Text(labels.$1),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(labels.$2, style: headerStyle),
                      const SizedBox(height: 4),
                      if (ingredients.isEmpty) Text(labels.$4),
                      for (final ingredient in ingredients.values)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: Text(ingredient.name)),
                              if (ingredient.quantity > 0) ...[
                                const SizedBox(width: 6),
                                Text(ingredient.quantityWithUnit),
                              ],
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                const VerticalDivider(width: 24, thickness: 2),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        labels.$3,
                        style: headerStyle,
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 4),
                      if (utensils.isEmpty)
                        Text(labels.$5, textAlign: TextAlign.right),
                      for (final utensil in utensils.values)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(utensil, textAlign: TextAlign.right),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(labels.$6),
        ),
      ],
    ),
  );
}
