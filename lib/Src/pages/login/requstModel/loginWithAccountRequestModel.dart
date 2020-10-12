class LoginWithAccountRequestModel {
  String account;
  String password;
  String deviceid;

  LoginWithAccountRequestModel({this.account, this.password,this.deviceid});

  LoginWithAccountRequestModel.fromJson(Map<String, dynamic> json) {
    account = json['account'];
    password = json['password'];
    deviceid = json['deviceid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account'] = this.account;
    data['password'] = this.password;
    data['deviceid'] = this.deviceid;
    return data;
  }
}