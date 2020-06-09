
class StoreModel {
  String productid;
  int amount;
  int price;

  StoreModel({this.productid, this.amount, this.price});

  StoreModel.fromJson(Map<String, dynamic> json) {
    productid = json['productid'];
    amount = json['amount'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productid'] = this.productid;
    data['amount'] = this.amount;
    data['price'] = this.price;
    return data;
  }
}