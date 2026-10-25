import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cooklists_bloc.dart';
import '../bloc/cooklists_event.dart';
import '../bloc/cooklists_state.dart';
import '../datamodel/cook_list_data_model.dart';
import '../datamodel/cook_list_file_access.dart';
import '../l10n/cook_localization_context.dart';
import '../widgets/cook_classification_line.dart';
import '../widgets/cook_icon_picker.dart';
import '../widgets/cook_summary_dialog.dart';
import 'cook_list_editing_panel.dart';

class CookExpansionPanelListTabbedWidget extends StatefulWidget {
  static const String routeName = '/cookTabs';
  final CookList widgetCookList;

  const CookExpansionPanelListTabbedWidget({
    super.key,
    required this.widgetCookList,
  });

  @override
  State<CookExpansionPanelListTabbedWidget> createState() =>
      _CookExpansionPanelListTabbedWidgetState();
}

class _CookExpansionPanelListTabbedWidgetState
    extends State<CookExpansionPanelListTabbedWidget> {
  final PageController _pageController = PageController(initialPage: 1);
  final CookListStorage _storage = CookListStorage();
  final Map<String, Future<File?>> _imageLoads = {};
  int _selectedIndex = 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CooklistsBloc, CooklistsState>(
      builder: (context, state) {
        if (state is CooklistsLoadInProgress) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is CooklistsLoadFailure) {
          return Scaffold(
            body: Center(child: Text(context.cookL10n.unableToLoadCooklists)),
          );
        }
        if (state is! CooklistsLoadSuccess) {
          return const SizedBox.shrink();
        }

        final cooklist = state.cooklists.firstWhere(
          (item) => item.uuid == widget.widgetCookList.uuid,
          orElse: () => widget.widgetCookList,
        );
        return Scaffold(
          backgroundColor: Colors.grey[600],
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) => setState(() => _selectedIndex = index),
            children: [
              CookListEditingPanel(widgetCookList: cooklist),
              _stepList(cooklist, showCompleted: true),
              _stepList(cooklist, showCompleted: false),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black26,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.build),
                label: context.cookL10n.tools,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.check_box),
                label: context.cookL10n.all,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.check_box_outline_blank),
                label: context.cookL10n.leftToDo,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.white70,
            onTap: (index) {
              setState(() => _selectedIndex = index);
              _pageController.jumpToPage(index);
            },
          ),
        );
      },
    );
  }

  Widget _classificationLine(CookList cooklist) {
    return CookClassificationLine(cooklist: cooklist, color: Colors.white70);
  }

  Widget _stepList(CookList cooklist, {required bool showCompleted}) {
    final indexedSteps = cooklist.cookSteps
        .asMap()
        .entries
        .where((entry) => showCompleted || !entry.value.state)
        .toList(growable: false);

    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Row(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(cooklist.title, overflow: TextOverflow.ellipsis),
                  _classificationLine(cooklist),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_drop_down),
              tooltip: cookSummaryLabels(context).$7,
              onPressed: () => showCookSummaryDialog(context, cooklist),
            ),
          ],
        ),
        actions: [_ProgressIndicator(cooklist: cooklist)],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 8),
        itemCount: indexedSteps.length,
        itemBuilder: (context, visibleIndex) {
          final entry = indexedSteps[visibleIndex];
          final step = entry.value;
          final hasDescription = step.description.trim().isNotEmpty;
          final hasNotes = step.notes.trim().isNotEmpty;
          final hasIngredients = step.ingredients.isNotEmpty;
          final hasUtensils = step.utensils.isNotEmpty;
          final hasDetails =
              hasDescription ||
              hasNotes ||
              hasIngredients ||
              hasUtensils ||
              step.image != null;
          final trailingCheckbox = Checkbox(
            value: step.state,
            activeColor: Colors.orange,
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: (value) {
              context.read<CooklistsBloc>().add(
                CookStepStateChanged(cooklist.uuid, entry.key, value ?? false),
              );
            },
          );
          return Card(
            key: ValueKey('${cooklist.uuid}-${entry.key}'),
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            child: hasDetails
                ? ExpansionTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    tilePadding: const EdgeInsets.symmetric(horizontal: 8),
                    childrenPadding: EdgeInsets.zero,
                    leading: CookIconView(icon: step.icon),
                    title: _stepTitle(
                      context,
                      step.title,
                      showDetailsIndicator: true,
                    ),
                    trailing: trailingCheckbox,
                    children: [
                      if (step.image != null)
                        FutureBuilder<File?>(
                          future: _imageLoads.putIfAbsent(
                            '${cooklist.uuid}/${step.image}',
                            () => _storage.readCookStepImage(
                              cooklist.uuid,
                              step.image,
                            ),
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return const SizedBox.shrink();
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.file(
                                snapshot.data!,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      if (hasDescription || hasNotes)
                        ListTile(
                          title: hasDescription
                              ? Text(step.description.trim())
                              : null,
                          subtitle: hasNotes
                              ? Text(
                                  context.cookL10n.notesLabel(
                                    step.notes.trim(),
                                  ),
                                )
                              : null,
                        ),
                      if (hasIngredients || hasUtensils)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (hasIngredients) ...[
                                      _columnTitle(
                                        context,
                                        context.cookL10n.ingredients,
                                      ),
                                      for (final ingredient in step.ingredients)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 1,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  ingredient.name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              Text(ingredient.quantityWithUnit),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (hasUtensils) ...[
                                      _columnTitle(
                                        context,
                                        context.cookL10n.utensils,
                                      ),
                                      for (final utensil in step.utensils)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 1,
                                          ),
                                          child: Text(utensil),
                                        ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  )
                : ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    leading: CookIconView(icon: step.icon),
                    title: _stepTitle(context, step.title),
                    trailing: trailingCheckbox,
                  ),
          );
        },
      ),
    );
  }

  Widget _columnTitle(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Text(
      text,
      style: Theme.of(context).textTheme.titleSmall
          ?.copyWith(fontWeight: FontWeight.w700),
    ),
  );

  Widget _stepTitle(
    BuildContext context,
    String title, {
    bool showDetailsIndicator = false,
  }) {
    final style = Theme.of(context).textTheme.titleMedium
        ?.copyWith(fontSize: 17);
    if (!showDetailsIndicator) return Text(title, style: style);

    return Row(
      children: [
        Flexible(
          child: Text(title, style: style, overflow: TextOverflow.ellipsis),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Icon(Icons.keyboard_arrow_down, size: 18, color: style?.color),
        ),
      ],
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  final CookList cooklist;

  const _ProgressIndicator({required this.cooklist});

  @override
  Widget build(BuildContext context) {
    final total = cooklist.cookSteps.length;
    final checked = cooklist.cookSteps.where((step) => step.state).length;
    final progress = total == 0 ? 0.0 : checked / total;

    return SizedBox(
      width: 76,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(value: progress),
            Text('$checked/$total'),
          ],
        ),
      ),
    );
  }
}
