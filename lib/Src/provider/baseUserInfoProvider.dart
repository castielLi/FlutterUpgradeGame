import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upgradegame/Src/common/model/baseResourceModel.dart';
import 'package:upgradegame/Src/common/model/hero.dart';
import 'package:upgradegame/Src/common/model/baseUserInfoModel.dart';
import 'package:upgradegame/Src/common/model/userInfoAd.dart';

//混入
class BaseUserInfoProvider with ChangeNotifier {
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

  int get TCoinAmount => tcoinamount;

  int get WoodAmount => woodamount;

  int get StoneAmount => stoneamount;

  String get Avatar => avatar;

  double get Todayprofitsharing => todayprofitsharing;

  int get Mainbuildlevel => mainbuildlevel;

  int get Farmlevel => farmlevel;

  int get Stonelevel => stonelevel;

  int get Woodlevel => woodlevel;

  ///网络数据初始化
  initBaseUserInfo(BaseUserInfoModel model) {
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
    notifyListeners();
  }

  ///获取t币
  takeCoin(int tconamount, int woodamount, int stoneamount) {
    this.tcoinamount = tconamount;
    this.woodamount = woodamount;
    this.stoneamount = stoneamount;
    this.tobecollectedcoin = 0;
    notifyListeners();
  }

  ///购买赠送券
  buyVoucher(int amount) {
    this.voucher = amount;
    notifyListeners();
  }

  ///购买英雄
  buyHero(int tcoinamount,List<Heroes> hero){
    this.tcoinamount = tcoinamount;
    this.hero = hero;
    notifyListeners();
  }

  ///升级建筑
  upgradeBuilding(BaseResourceModel model){
    this.tcoinamount = model.tcoinamount;
    this.woodamount = model.woodamount;
    this.stoneamount = model.stoneamount;
    this.mainbuildlevel = model.mainbuildlevel;
    this.stonelevel = model.stonelevel;
    this.woodamount = model.woodlevel;
    notifyListeners();
  }

  ///增加观看广告次数
  watchedAnAd(AdType adType) {
    switch (adType) {
      case AdType.wood:
        this.ad.wood++;
        break;
      case AdType.stone:
        this.ad.stone++;
        break;
      case AdType.farm:
        this.ad.farm++;
    }
  }
}
