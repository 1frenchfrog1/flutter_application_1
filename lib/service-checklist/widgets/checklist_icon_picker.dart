// lib/service-checklist/widgets/checklist_icon_picker.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/localization_context.dart';
import '../../features/icons/di/icon_injection.dart';
import '../../features/icons/domain/entities/icon_entity.dart';
import '../../features/icons/presentation/icon_category_localization.dart';
import '../../features/icons/presentation/bloc/icon_bloc.dart';
import '../../features/icons/presentation/bloc/icon_event.dart';
import '../../features/icons/presentation/bloc/icon_state.dart';
import '../../features/icons/presentation/widgets/dynamic_icon_view.dart';

class ChecklistIconView extends StatelessWidget {
  const ChecklistIconView({super.key, required this.icon, this.size});

  final IconEntity icon;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final iconSize = size ?? IconTheme.of(context).size ?? 24;
    return DynamicIconView(icon: icon, size: iconSize);
  }
}

class ChecklistIconPickerDialog extends StatelessWidget {
  const ChecklistIconPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => iconGetIt<IconBloc>()..add(const FetchIcons()),
      child: const _ChecklistIconPickerContent(),
    );
  }
}

class _ChecklistIconPickerContent extends StatefulWidget {
  const _ChecklistIconPickerContent();

  @override
  State<_ChecklistIconPickerContent> createState() =>
      _ChecklistIconPickerContentState();
}

class _ChecklistIconPickerContentState
    extends State<_ChecklistIconPickerContent> {
  final TextEditingController _searchController = TextEditingController();
  String? _activeCategory;
  String _query = '';

  List<String> _categories(List<IconEntity> icons) {
    final categories =
        icons.map((icon) => icon.category).whereType<String>().toSet().toList()
          ..sort();
    return categories;
  }

  List<IconEntity> _filteredIcons(
    List<IconEntity> icons, {
    required String? category,
  }) {
    final query = _normalize(_query);
    return icons
        .where((icon) {
          final matchesCategory =
              category == null || icon.category == category;
          final matchesQuery =
              query.isEmpty ||
              _normalize(icon.label ?? '').contains(query) ||
              _normalize(icon.category ?? '').contains(query);
          return matchesCategory && matchesQuery;
        })
        .toList(growable: false);
  }

  String _normalize(String value) => value
      .trim()
      .toLowerCase()
      .replaceAll(RegExp('[àáâä]'), 'a')
      .replaceAll(RegExp('[èéêë]'), 'e')
      .replaceAll(RegExp('[ìíîï]'), 'i')
      .replaceAll(RegExp('[òóôö]'), 'o')
      .replaceAll(RegExp('[ùúûü]'), 'u')
      .replaceAll('ç', 'c');

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final dialogWidth = (screenSize.width - 48).clamp(280.0, 560.0).toDouble();
    final dialogHeight = (screenSize.height - 180)
        .clamp(300.0, 560.0)
        .toDouble();

    return BlocBuilder<IconBloc, IconState>(
      builder: (context, state) => switch (state) {
        IconInitial() || IconLoading() => const AlertDialog(
          content: SizedBox(
            height: 120,
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
        IconError(:final message) => AlertDialog(
          title: Text(context.l10n.iconLoadingErrorTitle),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => context.read<IconBloc>().add(const FetchIcons()),
              child: Text(context.l10n.retry),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.l10n.close),
            ),
          ],
        ),
        IconLoaded(:final icons) => _buildPicker(
          context,
          icons,
          dialogWidth,
          dialogHeight,
        ),
      },
    );
  }

  Widget _buildPicker(
    BuildContext context,
    List<IconEntity> icons,
    double dialogWidth,
    double dialogHeight,
  ) {
    final categories = _categories(icons);
    final activeCategory = categories.contains(_activeCategory)
        ? _activeCategory
        : null;
    final filteredIcons = _filteredIcons(icons, category: activeCategory);

    return AlertDialog(
      title: Text(context.l10n.checklistIconPickerTitle),
      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      content: SizedBox(
        width: dialogWidth,
        height: dialogHeight,
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: context.l10n.searchIcon,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        tooltip: context.l10n.clearSearch,
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                        icon: const Icon(Icons.close),
                      ),
                filled: true,
                fillColor: const Color(0xFFF2F2F2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length + 1,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = index == 0
                      ? null
                      : categories[index - 1];
                  return ChoiceChip(
                    label: Text(
                      category == null
                          ? context.l10n.allCategories
                          : localizeIconCategory(context.l10n, category),
                    ),
                    selected: category == activeCategory,
                    onSelected: (_) =>
                        setState(() => _activeCategory = category),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: filteredIcons.isEmpty
                  ? Center(child: Text(context.l10n.noIconsFound))
                  : GridView.builder(
                      itemCount: filteredIcons.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 76,
                            mainAxisExtent: 76,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                          ),
                      itemBuilder: (context, index) {
                        final icon = filteredIcons[index];
                        final category = icon.category ?? '';
                        return IconButton.filledTonal(
                          tooltip:
                              '${icon.label ?? icon.key} · ${localizeIconCategory(context.l10n, category)}',
                          onPressed: () => Navigator.of(context).pop(icon),
                          icon: DynamicIconView(icon: icon),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l10n.cancel),
        ),
      ],
    );
  }

}

Future<IconEntity?> showChecklistIconPicker(BuildContext context) {
  return showDialog<IconEntity>(
    context: context,
    builder: (_) => const ChecklistIconPickerDialog(),
  );
}
