
import 'package:upgradegame/Common/storge/sqliteHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:upgradegame/Src/common/model/enum/adTypeEnum.dart';

class AdTimer{
  factory AdTimer() =>_getInstance();
  static AdTimer get instance => _getInstance();
  static AdTimer _instance;

  SqliteHelper adTimerDatabase;

  AdTimer._internal() {
    // 初始化
    adTimerDatabase = SqliteHelper();
  }

  static AdTimer _getInstance() {
    if (_instance == null) {
      _instance = new AdTimer._internal();
    }
    return _instance;
  }

  static initCurrentDatabase(String displayName){
    SqliteHelper.setDatabase(displayName);
  }

  static logoutAdTime(){
    SqliteHelper.closeDatabase();
    _instance = null;
  }

  static Future<bool> UpdateAdTime(AdTypeEnum type , String time) async{
    String sqlstring = "";
    switch(type){
      case AdTypeEnum.farm:
        sqlstring = "update Timer set farm = " + time ;
        break;
      case AdTypeEnum.sawmill:
        sqlstring = "update Timer set wood = " + time ;
        break;
      case AdTypeEnum.stone:
        sqlstring = "update Timer set stone = " + time;
        break;
      case AdTypeEnum.none:
        break;
    }
    return await _instance.adTimerDatabase.updateDatabase(sqlstring);
  }

  static Future<List<dynamic>> GetAdTime() async {
    String sqlstring = "select * from Timer ";
    List<dynamic> list = await _instance.adTimerDatabase.selectFromDatabase(sqlstring);
    if(list.length  == 0){
      _instance.adTimerDatabase.insertDatabase("insert into Timer (farm, stone, wood) values ('0','0','0')");
      list.add({"stone":"0","wood":"0","farm":"0"});
      return list;
    }else{
      return list;
    }
  }

}