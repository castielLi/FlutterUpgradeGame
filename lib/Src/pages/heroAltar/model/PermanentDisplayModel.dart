class PermanentDisplayModel {
  int type;
  String price;
  String amount;
  String consumecoin;
  bool buy;

  PermanentDisplayModel({this.type, this.price, this.amount, this.consumecoin, this.buy});

  PermanentDisplayModel.fromJson(Map<String, dynamic> json) {
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