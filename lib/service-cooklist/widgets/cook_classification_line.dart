import 'package:flutter/material.dart';

import '../datamodel/cook_classification.dart';
import '../datamodel/cook_list_data_model.dart';

/// "4 👤 · Plat · pizza": servings, type and genre of a cooklist.
class CookClassificationLine extends StatelessWidget {
  final CookList cooklist;
  final Color? color;
  final TextAlign textAlign;
  final MainAxisAlignment alignment;
  final bool stacked;

  const CookClassificationLine({
    super.key,
    required this.cooklist,
    this.color,
    this.textAlign = TextAlign.start,
    this.alignment = MainAxisAlignment.start,
    this.stacked = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? Theme.of(context).textTheme.labelMedium?.color;
    final style = Theme.of(
      context,
    ).textTheme.labelMedium?.copyWith(color: color);
    final labels = cookClassificationLabels(
      Localizations.localeOf(context).languageCode,
    );
    final genre = cooklist.labels.join(', ');
    final rest = [
      if (cooklist.type != null) labels.typeLabel(cooklist.type!),
      if (genre.isNotEmpty) genre,
    ].join(' · ');
    if (stacked) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${cooklist.servings}', style: style),
              Icon(Icons.person, size: 16, color: color),
            ],
          ),
          if (cooklist.type != null)
            Text(
              labels.typeLabel(cooklist.type!),
              overflow: TextOverflow.ellipsis,
              style: style,
            ),
          if (genre.isNotEmpty)
            Text(
              genre,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: style,
            ),
        ],
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: alignment,
      children: [
        Text('${cooklist.servings}', style: style),
        Icon(Icons.person, size: 16, color: color),
        if (rest.isNotEmpty)
          Flexible(
            child: Text(
              ' · $rest',
              overflow: TextOverflow.ellipsis,
              textAlign: textAlign,
              style: style,
            ),
          ),
      ],
    );
  }
}
