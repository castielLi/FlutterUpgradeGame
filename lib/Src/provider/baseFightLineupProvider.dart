import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upgradegame/Src/pages/userInfo/model/cashInfoModel.dart';

//混入
class BaseFightLineupProvider with ChangeNotifier {
  List<List<int>> protect;
  List<List<int>> attack;

  List<List<int>> get Protect => this.protect;

  List<List<int>> get Attack => this.attack;

  initProtectLineup(List<List<int>> protectlineup){
    protect = protectlineup;
  }

  initLiuneupProvider(String protectJsonString){

  }

  initAttactLineup(List<List<int>> attacklineup){
    attack = attacklineup;
  }
}
