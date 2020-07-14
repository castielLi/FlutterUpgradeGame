class WithdrawRequestModel {
  String aliaccount;
  String cashamount;
  String password;

  WithdrawRequestModel({this.aliaccount, this.cashamount, this.password});

  WithdrawRequestModel.fromJson(Map<String, dynamic> json) {
    aliaccount = json['aliaccount'];
    cashamount = json['cashamount'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aliaccount'] = this.aliaccount;
    data['cashamount'] = this.cashamount;
    data['password'] = this.password;
    return data;
  }
}