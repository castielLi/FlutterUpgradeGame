class TradeItemModel {
  String productid;
  String displayname;
  String avatar;
  int type;
  int amount;
  int price;
  bool mytrade;

  TradeItemModel(
      {this.productid,
        this.displayname,
        this.avatar,
        this.type,
        this.amount,
        this.price,
      this.mytrade});

  TradeItemModel.fromJson(Map<String, dynamic> json) {
    productid = json['productid'];
    displayname = json['displayname'];
    avatar = json['avatar'];
    type = json['type'];
    amount = json['amount'];
    price = json['price'];
    mytrade = json['mytrade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productid'] = this.productid;
    data['displayname'] = this.displayname;
    data['avatar'] = this.avatar;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['price'] = this.price;
    data['mytrade'] = this.mytrade;
    return data;
  }
}