class CancelTradeRequestModel {
  String productid;
  int type;

  CancelTradeRequestModel({this.productid, this.type});

  CancelTradeRequestModel.fromJson(Map<String, dynamic> json) {
    productid = json['productid'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productid'] = this.productid;
    data['type'] = this.type;
    return data;
  }
}