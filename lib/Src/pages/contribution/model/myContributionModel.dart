class MyContributionModel {
  int amount;
  String price;
  int myrate;
  int yesterdayamount;
  int exchange;
  List<Conditions> conditions;

  MyContributionModel({this.amount, this.price, this.conditions,this.myrate,this.yesterdayamount,this.exchange});

  MyContributionModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    yesterdayamount = json['yesterdayamount'];
    exchange = json['exchange'];
    price = json['price'];
    myrate = json['myrate'];
    if (json['conditions'] != null) {
      conditions = new List<Conditions>();
      json['conditions'].forEach((v) {
        conditions.add(new Conditions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['yesterdayamount'] = this.yesterdayamount;
    data['exchange'] = this.exchange;
    data['price'] = this.price;
    data['myrate']=this.myrate;
    if (this.conditions != null) {
      data['conditions'] = this.conditions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Conditions {
  int rate;
  int amount;

  Conditions({this.rate, this.amount});

  Conditions.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['amount'] = this.amount;
    return data;
  }
}