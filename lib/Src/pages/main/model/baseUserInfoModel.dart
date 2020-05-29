class BaseUserInfoModel {
  String displayname;
  double tcionamount;
  int stoneamount;
  int woodamount;
  String avatar;
  int mainbuildlevel;
  int farmlevel;
  int stonelevel;
  int woodlevel;
  List<Hero> hero;
  double todayprofitsharing;
  int voucher;

  BaseUserInfoModel(
      {this.displayname,
        this.tcionamount,
        this.stoneamount,
        this.woodamount,
        this.avatar,
        this.mainbuildlevel,
        this.farmlevel,
        this.stonelevel,
        this.woodlevel,
        this.hero,
        this.todayprofitsharing,
        this.voucher});

  BaseUserInfoModel.fromJson(Map<String, dynamic> json) {
    displayname = json['displayname'];
    tcionamount = json['tcionamount'];
    stoneamount = json['stoneamount'];
    woodamount = json['woodamount'];
    avatar = json['avatar'];
    mainbuildlevel = json['mainbuildlevel'];
    farmlevel = json['farmlevel'];
    stonelevel = json['stonelevel'];
    woodlevel = json['woodlevel'];
    if (json['hero'] != null) {
      hero = new List<Hero>();
      json['hero'].forEach((v) {
        hero.add(new Hero.fromJson(v));
      });
    }
    todayprofitsharing = json['todayprofitsharing'];
    voucher = json['voucher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayname'] = this.displayname;
    data['tcionamount'] = this.tcionamount;
    data['stoneamount'] = this.stoneamount;
    data['woodamount'] = this.woodamount;
    data['avatar'] = this.avatar;
    data['mainbuildlevel'] = this.mainbuildlevel;
    data['farmlevel'] = this.farmlevel;
    data['stonelevel'] = this.stonelevel;
    data['woodlevel'] = this.woodlevel;
    if (this.hero != null) {
      data['hero'] = this.hero.map((v) => v.toJson()).toList();
    }
    data['todayprofitsharing'] = this.todayprofitsharing;
    data['voucher'] = this.voucher;
    return data;
  }
}

class Hero {
  int type;
  int days;

  Hero({this.type, this.days});

  Hero.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    days = json['days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['days'] = this.days;
    return data;
  }
}