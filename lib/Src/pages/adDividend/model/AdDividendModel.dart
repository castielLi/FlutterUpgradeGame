class AdDividendListModel {
  List<AdDividendModel> datalist;

  AdDividendListModel({this.datalist});

  AdDividendListModel.fromJson(Map<String, dynamic> json) {
    if (json['datalist'] != null) {
      datalist = new List<AdDividendModel>();
      json['datalist'].forEach((v) {
        datalist.add(new AdDividendModel.fromJson(v));
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

class AdDividendModel {
  // 分红类型
  int type;

  // 昨日收益
  double yesterdayincome;

  // 历史收益
  int totalincome;

  // 全网总数
  int totalheroamount;

  // 今日产出
  int todayheroamount;

  AdDividendModel(
      {this.type,
      this.yesterdayincome = 0,
      this.totalincome = 0,
      this.totalheroamount = 0,
      this.todayheroamount = 0});

  AdDividendModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    yesterdayincome = json['yesterdayincome'];
    totalincome = json['totalincome'];
    totalheroamount = json['totalheroamount'];
    todayheroamount = json['todayheroamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['yesterdayincome'] = this.yesterdayincome;
    data['totalincome'] = this.totalincome;
    data['totalheroamount'] = this.totalheroamount;
    data['todayheroamount'] = this.todayheroamount;
    return data;
  }
}
