import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

/// 本地文件存储
class FileStorage {
  static save(String content) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    try {
      File file = new File(appDocPath);
      file.writeAsString("$file");
    } catch(e) {
      print(e);
    }
  }
}
