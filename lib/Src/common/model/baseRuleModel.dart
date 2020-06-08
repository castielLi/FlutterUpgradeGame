
class BaseRuleModel {
  AdSetting adSetting;
  List<Mainbuild> mainbuild;
  List<Farm> farm;
  List<Wood> wood;
  List<Stone> stone;

  BaseRuleModel(
      {this.adSetting, this.mainbuild, this.farm, this.wood, this.stone});

  BaseRuleModel.fromJson(Map<String, dynamic> json) {
    adSetting = json['adsetting'] != null
        ? new AdSetting.fromJson(json['adsetting'])
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

class AdSetting {
  int wood;
  int farm;
  int stone;

  AdSetting({this.wood, this.farm, this.stone});

  AdSetting.fromJson(Map<String, dynamic> json) {
    wood = json['wood'];
    farm = json['farm'];
    stone = json['stone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wood'] = this.wood;
    data['farm'] = this.farm;
    data['stone'] = this.stone;
    return data;
  }
}

class Mainbuild {
  int level;
  int woodamount;
  int stoneamount;
  int product;

  Mainbuild({this.level, this.woodamount, this.stoneamount, this.product});

  Mainbuild.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    woodamount = json['woodamount'];
    stoneamount = json['stoneamount'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['woodamount'] = this.woodamount;
    data['stoneamount'] = this.stoneamount;
    data['product'] = this.product;
    return data;
  }
}

class Farm {
  int level;
  int tcoinamount;
  int woodlevel;
  int stonelevel;
  int product;

  Farm(
      {this.level,
        this.tcoinamount,
        this.woodlevel,
        this.stonelevel,
        this.product});

  Farm.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    tcoinamount = json['tcoinamount'];
    woodlevel = json['woodlevel'];
    stonelevel = json['stonelevel'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['tcoinamount'] = this.tcoinamount;
    data['woodlevel'] = this.woodlevel;
    data['stonelevel'] = this.stonelevel;
    data['product'] = this.product;
    return data;
  }
}

class Wood {
  int level;
  int tcoinamount;
  int product;

  Wood({this.level, this.tcoinamount, this.product});

  Wood.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    tcoinamount = json['tcoinamount'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['tcoinamount'] = this.tcoinamount;
    data['product'] = this.product;
    return data;
  }
}

class Stone {
  int level;
  int tcoinamount;
  int product;

  Stone({this.level, this.tcoinamount, this.product});

  Stone.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    tcoinamount = json['tcoinamount'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['tcoinamount'] = this.tcoinamount;
    data['product'] = this.product;
    return data;
  }
}