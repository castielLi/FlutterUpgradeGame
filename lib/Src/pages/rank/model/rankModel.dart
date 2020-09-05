class RankListModel {
  List<RankCoinModel> coinList;
  List<RankCashModel> incomeList;
  List<RankMainBuildModel> mainbuildList;

  RankListModel({this.coinList, this.incomeList});

  RankListModel.fromJson(Map<String, dynamic> json) {
    if (json['tcoin'] != null) {
      coinList = new List<RankCoinModel>();
      json['tcoin'].forEach((v) {
        coinList.add(new RankCoinModel.fromJson(v));
      });
    }
    if (json['mainbuild'] != null) {
      mainbuildList = new List<RankMainBuildModel>();
      json['mainbuild'].forEach((v) {
        mainbuildList.add(new RankMainBuildModel.fromJson(v));
      });
    }
    if (json['income'] != null) {
      incomeList = new List<RankCashModel>();
      json['income'].forEach((v) {
        incomeList.add(new RankCashModel.fromJson(v));
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
    if (this.mainbuildList != null) {
      data['mainbuild'] = this.mainbuildList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RankCoinModel {
  String displayname;
  String amount;

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

class RankMainBuildModel {
  String displayname;
  String amount;

  RankMainBuildModel({this.displayname, this.amount});

  RankMainBuildModel.fromJson(Map<String, dynamic> json) {
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


class RankCashModel {
  String displayname;
  String amount;

  RankCashModel({this.displayname, this.amount});

  RankCashModel.fromJson(Map<String, dynamic> json) {
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
