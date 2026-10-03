import 'package:flutter/material.dart';

import '../bloc/todo_apptab_states.dart';
import '../screens/todo_tools_screen.dart';
import '../../service-transverse/datamodel/transverse_thisapp_localization.dart';

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
          label: ThisAppLocalizations.of(context).toolsLocalText,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_box),
          label: ThisAppLocalizations.of(context).allLocalText,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_box_outline_blank),
          label: ThisAppLocalizations.of(context).left_To_DoLocalText,
        ),
      ],
    );
  }
}
