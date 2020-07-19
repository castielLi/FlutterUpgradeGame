import 'package:upgradegame/Src/common/model/hero.dart';
import 'package:upgradegame/Src/common/model/userInfoAd.dart';

class BaseUserInfoModel {
  String displayname;
  int tcoinamount;
  int tobecollectedcoin;
  int stoneamount;
  int woodamount;
  String avatar;
  int mainbuildlevel;
  int farmlevel;
  int stonelevel;
  int woodlevel;
  Ad ad;
  List<Heroes> hero;
  String todayprofitsharing;
  int voucher;

  BaseUserInfoModel(
      {this.displayname,
        this.tcoinamount,
        this.tobecollectedcoin,
        this.stoneamount,
        this.woodamount,
        this.avatar,
        this.mainbuildlevel,
        this.farmlevel,
        this.stonelevel,
        this.woodlevel,
        this.ad,
        this.hero,
        this.todayprofitsharing,
        this.voucher});

  BaseUserInfoModel.fromJson(Map<String, dynamic> json) {
    displayname = json['displayname'];
    tcoinamount = json['tcoinamount'];
    tobecollectedcoin = json['tobecollectedcoin'];
    stoneamount = json['stoneamount'];
    woodamount = json['woodamount'];
    avatar = json['avatar'];
    mainbuildlevel = json['mainbuildlevel'];
    farmlevel = json['farmlevel'];
    stonelevel = json['stonelevel'];
    woodlevel = json['woodlevel'];
    ad = json['ad'] != null ? new Ad.fromJson(json['ad']) : null;
    if (json['hero'] != null) {
      hero = new List<Heroes>();
      json['hero'].forEach((v) {
        hero.add(new Heroes.fromJson(v));
      });
    }
    todayprofitsharing = json['todayprofitsharing'];
    voucher = json['voucher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayname'] = this.displayname;
    data['tcoinamount'] = this.tcoinamount;
    data['tobecollectedcoin'] = this.tobecollectedcoin;
    data['stoneamount'] = this.stoneamount;
    data['woodamount'] = this.woodamount;
    data['avatar'] = this.avatar;
    data['mainbuildlevel'] = this.mainbuildlevel;
    data['farmlevel'] = this.farmlevel;
    data['stonelevel'] = this.stonelevel;
    data['woodlevel'] = this.woodlevel;
    if (this.ad != null) {
      data['ad'] = this.ad.toJson();
    }
    if (this.hero != null) {
      data['hero'] = this.hero.map((v) => v.toJson()).toList();
    }
    data['todayprofitsharing'] = this.todayprofitsharing;
    data['voucher'] = this.voucher;
    return data;
  }
}

