import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../datamodel/CheckListDataModel.dart';
import 'ExpansionPanelListTabbedWidget.dart';

class CheckListGridView extends StatelessWidget {
  final List<CheckList> checklists;

  const CheckListGridView({super.key, required this.checklists});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      primary: true,
      padding: const EdgeInsets.all(1),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemCount: checklists.length,
      itemBuilder: (context, index) {
        final checklist = checklists[index];
        return Card(
          key: ValueKey(checklist.uuid),
          elevation: 5,
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ExpansionPanelListTabbedWidget(
                  widgetCheckListObject: checklist,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment(0.9, 0),
                  child: Icon(
                    Icons.cloud,
                    color: Colors.orangeAccent,
                    size: 20,
                  ),
                ),
                _iconFor(checklist.icon),
                Text(checklist.title, textAlign: TextAlign.center),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _iconFor(dynamic icon) {
    if (icon is FaIconData) return FaIcon(icon);
    if (icon is IconData) return Icon(icon);
    return const Icon(Icons.checklist);
  }
}
