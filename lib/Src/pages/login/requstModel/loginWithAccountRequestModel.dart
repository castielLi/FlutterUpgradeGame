class LoginWithAccountRequestModel {
  String account;
  String password;
  String deviceid;
  String sign;

  LoginWithAccountRequestModel({this.account, this.password,this.deviceid,this.sign});

  LoginWithAccountRequestModel.fromJson(Map<String, dynamic> json) {
    account = json['account'];
    password = json['password'];
    deviceid = json['deviceid'];
    sign = json['sign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account'] = this.account;
    data['password'] = this.password;
    data['deviceid'] = this.deviceid;
    data['sign'] = this.sign;
    return data;
  }
}