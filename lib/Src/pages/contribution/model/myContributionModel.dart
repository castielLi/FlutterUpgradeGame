class MyContributionModel {
  int amount;
  String price;
  List<Conditions> conditions;

  MyContributionModel({this.amount, this.price, this.conditions});

  MyContributionModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    price = json['price'];
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
    data['price'] = this.price;
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