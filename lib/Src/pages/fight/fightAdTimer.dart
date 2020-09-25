
import 'package:upgradegame/Common/storge/sqliteHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:upgradegame/Src/common/model/enum/adTypeEnum.dart';

class FightAdTimer{
  factory FightAdTimer() =>_getInstance();
  static FightAdTimer get instance => _getInstance();
  static FightAdTimer _instance;

  SqliteHelper adTimerDatabase;

  FightAdTimer._internal() {
    // 初始化
    adTimerDatabase = SqliteHelper();
  }

  static FightAdTimer _getInstance() {
    if (_instance == null) {
      _instance = new FightAdTimer._internal();
    }
    return _instance;
  }


  static Future<bool> UpdateAdTime(int watched) async{
    String sqlstring = "update FightTimer set needWatched = " + watched.toString();

    return await _instance.adTimerDatabase.updateDatabase(sqlstring);
  }

  static Future<List<dynamic>> GetNeedWatch() async {
    String sqlstring = "select * from FightTimer ";
    List<dynamic> list = await _instance.adTimerDatabase.selectFromDatabase(sqlstring);
    if(list.length  == 0){
      _instance.adTimerDatabase.insertDatabase("insert into FightTimer (needWatched) values (0)");
      var currentList = List<dynamic>();
      currentList.add({"needWatched":0});
      return currentList;
    }else{
      return list;
    }
  }

}