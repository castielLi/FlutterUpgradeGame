import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

/// 本地文件存储
class FileStorage {

  /// 按照文件路径名称读取文件
  static Future<dynamic> getContent(String fileName) async{

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    File file = new File('$appDocPath/$fileName');
    if(file.existsSync()) {
      String content = await file.readAsString();
      return content;
    }else{
      return "";
    }
  }

  /// 按照文件路径名称储存文件
  static saveContent(String content,String fileName) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    File file = new File('$appDocPath/$fileName');
    if(!file.existsSync()) {
      file.createSync();
      try {
        writeToFile(file, content);
      } catch (e) {
        print(e);
      }
    }
  }

  static writeToFile(File file, String notes) async {
    File fileRule = await file.writeAsString(notes);
    if(fileRule.existsSync()) {
      print("文件存储成功");
    }
  }
}
