
class BaseRuleModel {
  List<Mainbuild> mainbuild;
  List<Farm> farm;
  List<Wood> wood;
  List<Stone> stone;

  BaseRuleModel(BaseRuleModel model) {
    this.mainbuild = model.mainbuild;
    this.farm = model.farm;
    this.wood = model.wood;
    this.stone = model.stone;
  }

  BaseRuleModel.fromJson(Map<String, dynamic> json) {
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

class Mainbuild {
  int level;
  int woodamount;
  int stoneamount;
  int product;

  Mainbuild(
      {this.level,
        this.woodamount,
        this.stoneamount,
        this.product,});

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
  int woodlevel;
  int stonelevel;

  Farm({this.level, this.woodlevel, this.stonelevel});

  Farm.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    woodlevel = json['woodlevel'];
    stonelevel = json['stonelevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['woodlevel'] = this.woodlevel;
    data['stonelevel'] = this.stonelevel;
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