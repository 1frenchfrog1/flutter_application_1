import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cooklists_bloc.dart';
import '../bloc/cooklists_event.dart';
import '../bloc/cooklists_state.dart';
import '../datamodel/cook_list_data_model.dart';
import '../l10n/cook_localization_context.dart';
import 'cook_evaluation_panel.dart';
import 'cook_gridview.dart';

class HomeCookList extends StatelessWidget {
  const HomeCookList({super.key});

  static const String routeName = '/HomeCookListRoute';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CooklistsBloc, CooklistsState>(
      builder: (context, state) {
        final List<CookList> cooklists = state is CooklistsLoadSuccess
            ? state.cooklists
            : const [];

        return Scaffold(
          backgroundColor: Colors.grey[600],
          appBar: AppBar(
            backgroundColor: Colors.black26,
            leading: IconButton(
              tooltip: context.cookL10n.homeTooltip,
              icon: const Icon(Icons.home_outlined),
              onPressed: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst),
            ),
            title: Text(
              context.cookL10n.myCooklists,
              style: const TextStyle(color: Colors.orange),
            ),
          ),
          body: state is CooklistsLoadInProgress
              ? const Center(child: CircularProgressIndicator())
              : state is CooklistsLoadFailure
              ? Center(child: Text(context.cookL10n.unableToLoadCooklists))
              : CookListGridView(cooklists: cooklists),
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(child: Text(context.cookL10n.myCooklists)),
                ListTile(
                  leading: const Icon(Icons.assessment),
                  title: Text(context.cookL10n.evaluationTools),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            CookEvaluationPanel(allCookLists: cooklists),
                      ),
                    );
                  },
                ),
                AboutListTile(
                  applicationName: context.cookL10n.myCooklists,
                  applicationVersion: 'v1.0.0',
                ),
              ],
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'cooklist-reload',
                onPressed: () =>
                    context.read<CooklistsBloc>().add(CooklistsLoadRequested()),
                backgroundColor: Colors.orange,
                tooltip: context.cookL10n.reload,
                child: const Icon(Icons.cloud_queue, color: Colors.black),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                heroTag: 'cooklist-add',
                onPressed: () =>
                    context.read<CooklistsBloc>().add(CooklistCreated()),
                backgroundColor: Colors.orange,
                tooltip: context.cookL10n.addCooklist,
                child: const Icon(Icons.add, color: Colors.black),
              ),
            ],
          ),
        );
      },
    );
  }
}
