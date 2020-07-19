class BuyVoucherWeChatResponseModel {
  String orderid;
  String appid;
  String partnerid;
  String prepayid;
  String package;
  String noncestr;
  String timestamp;
  String sign;

  BuyVoucherWeChatResponseModel(
      {this.orderid,
        this.appid,
        this.partnerid,
        this.prepayid,
        this.package,
        this.noncestr,
        this.timestamp,
        this.sign});

  BuyVoucherWeChatResponseModel.fromJson(Map<String, dynamic> json) {
    orderid = json['orderid'];
    appid = json['appid'];
    partnerid = json['partnerid'];
    prepayid = json['prepayid'];
    package = json['package'];
    noncestr = json['noncestr'];
    timestamp = json['timestamp'];
    sign = json['sign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderid'] = this.orderid;
    data['appid'] = this.appid;
    data['partnerid'] = this.partnerid;
    data['prepayid'] = this.prepayid;
    data['package'] = this.package;
    data['noncestr'] = this.noncestr;
    data['timestamp'] = this.timestamp;
    data['sign'] = this.sign;
    return data;
  }
}