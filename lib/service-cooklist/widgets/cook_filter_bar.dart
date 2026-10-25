import 'package:flutter/material.dart';

import '../datamodel/cook_classification.dart';
import '../datamodel/cook_list_data_model.dart';

class CookFilter {
  const CookFilter({this.servings, this.type, this.genre});

  final int? servings;
  final CookType? type;
  final String? genre;

  bool get isEmpty => servings == null && type == null && genre == null;

  bool matches(CookList cooklist) =>
      (servings == null || cooklist.servings == servings) &&
      (type == null || cooklist.type == type) &&
      (genre == null ||
          cooklist.labels.any((l) => l.toLowerCase() == genre!.toLowerCase()));

  List<CookList> apply(List<CookList> cooklists) =>
      isEmpty ? cooklists : cooklists.where(matches).toList();
}

const _allLabels = {
  'fr': 'Tous',
  'en': 'All',
  'de': 'Alle',
  'es': 'Todos',
  'it': 'Tutti',
};

/// Bottom bar to filter cooklists by servings, type and genre.
class CookFilterBar extends StatelessWidget {
  const CookFilterBar({
    super.key,
    required this.cooklists,
    required this.filter,
    required this.onChanged,
  });

  final List<CookList> cooklists;
  final CookFilter filter;
  final ValueChanged<CookFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final labels = cookClassificationLabels(languageCode);
    final all = _allLabels[languageCode] ?? _allLabels['en']!;

    final servings = ({for (final c in cooklists) c.servings}.toList()..sort());
    final genres = <String, String>{
      for (final c in cooklists)
        for (final l in c.labels) l.toLowerCase(): l,
    }.values.toList()..sort();

    Widget dropdown<T>({
      required String label,
      required T? value,
      required List<T> items,
      required String Function(T) text,
      required void Function(T?) onSelected,
    }) {
      return Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 4),
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white70,
                ),
              ),
            ),
            DropdownButtonFormField<T?>(
              initialValue: items.contains(value) ? value : null,
              isExpanded: true,
              isDense: true,
              decoration: const InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Color(0xFF616161),
                border: OutlineInputBorder(),
              ),
              dropdownColor: const Color(0xFF616161),
              iconEnabledColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              items: [
                DropdownMenuItem<T?>(value: null, child: Text(all)),
                for (final item in items)
                  DropdownMenuItem<T?>(
                    value: item,
                    child: Text(text(item), overflow: TextOverflow.ellipsis),
                  ),
              ],
              onChanged: onSelected,
            ),
          ],
        ),
      );
    }

    return Material(
      color: Colors.black26,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Row(
            children: [
              dropdown<int>(
                label: labels.servings,
                value: filter.servings,
                items: servings,
                text: (n) => '$n',
                onSelected: (v) => onChanged(
                  CookFilter(
                    servings: v,
                    type: filter.type,
                    genre: filter.genre,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              dropdown<CookType>(
                label: labels.type,
                value: filter.type,
                items: CookType.values,
                text: labels.typeLabel,
                onSelected: (v) => onChanged(
                  CookFilter(
                    servings: filter.servings,
                    type: v,
                    genre: filter.genre,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              dropdown<String>(
                label: labels.genre,
                value: filter.genre,
                items: genres,
                text: (g) => g,
                onSelected: (v) => onChanged(
                  CookFilter(
                    servings: filter.servings,
                    type: filter.type,
                    genre: v,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
