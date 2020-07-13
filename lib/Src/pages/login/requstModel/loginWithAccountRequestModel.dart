class LoginWithAccountRequestModel {
  String account;
  String password;

  LoginWithAccountRequestModel({this.account, this.password});

  LoginWithAccountRequestModel.fromJson(Map<String, dynamic> json) {
    account = json['account'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account'] = this.account;
    data['password'] = this.password;
    return data;
  }
}