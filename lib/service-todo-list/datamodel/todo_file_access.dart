import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class AppToDoStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/V00.01-APPTODO.json');
  }

  static Future<String> createFolderInAppDocDir(String folderName) async {
    //Get this App Document Directory
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    //App Document Directory + folder name
    final Directory appDocDirFolder = Directory(
      '${appDocDir.path}/$folderName/',
    );

    if (await appDocDirFolder.exists()) {
      //if folder already exists return path
      return appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory appDocDirNewFolder = await appDocDirFolder.create(
        recursive: true,
      );
      return appDocDirNewFolder.path;
    }
  }

  Future<File> writeAllToDoLists(String contents) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(contents);
  }

  Future<File> writeToDoImage(
    File image,
    String checkListUuid,
    String imageUuid,
  ) async {
    String folderInAppDocDir = await createFolderInAppDocDir(checkListUuid);
    final File newImage = await image.copy('$folderInAppDocDir/$imageUuid.jpg');
    return newImage;
  }

  Future<String> readAllToDoLists() async {
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

  Future<File?> readToDoImage(String checkListUuid, String imageUuid) async {
    try {
      final path = await _localPath;
      return File('$path/$checkListUuid/$imageUuid.jpg');
    } catch (e) {
      // If encountering an error, return empty string
      return null;
    }
  }
}
