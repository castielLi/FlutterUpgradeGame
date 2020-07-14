class SetUserInfoRequestModel {
  String realname;
  String telephone;
  String idcard;
  String account;
  String password;

  SetUserInfoRequestModel(
      {this.realname,
        this.telephone,
        this.idcard,
        this.account,
        this.password});

  SetUserInfoRequestModel.fromJson(Map<String, dynamic> json) {
    realname = json['realname'];
    telephone = json['telephone'];
    idcard = json['idcard'];
    account = json['account'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['realname'] = this.realname;
    data['telephone'] = this.telephone;
    data['idcard'] = this.idcard;
    data['account'] = this.account;
    data['password'] = this.password;
    return data;
  }
}