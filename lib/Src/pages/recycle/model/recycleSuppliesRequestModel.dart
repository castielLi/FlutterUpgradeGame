class RecycleSuppliesRequestModel {
  String password;
  int suppliesamount;

  RecycleSuppliesRequestModel({this.password, this.suppliesamount});

  RecycleSuppliesRequestModel.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    suppliesamount = json['suppliesamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['suppliesamount'] = this.suppliesamount;
    return data;
  }
}