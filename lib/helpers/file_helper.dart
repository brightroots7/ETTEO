import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<File> saveFile(ByteData byteData, String name) async {
  Uint8List byteUint8List = byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);

  List<int> bytes = byteUint8List.cast<int>();

  Directory appDirectory = await getApplicationDocumentsDirectory();
  File destFile = File('${appDirectory.absolute.path}/$name');
  destFile.createSync(recursive: true);
  destFile.writeAsBytesSync(bytes);
  return destFile;
}

// Get the dest file name by adding -c to the source to denote it is compressed.
Future<File> getTempFile(File src) async {
  Directory appDirectory = await getApplicationDocumentsDirectory();
  String srcPath = src.absolute.path;

  String srcFileName =
      srcPath.substring(srcPath.lastIndexOf('/') + 1, srcPath.lastIndexOf('.'));
  String srcFileNameExtn =
      srcPath.substring(srcPath.lastIndexOf('.'), srcPath.length);
  String destFileName = srcFileName + '-temp' + srcFileNameExtn;
  File destFile = File('$appDirectory/temp/$destFileName');

  return destFile;
}
