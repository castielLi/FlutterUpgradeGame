class WeChatConfirmOrderRequestModel {
  String orderid;

  WeChatConfirmOrderRequestModel({this.orderid});

  WeChatConfirmOrderRequestModel.fromJson(Map<String, dynamic> json) {
    orderid = json['orderid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderid'] = this.orderid;
    return data;
  }
}