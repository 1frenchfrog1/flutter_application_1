import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class AppCheckListStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/V00.01-APPALLCHECKLISTS.json');
  }

  static Future<String> createFolderInAppDocDir(String folderName) async {
    //Get this App Document Directory
    final Directory _appDocDir = await getApplicationDocumentsDirectory();
    //App Document Directory + folder name
    final Directory _appDocDirFolder = Directory(
      '${_appDocDir.path}/$folderName/',
    );

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder = await _appDocDirFolder.create(
        recursive: true,
      );
      return _appDocDirNewFolder.path;
    }
  }

  Future<File> writeAllCheckLists(String contents) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(contents);
  }

  Future<File> writeCheckPointImage(
    File image,
    String checkListUuid,
    String imageUuid,
  ) async {
    String folderInAppDocDir = await createFolderInAppDocDir(checkListUuid);
    final File newImage = await image.copy('$folderInAppDocDir/$imageUuid.jpg');
    return newImage;
  }

  Future<String> readAllCheckLists() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return empty string
      return 'FileNotFound';
    }
  }

  Future<File?> readCheckPointImage(
    String checkListUuid,
    String? imageUuid,
  ) async {
    if (imageUuid != null) {
      try {
        final path = await _localPath;
        return File('$path/$checkListUuid/$imageUuid.jpg');
      } catch (e) {
        // If encountering an error, return empty string
        print("ERROR IN ACCESSING FILE - NO DATA FOUND");
        return null;
      }
    } else {
      return null;
    }
  }
}
