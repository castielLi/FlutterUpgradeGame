class RecycleSuppliesRequestModel {
  String password;
  String amount;

  RecycleSuppliesRequestModel({this.password, this.amount});

  RecycleSuppliesRequestModel.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['amount'] = this.amount;
    return data;
  }
}