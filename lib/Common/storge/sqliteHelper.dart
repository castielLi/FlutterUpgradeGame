import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteHelper{
  factory SqliteHelper() =>_getInstance();
  static SqliteHelper get instance => _getInstance();
  static SqliteHelper _instance;

  Database database;

  SqliteHelper._internal() {
    // 初始化
  }

  static SqliteHelper _getInstance() {
    if (_instance == null) {
      _instance = new SqliteHelper._internal();
    }
    return _instance;
  }

  static setDatabase(String displayName){
    instance.initDatabase(displayName);
  }

  static closeDatabase(){
    instance.database.close();
  }


  void initDatabase(String displayName) async{
    var databasesPath = await getDatabasesPath();
    String path =join(databasesPath + "/" + displayName, 'buluoge.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
           var batch = db.batch();
           db.execute("CREATE TABLE IF NOT EXISTS Timer(farm text, stone text, wood text)");
           db.execute("CREATE TABLE IF NOT EXISTS FightTimer(needWatched int)");
           batch.commit();
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