class SendCoinRequestModel {
  String userid;
  String password;
  int amount;

  SendCoinRequestModel({this.userid, this.password, this.amount});

  SendCoinRequestModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    password = json['password'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['password'] = this.password;
    data['amount'] = this.amount;
    return data;
  }
}