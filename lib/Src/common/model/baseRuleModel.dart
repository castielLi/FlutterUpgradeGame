
class BaseRuleModel {
  Adsetting adSetting;
  int contributionbuyrate;
  int withdrawlimit;
  List<Mainbuild> mainbuild;
  List<Farm> farm;
  List<Wood> wood;
  List<Stone> stone;

  BaseRuleModel(
      {this.adSetting, this.mainbuild, this.farm, this.wood, this.stone});

  BaseRuleModel.fromJson(Map<String, dynamic> json) {
    contributionbuyrate = json['contributionbuyrate'];
    withdrawlimit = json['withdrawlimit'];
    adSetting = json['adsetting'] != null
        ? new Adsetting.fromJson(json['adsetting'])
        : null;
    if (json['mainbuild'] != null) {
      mainbuild = new List<Mainbuild>();
      json['mainbuild'].forEach((v) {
        mainbuild.add(new Mainbuild.fromJson(v));
      });
    }
    if (json['farm'] != null) {
      farm = new List<Farm>();
      json['farm'].forEach((v) {
        farm.add(new Farm.fromJson(v));
      });
    }
    if (json['wood'] != null) {
      wood = new List<Wood>();
      json['wood'].forEach((v) {
        wood.add(new Wood.fromJson(v));
      });
    }
    if (json['stone'] != null) {
      stone = new List<Stone>();
      json['stone'].forEach((v) {
        stone.add(new Stone.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contributionbuyrate'] = this.contributionbuyrate;
    data['withdrawlimit'] = this.withdrawlimit;
    if (this.adSetting != null) {
      data['adsetting'] = this.adSetting.toJson();
    }
    if (this.mainbuild != null) {
      data['mainbuild'] = this.mainbuild.map((v) => v.toJson()).toList();
    }
    if (this.farm != null) {
      data['farm'] = this.farm.map((v) => v.toJson()).toList();
    }
    if (this.wood != null) {
      data['wood'] = this.wood.map((v) => v.toJson()).toList();
    }
    if (this.stone != null) {
      data['stone'] = this.stone.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Adsetting {
  int wood;
  int farmone;
  int farmtwo;
  int farmthree;
  int stone;

  Adsetting(
      {this.wood, this.farmone, this.farmtwo, this.farmthree, this.stone});

  Adsetting.fromJson(Map<String, dynamic> json) {
    wood = json['wood'];
    farmone = json['farmone'];
    farmtwo = json['farmtwo'];
    farmthree = json['farmthree'];
    stone = json['stone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wood'] = this.wood;
    data['farmone'] = this.farmone;
    data['farmtwo'] = this.farmtwo;
    data['farmthree'] = this.farmthree;
    data['stone'] = this.stone;
    return data;
  }
}


class Mainbuild {
  int level;
  int woodamount;
  int stoneamount;
  int product;
  int consumewood;
  int consumestone;

  Mainbuild(
      {this.level,
        this.woodamount,
        this.stoneamount,
        this.product,
        this.consumewood,
        this.consumestone});

  Mainbuild.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    woodamount = json['woodamount'];
    stoneamount = json['stoneamount'];
    product = json['product'];
    consumewood = json['consumewood'];
    consumestone = json['consumestone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['woodamount'] = this.woodamount;
    data['stoneamount'] = this.stoneamount;
    data['product'] = this.product;
    data['consumewood'] = this.consumewood;
    data['consumestone'] = this.consumestone;
    return data;
  }
}

class Farm {
  int level;
  int tcoinamount;
  int woodlevel;
  int stonelevel;

  Farm({this.level, this.tcoinamount, this.woodlevel, this.stonelevel});

  Farm.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    tcoinamount = json['tcoinamount'];
    woodlevel = json['woodlevel'];
    stonelevel = json['stonelevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['tcoinamount'] = this.tcoinamount;
    data['woodlevel'] = this.woodlevel;
    data['stonelevel'] = this.stonelevel;
    return data;
  }
}

class Wood {
  int level;
  int tcoinamount;
  int farmlevel;
  int product;

  Wood({this.level, this.tcoinamount, this.farmlevel, this.product});

  Wood.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    tcoinamount = json['tcoinamount'];
    farmlevel = json['farmlevel'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['tcoinamount'] = this.tcoinamount;
    data['farmlevel'] = this.farmlevel;
    data['product'] = this.product;
    return data;
  }
}

class Stone {
  int level;
  int tcoinamount;
  int farmlevel;
  int product;

  Stone({this.level, this.tcoinamount, this.farmlevel, this.product});

  Stone.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    tcoinamount = json['tcoinamount'];
    farmlevel = json['farmlevel'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['tcoinamount'] = this.tcoinamount;
    data['farmlevel'] = this.farmlevel;
    data['product'] = this.product;
    return data;
  }
}