class RankListModel {
  List<RankModel> coinList;
  List<RankModel> incomeList;

  RankListModel({this.coinList, this.incomeList});

  RankListModel.fromJson(Map<String, dynamic> json) {
    if (json['tcoin'] != null) {
      coinList = new List<RankModel>();
      json['tcoin'].forEach((v) {
        coinList.add(new RankModel.fromJson(v));
      });
    }
    if (json['income'] != null) {
      incomeList = new List<RankModel>();
      json['income'].forEach((v) {
        incomeList.add(new RankModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coinList != null) {
      data['tcoin'] = this.coinList.map((v) => v.toJson()).toList();
    }
    if (this.incomeList != null) {
      data['income'] = this.incomeList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RankModel {
  String displayname;
  int amount;

  RankModel({this.displayname, this.amount});

  RankModel.fromJson(Map<String, dynamic> json) {
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
