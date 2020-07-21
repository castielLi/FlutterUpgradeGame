class MarketBuyRequestModel {
  String productid;

  MarketBuyRequestModel({this.productid});

  MarketBuyRequestModel.fromJson(Map<String, dynamic> json) {
    productid = json['productid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productid'] = this.productid;
    return data;
  }
}