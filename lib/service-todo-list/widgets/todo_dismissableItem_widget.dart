import 'package:flutter/material.dart';

import '../datamodel/todo_models.dart';

class TodoItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final ToDoActionModel todo;

  const TodoItem({
    super.key,
    required this.onDismissed,
    required this.onTap,
    required this.onCheckboxChanged,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(todo.id),
      onDismissed: onDismissed,
      background: _DismissBackground(
        alignment: Alignment.centerLeft,
        icon: Icons.delete_outline_rounded,
      ),
      secondaryBackground: _DismissBackground(
        alignment: Alignment.centerRight,
        icon: Icons.delete_outline_rounded,
      ),
      child: Card(
        color: Colors.white,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          onTap: onTap,
          leading: Checkbox(
            value: todo.state,
            onChanged: (value) => onCheckboxChanged(value ?? false),
          ),
          title: Text(
            todo.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF303030),
              decoration: todo.state ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF555555),
          ),
        ),
      ),
    );
  }
}

class _DismissBackground extends StatelessWidget {
  final Alignment alignment;
  final IconData icon;

  const _DismissBackground({required this.alignment, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Icon(icon, color: Theme.of(context).colorScheme.onErrorContainer),
    );
  }
}
