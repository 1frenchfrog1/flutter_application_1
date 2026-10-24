// lib/features/icons/presentation/pages/icon_catalog_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/localization_context.dart';
import '../../di/icon_injection.dart';
import '../bloc/icon_bloc.dart';
import '../bloc/icon_event.dart';
import '../widgets/icon_list_view.dart';

class IconCatalogPage extends StatelessWidget {
  const IconCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => iconGetIt<IconBloc>()..add(const FetchIcons()),
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.iconCatalog)),
        body: const IconListView(),
      ),
    );
  }
}
