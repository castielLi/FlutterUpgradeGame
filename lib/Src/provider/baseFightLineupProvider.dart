import 'dart:convert' as convert;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upgradegame/Src/pages/fight/model/fightInfoModel.dart';

//混入
class BaseFightLineupProvider with ChangeNotifier {
  int woodproportion;
  int stoneproportion;
  int attackHeroCount = 0;
  int protectHeroCount = 0;
  String trainArmyContentName;
  int supplies;
  int limitsuppliesrecycle;
  String suppliesprice;

  String get SuppliesPrice => suppliesprice;

  int get LimitSuppliesRecycle => limitsuppliesrecycle;

  int get Supplies => supplies;

  List<List<int>> protect;
  List<List<int>> attack;

  List<List<int>> get Protect => this.protect;

  List<List<int>> get Attack => this.attack;

  ///兑换物资到现金账户
  exchangeSupplies(int suppliesamount) {
    this.supplies = suppliesamount;
    notifyListeners();
  }

  ///购买物资
  buySupplies(int suppliesamount) {
    this.supplies = suppliesamount;
    notifyListeners();
  }

  ///初始化物资讯息
  initSupplies(FightInfoModel model) {
    supplies = model.supplies;
    limitsuppliesrecycle = model.limitsuppliesrecycle;
    suppliesprice = model.suppliesprice;
    notifyListeners();
  }

  initLiuneupProvider(FightInfoModel model) {
    this.protectHeroCount = 0;
    if (model.protectlineup != "") {
      this.protect = List<List<int>>();
      var list = convert.jsonDecode(model.protectlineup);
      for (int i = 0; i < list.length; i++) {
        var row = List<int>();
        for (int j = 0; j < list[i].length; j++) {
          row.add(list[i][j]);
          if (list[i][j] != 0) {
            protectHeroCount += 1;
          }
        }
        this.protect.add(row);
      }
    }
    this.attack = [
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0]
    ];
    this.attackHeroCount = 0;
    this.woodproportion = model.wood;
    this.stoneproportion = model.stone;
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
            attackHeroCount += (0 == num ? -1 : 1);
            // print(attackHeroCount);
            return;
          }
        }
      }
    }
  }

  changeProtectLineUp(int column, int row, int num) {
    for (int i = 0; i < attack.length; i++) {
      if (i == column) {
        for (int n = 0; n < attack[i].length; n++) {
          if (n == row) {
            protect[i][n] = num;
            protectHeroCount += (0 == num ? -1 : 1);
            // print(protectHeroCount);
            return;
          }
        }
      }
    }
  }
}
