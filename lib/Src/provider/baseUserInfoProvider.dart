import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upgradegame/Src/common/model/hero.dart';
import 'package:upgradegame/Src/common/model/baseUserInfoModel.dart';
import 'package:upgradegame/Src/common/model/userInfoAd.dart';
import 'package:upgradegame/Src/provider/basePageLogicProvider.dart';

//混入
class BaseUserInfoProvider with ChangeNotifier{
  String displayname;
  int tcoinamount;
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
  Ad ad;
  int tobecollectedcoin;

  int get TCoinAmount =>tcoinamount;
  int get WoodAmount =>woodamount;
  int get StoneAmount => stoneamount;
  String get Avatar => avatar;
  double get Todayprofitsharing => todayprofitsharing;
  int get Mainbuildlevel => mainbuildlevel;
  int get Farmlevel =>farmlevel;
  int get Stonelevel =>stonelevel;
  int get Woodlevel =>woodlevel;

  ///网络数据初始化
  initBaseUserInfo(BaseUserInfoModel model){
    displayname = model.displayname;
    ad = model.ad;
    tcoinamount = model.tcoinamount;
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
    tobecollectedcoin = model.tobecollectedcoin;

  }

  void takeCoin(){
    this.tcoinamount += tobecollectedcoin;
    tobecollectedcoin = 0;
  }

  void runProductCoin(int tCoinAmount,int woodAmount, int stoneAmount){
    this.tobecollectedcoin = tCoinAmount;
    this.woodamount = woodAmount;
    this.stoneamount = stoneAmount;
  }

}