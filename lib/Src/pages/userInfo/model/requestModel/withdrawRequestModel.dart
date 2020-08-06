class WithdrawRequestModel {
  String account;
  double amount;
  String password;

  WithdrawRequestModel({this.account, this.amount, this.password});

  WithdrawRequestModel.fromJson(Map<String, dynamic> json) {
    account = json['account'];
    amount = json['amount'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account'] = this.account;
    data['amount'] = this.amount;
    data['password'] = this.password;
    return data;
  }
}