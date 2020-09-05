import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteHelper{
  factory SqliteHelper() =>_getInstance();
  static SqliteHelper get instance => _getInstance();
  static SqliteHelper _instance;

  Database database;

  SqliteHelper._internal() {
    // 初始化
    this.initDatabase();
  }

  static SqliteHelper _getInstance() {
    if (_instance == null) {
      _instance = new SqliteHelper._internal();
    }
    return _instance;
  }

  void initDatabase() async{
    var databasesPath = await getDatabasesPath();
    String path =join(databasesPath, 'buluoge.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE IF NOT EXISTS Timer(farm text, stone text, wood text)");
        });
  }

  Future<bool> updateDatabase(String sqlString) async{
    int count = await _instance.database.rawUpdate(sqlString,[]);
    if(count > 0){
      return true;
    }else{
      return false;
    }
  }

  Future<List<dynamic>> selectFromDatabase(String sqlString) async{
    List list = await _instance.database.rawQuery(sqlString,[]);
    return list;
  }

  Future<bool> insertDatabase(String sqlString) async{
    int count = await _instance.database.rawInsert(sqlString,[]);
    if(count > 0){
      return true;
    }else{
      return false;
    }
  }


}