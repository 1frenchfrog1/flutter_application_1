import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'todo_entity.dart';
import 'todo_repository.dart';

class ToDoFileStorage implements TodosRepository {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const ToDoFileStorage(this.tag, this.getDirectory);

  @override
  Future<List<TodoEntity>> loadTodos() async {
    try {
      final file = await _getLocalFile();
      final string = await file.readAsString();
      final json = JsonDecoder().convert(string);
      final todos = (json['todos'])
          .map<TodoEntity>((todo) => TodoEntity.fromJson(todo))
          .toList();
      return todos;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveTodos(List<TodoEntity> todos) async {
    final file = await _getLocalFile();
    final temporaryFile = File('${file.path}.tmp');
    final textToSave = JsonEncoder().convert({
      'todos': todos.map((todo) => todo.toJson()).toList(),
    });

    try {
      await temporaryFile.writeAsString(textToSave, flush: true);
      await _replaceFile(temporaryFile, file);
    } catch (_) {
      if (await temporaryFile.exists()) {
        await temporaryFile.delete();
      }
      rethrow;
    }
  }

  Future<void> _replaceFile(File temporaryFile, File destinationFile) async {
    try {
      await temporaryFile.rename(destinationFile.path);
    } on FileSystemException {
      // Windows may not replace an existing file during rename.
      if (!await destinationFile.exists()) {
        rethrow;
      }
      await destinationFile.delete();
      await temporaryFile.rename(destinationFile.path);
    }
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();
    return File('${dir.path}/ArchSampleStorage__$tag.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }
}
