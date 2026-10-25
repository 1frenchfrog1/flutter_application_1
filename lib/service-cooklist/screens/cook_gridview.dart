import 'package:flutter/material.dart';

import '../datamodel/cook_list_data_model.dart';
import '../widgets/cook_classification_line.dart';
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
            child: Stack(
              children: [
                const Positioned(
                  top: 4,
                  right: 6,
                  child: Icon(
                    Icons.cloud,
                    color: Colors.orangeAccent,
                    size: 20,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Center(child: CookIconView(icon: cooklist.icon)),
                    const SizedBox(height: 12),
                    Text(cooklist.title, textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    Center(
                      child: CookClassificationLine(
                        cooklist: cooklist,
                        textAlign: TextAlign.center,
                        stacked: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
