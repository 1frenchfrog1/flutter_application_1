import 'dart:convert';

import 'CheckListDataModel.dart';
import 'CheckListFileAccess.dart';

abstract class ChecklistsRepository {
  Future<List<CheckList>> loadChecklists();

  Future<void> saveChecklists(List<CheckList> checklists);
}

class FileChecklistsRepository implements ChecklistsRepository {
  final AppCheckListStorage storage;

  FileChecklistsRepository({AppCheckListStorage? storage})
    : storage = storage ?? AppCheckListStorage();

  @override
  Future<List<CheckList>> loadChecklists() async {
    final contents = await storage.readAllCheckLists();
    if (contents == 'FileNotFound' || contents.isEmpty) {
      return [];
    }

    final decoded = jsonDecode(contents) as Map<String, dynamic>;
    return AppCheckLists.fromJson(decoded).allCheckLists;
  }

  @override
  Future<void> saveChecklists(List<CheckList> checklists) async {
    final contents = jsonEncode(AppCheckLists()..allCheckLists = checklists);
    await storage.writeAllCheckLists(contents);
  }
}
