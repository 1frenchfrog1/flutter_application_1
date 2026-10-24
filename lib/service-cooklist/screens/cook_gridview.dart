import 'package:flutter/material.dart';

import '../datamodel/cook_list_data_model.dart';
import '../widgets/cook_icon_picker.dart';
import 'cook_expansion_panel_list_tabbed_widget.dart';

class CookListGridView extends StatelessWidget {
  final List<CookList> cooklists;

  const CookListGridView({super.key, required this.cooklists});

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
      itemCount: cooklists.length,
      itemBuilder: (context, index) {
        final cooklist = cooklists[index];
        return Card(
          key: ValueKey(cooklist.uuid),
          elevation: 5,
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CookExpansionPanelListTabbedWidget(
                  widgetCookList: cooklist,
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
                CookIconView(icon: cooklist.icon),
                Text(cooklist.title, textAlign: TextAlign.center),
              ],
            ),
          ),
        );
      },
    );
  }
}
