class BuyVoucherRequestModel {
  String productid;

  BuyVoucherRequestModel({this.productid});

  BuyVoucherRequestModel.fromJson(Map<String, dynamic> json) {
    productid = json['productid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productid'] = this.productid;
    return data;
  }
}