class StoreListModel {
  List<StoreModel> datalist;

  StoreListModel({this.datalist});

  StoreListModel.fromJson(Map<String, dynamic> json) {
    if (json['datalist'] != null) {
      datalist = new List<StoreModel>();
      json['datalist'].forEach((v) {
        datalist.add(new StoreModel.fromJson(v));
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

class StoreModel {
  String productid;
  int amount;
  double price;

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