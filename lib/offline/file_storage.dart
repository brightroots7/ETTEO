import 'dart:io';

import 'package:path_provider/path_provider.dart';

const String AUTH_TOKEN_FILENAME = 'authentication_token.json';
const String LOGGED_IN_FILENAME = 'logged.json';
const String MASTER_DATA_SYNC_FILENAME = 'masterdata-sync.json';
const String CACHED_IMAGE_SQFLITE_FILENAME = 'libCachedImageData.db';

/// FileStorage is to read /write authentication file
class FileStorage {
  /// Get the application directory
  Future<String> get _getAppDirectory async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  //. Create file reference for the filename passsed
  Future<File> _getFileReference(
      {String filename = AUTH_TOKEN_FILENAME}) async {
    final path = await _getAppDirectory;
    return File('$path/$filename');
  }

  /// Write the file with name and content.
  Future<File> writeFile(
      {String filename = AUTH_TOKEN_FILENAME, String jsonContent}) async {
    final file = await _getFileReference(filename: filename);

    // Write the file.
    return file.writeAsString('$jsonContent');
  }

  /// Read the file content for the filename specified
  Future<String> readFile({String filename = AUTH_TOKEN_FILENAME}) async {
    try {
      final file = await _getFileReference(filename: filename);
      print(file.path);

      String contents = "";
      // Read the file.
      if (await file.exists()) {
        contents = await file.readAsString();
      }

      return contents;
    } catch (e) {
      // If encountering an error, return 0.
      return "";
    }
  }

  /// Read the file content for the filename specified
  Future<bool> removeFile({String filename = AUTH_TOKEN_FILENAME}) async {
    try {
      final file = await _getFileReference(filename: filename);

      // Read the file.
      FileSystemEntity deletedFile = await file.delete();
      return deletedFile.exists();
    } catch (e) {
      return false;
    }
  }
}
