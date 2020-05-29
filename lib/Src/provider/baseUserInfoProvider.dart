import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upgradegame/Src/common/model/hero.dart';
import 'package:upgradegame/Src/pages/main/model/baseUserInfoModel.dart';

//混入
class BaseUserInfoProvider with ChangeNotifier{
  String displayname;
  double tcionamount;
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

  ///网络数据初始化
  initBaseUserInfo(BaseUserInfoModel model){
    model.displayname = displayname;
    model.tcionamount = tcionamount;
    model.stoneamount = stoneamount;
    model.woodamount = woodamount;
    model.avatar = avatar;
    model.mainbuildlevel = mainbuildlevel;
    model.farmlevel = farmlevel;
    model.stonelevel = stonelevel;
    model.woodlevel = woodlevel;
    model.hero = hero;
    model.todayprofitsharing = todayprofitsharing;
    model.voucher = voucher;
  }
}