import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:upgradegame/Src/pages/fight/model/fightInfoModel.dart';

//混入
class BaseFightLineupProvider with ChangeNotifier {

  int woodproportion;
  int stoneproportion;
  int attackHeroCount = 0;
  int protectHeroCount = 0;
  String trainArmyContentName;

  List<List<int>> protect;
  List<List<int>> attack;

  List<List<int>> get Protect => this.protect;

  List<List<int>> get Attack => this.attack;


  initLiuneupProvider(FightInfoModel model){
    if(model.protectlineup != "") {
      this.protect = List<List<int>>();
      var list = convert.jsonDecode(model.protectlineup);
      for(int i = 0;i<list.length;i++){
        var row = List<int>();
        for(int j = 0;j<list[i].length;j++){
          row.add(list[i][j]);
        }
        this.protect.add(row);
      }
    }
    this.attack = [[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]];
    this.woodproportion = model.woodproportion;
    this.stoneproportion = model.stoneproportion;
    notifyListeners();
  }


  initAttactLineup(List<List<int>> attacklineup) {
    attack = attacklineup;
  }

  changeAttackLineUp(int column, int row, int num) {

    for (int i = 0; i < attack.length; i++) {
      if (i == column) {
        for (int n = 0; n < attack[i].length; n++) {
          if (n == row) {
            attack[i][n] = num;
            attackHeroCount += 1;
            return;
          }
        }
      }
    }
  }

  changeProtectLineUp(int column,int row, int num){
    for (int i = 0; i < attack.length; i++) {
      if (i == column) {
        for (int n = 0; n < attack[i].length; n++) {
          if (n == row) {
            protect[i][n] = num;
            protectHeroCount += 1;
            return;
          }
        }
      }
    }
  }
}
