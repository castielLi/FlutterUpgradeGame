class RankCoinListModel {
  List<RankCoinModel> datalist;

  RankCoinListModel({this.datalist});

  RankCoinListModel.fromJson(Map<String, dynamic> json) {
    if (json['tcoin'] != null) {
      datalist = new List<RankCoinModel>();
      json['tcoin'].forEach((v) {
        datalist.add(new RankCoinModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datalist != null) {
      data['tcoin'] = this.datalist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RankCoinModel {
  String displayname;
  int amount;

  RankCoinModel({this.displayname, this.amount});

  RankCoinModel.fromJson(Map<String, dynamic> json) {
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
