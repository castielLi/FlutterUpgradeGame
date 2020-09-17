class FightRankModel {
  List<Datalist> datalist;

  FightRankModel({this.datalist});

  FightRankModel.fromJson(Map<String, dynamic> json) {
    if (json['datalist'] != null) {
      datalist = new List<Datalist>();
      json['datalist'].forEach((v) {
        datalist.add(new Datalist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datalist != null) {
      data['datalist'] = this.datalist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datalist {
  String displayname;
  int amount;

  Datalist({this.displayname, this.amount});

  Datalist.fromJson(Map<String, dynamic> json) {
    displayname = json['displayname'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayname'] = this.displayname;
    data['amount'] = this.amount;
    return data;
  }
}