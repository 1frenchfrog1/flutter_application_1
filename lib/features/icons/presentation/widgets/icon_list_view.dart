// lib/features/icons/presentation/widgets/icon_list_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/icon_bloc.dart';
import '../bloc/icon_event.dart';
import '../bloc/icon_state.dart';
import 'dynamic_icon_view.dart';

class IconListView extends StatelessWidget {
  const IconListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IconBloc, IconState>(
      builder: (context, state) {
        return switch (state) {
          IconInitial() => const Center(child: Text('Aucune icône chargée.')),
          IconLoading() => const Center(child: CircularProgressIndicator()),
          IconError(:final message) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Impossible de charger les icônes : $message'),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () =>
                      context.read<IconBloc>().add(const FetchIcons()),
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          ),
          IconLoaded(:final icons) when icons.isEmpty => const Center(
            child: Text('Aucune icône disponible.'),
          ),
          IconLoaded(:final icons) => ListView.separated(
            itemCount: icons.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final icon = icons[index];
              return ListTile(
                leading: DynamicIconView(icon: icon),
                title: Text(icon.label ?? icon.key),
                subtitle: Text(icon.category ?? icon.key),
              );
            },
          ),
        };
      },
    );
  }
}
