import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upgradegame/Src/common/model/hero.dart';
import 'package:upgradegame/Src/common/model/baseUserInfoModel.dart';

//混入
class BaseUserInfoProvider with ChangeNotifier{
  String displayname;
  int tcionamount;
  int stoneamount;
  int woodamount;
  String avatar;
  int mainbuildlevel;
  int farmlevel;
  int stonelevel;
  int woodlevel;
  List<Heroes> hero;
  double todayprofitsharing;
  int voucher;

  int get TCoinAmount =>tcionamount;

  ///网络数据初始化
  initBaseUserInfo(BaseUserInfoModel model){
    displayname = model.displayname;
    tcionamount = model.tcionamount;
    stoneamount = model.stoneamount;
    woodamount = model.woodamount;
    avatar = model.avatar;
    mainbuildlevel = model.mainbuildlevel;
    farmlevel = model.farmlevel;
    stonelevel = model.stonelevel;
    woodlevel = model.woodlevel;
    hero = model.hero;
    todayprofitsharing = model.todayprofitsharing;
    voucher = model.voucher;
  }
}