import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:upgradegame/Src/pages/fight/model/fightInfoModel.dart';

//混入
class BaseFightLineupProvider with ChangeNotifier {

  int woodproportion;
  int stoneproportion;

  List<List<int>> protect;
  List<List<int>> attack;

  List<List<int>> get Protect => this.protect;

  List<List<int>> get Attack => this.attack;


  initLiuneupProvider(FightInfoModel model){
    this.protect = (convert.jsonDecode(model.protectlineup) as List<dynamic>).cast<List<int>>();
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
            return;
          }
        }
      }
    }
  }
}
