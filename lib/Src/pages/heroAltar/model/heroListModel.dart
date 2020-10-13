class HeroListModel {
  List<Hold> hold;
  List<Limittime> limittime;
  List<Permanent> permanent;

  HeroListModel({this.hold, this.limittime, this.permanent});

  HeroListModel.fromJson(Map<String, dynamic> json) {
    if (json['hold'] != null) {
      hold = new List<Hold>();
      json['hold'].forEach((v) {
        hold.add(new Hold.fromJson(v));
      });
    }
    if (json['limittime'] != null) {
      limittime = new List<Limittime>();
      json['limittime'].forEach((v) {
        limittime.add(new Limittime.fromJson(v));
      });
    }
    if (json['permanent'] != null) {
      permanent = new List<Permanent>();
      json['permanent'].forEach((v) {
        permanent.add(new Permanent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hold != null) {
      data['hold'] = this.hold.map((v) => v.toJson()).toList();
    }
    if (this.limittime != null) {
      data['limittime'] = this.limittime.map((v) => v.toJson()).toList();
    }
    if (this.permanent != null) {
      data['permanent'] = this.permanent.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hold {
  String id;
  int type;
  int days;
  bool collected;

  Hold({this.id, this.type, this.days, this.collected});

  Hold.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    days = json['days'];
    collected = json['collected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['days'] = this.days;
    data['collected'] = this.collected;
    return data;
  }
}

class Limittime {
  int type;
  int price;

  Limittime({this.type, this.price});

  Limittime.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['price'] = this.price;
    return data;
  }
}

class Permanent {
  int type;
  int price;
  int amount;
  int consumecoin;
  bool buy;

  Permanent({this.type, this.price, this.amount, this.consumecoin, this.buy});

  Permanent.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    price = json['price'];
    amount = json['amount'];
    consumecoin = json['consumecoin'];
    buy = json['buy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['consumecoin'] = this.consumecoin;
    data['buy'] = this.buy;
    return data;
  }
}