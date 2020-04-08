import 'dart:io';

import 'package:etteo_demo/helpers/file_helper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<File> compressImageFile(File src) async {
  File destFile = await getTempFile(src);
  print('DEST FILE');
  print(destFile.absolute.path);

  try {
    List<int> bytes = await FlutterImageCompress.compressWithFile(
      src.absolute.path,
      quality: 50,
      minHeight: 1920,
      minWidth: 1080,
    );
    destFile.writeAsBytesSync(bytes);
    print('DEST FILE COMPRESSED');
    print(destFile.absolute.path);
    return Future.value(destFile);
  } catch (_) {
    return src;
  }
}
