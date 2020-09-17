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
  changeAttackLineUp(int column,int row,int num){

    for(int i=0;i<attack.length;i++){
      if(i==column){
        for(int n=0;n<attack[i].length;n++){
          if(n==row){
            attack[i][n] = num;
            print(attack[i][n].toString()+"!!!!!!!");
            return;
          }
        }
      }
    }

  }
}
