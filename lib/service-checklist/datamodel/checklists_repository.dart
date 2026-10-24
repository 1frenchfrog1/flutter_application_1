import 'dart:convert';

import '../../features/icons/data/datasources/icon_local_data_source.dart';
import 'CheckListDataModel.dart';
import 'CheckListFileAccess.dart';

abstract class ChecklistsRepository {
  Future<List<CheckList>> loadChecklists();

  Future<void> saveChecklists(List<CheckList> checklists);
}

class FileChecklistsRepository implements ChecklistsRepository {
  final AppCheckListStorage storage;
  final IconLocalDataSource iconDataSource;

  FileChecklistsRepository({
    AppCheckListStorage? storage,
    IconLocalDataSource? iconDataSource,
  }) : storage = storage ?? AppCheckListStorage(),
       iconDataSource = iconDataSource ?? IconLocalDataSourceImpl();

  @override
  Future<List<CheckList>> loadChecklists() async {
    final contents = await storage.readAllCheckLists();
    if (contents == 'FileNotFound' || contents.isEmpty) {
      return [];
    }

    final decoded = jsonDecode(contents) as Map<String, dynamic>;
    final icons = await iconDataSource.fetchIcons();
    final legacyIconKeys = {
      for (final icon in icons)
        if (int.tryParse(icon.glyphName.replaceFirst('0x', ''), radix: 16)
            case final codePoint?)
          '${icon.packageName}|${icon.fontFamily}|${codePoint.toRadixString(16)}':
              icon.key,
    };
    return AppCheckLists.fromJson(
      decoded,
      legacyIconKeys: legacyIconKeys,
    ).allCheckLists;
  }

  @override
  Future<void> saveChecklists(List<CheckList> checklists) async {
    final contents = jsonEncode(AppCheckLists()..allCheckLists = checklists);
    await storage.writeAllCheckLists(contents);
  }
}
