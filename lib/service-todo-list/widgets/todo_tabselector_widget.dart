import 'package:flutter/material.dart';

import '../../l10n/localization_context.dart';
import '../bloc/todo_apptab_states.dart';
import '../screens/todo_tools_screen.dart';

class ToDoTabSelector extends StatelessWidget {
  final ToDoAppTab activeTab;
  final Function(ToDoAppTab) onTabSelected;

  const ToDoTabSelector({
    super.key,
    required this.activeTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: ToDoAppTab.values.indexOf(activeTab),
      onTap: (index) {
        if (index == 0) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ToDoToolsScreen();
              },
            ),
          );
        } else {
          onTabSelected(ToDoAppTab.values[index]);
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.build),
          label: context.l10n.tools,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_box),
          label: context.l10n.all,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_box_outline_blank),
          label: context.l10n.leftToDo,
        ),
      ],
    );
  }
}
