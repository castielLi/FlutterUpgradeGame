import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upgradegame/Src/common/model/baseResourceModel.dart';
import 'package:upgradegame/Src/common/model/hero.dart';
import 'package:upgradegame/Src/common/model/baseUserInfoModel.dart';
import 'package:upgradegame/Src/common/model/userInfoAd.dart';
import 'package:upgradegame/Src/common/model/watchAdModel.dart';

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
  String todayprofitsharing;
  int voucher;
  Ad ad;
  int tobecollectedcoin;

  int get TCoinAmount => tcoinamount;

  int get WoodAmount => woodamount;

  int get StoneAmount => stoneamount;

  String get Avatar => avatar;

  String get Todayprofitsharing => todayprofitsharing;

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

  ///赠送t币
  sendCoin(int amount){
    this.tcoinamount -= amount;
    notifyListeners();
  }

  ///发布资源订单
  publishBid(int type,int resource){
    ///wood = 1 stone = 2
    if(type == 1){
      this.woodamount -= resource;
    }else{
      this.stoneamount -= resource;
    }
    notifyListeners();
  }

  ///取消发布的资源
  cancelBid(int type,int resource){
    if(type == 1){
      this.woodamount += resource;
    }else{
      this.stoneamount += resource;
    }
    notifyListeners();
  }

  ///购买资源
  buyResource(int type,int resource,int price){
    if(type == 1){
      this.woodamount += resource;
    }else{
      this.stoneamount += resource;
    }
    this.tcoinamount -= price;
    notifyListeners();
  }

  ///观看广告
  watchedAnAd(WatchAdModel model) {
    this.tcoinamount = model.tcoinamount;
    this.woodamount = model.woodamount;
    this.stoneamount = model.stoneamount;
    this.ad.stone = model.stone;
    this.ad.farm = model.farm;
    this.ad.wood = model.wood;
    notifyListeners();
  }
}
