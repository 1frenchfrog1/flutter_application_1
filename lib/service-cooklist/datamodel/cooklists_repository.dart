import 'dart:convert';

import 'cook_list_data_model.dart';
import 'cook_list_file_access.dart';

abstract class CooklistsRepository {
  Future<List<CookList>> loadCooklists();

  Future<void> saveCooklists(List<CookList> cooklists);
}

class FileCooklistsRepository implements CooklistsRepository {
  final CookListStorage storage;

  FileCooklistsRepository({CookListStorage? storage})
    : storage = storage ?? CookListStorage();

  @override
  Future<List<CookList>> loadCooklists() async {
    final contents = await storage.readAllCookLists();
    if (contents == 'FileNotFound' || contents.isEmpty) return [];

    final decoded = jsonDecode(contents) as Map<String, dynamic>;
    return AppCookLists.fromJson(decoded).allCookLists;
  }

  @override
  Future<void> saveCooklists(List<CookList> cooklists) async {
    final contents = jsonEncode(AppCookLists()..allCookLists = cooklists);
    await storage.writeAllCookLists(contents);
  }
}
