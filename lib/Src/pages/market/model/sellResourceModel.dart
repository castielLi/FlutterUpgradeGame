class SellResourceModel {
  String type;
  double amount;
  double price;

  SellResourceModel({this.type, this.amount, this.price});

  SellResourceModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    amount = json['amount'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['price'] = this.price;
    return data;
  }
}