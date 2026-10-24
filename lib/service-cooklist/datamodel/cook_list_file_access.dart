import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CookListStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/V00.01-APPALLCOOKLISTS.json');
  }

  static Future<String> createFolderInAppDocDir(String folderName) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final folder = Directory('${appDocDir.path}/$folderName/');
    if (await folder.exists()) return folder.path;
    return (await folder.create(recursive: true)).path;
  }

  Future<File> writeAllCookLists(String contents) async {
    final file = await _localFile;
    return file.writeAsString(contents);
  }

  Future<File> writeCookStepImage(
    File image,
    String cookListUuid,
    String imageUuid,
  ) async {
    final folder = await createFolderInAppDocDir(cookListUuid);
    return image.copy('$folder/$imageUuid.jpg');
  }

  Future<String> readAllCookLists() async {
    try {
      final file = await _localFile;
      return await file.readAsString();
    } catch (_) {
      return 'FileNotFound';
    }
  }

  Future<File?> readCookStepImage(String cookListUuid, String? imageUuid) async {
    if (imageUuid == null) return null;
    final path = await _localPath;
    return File('$path/$cookListUuid/$imageUuid.jpg');
  }
}
