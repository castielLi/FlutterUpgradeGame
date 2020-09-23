class RecycleSuppliesModel {
  int supplies;
  int tcoinamount;

  RecycleSuppliesModel({this.supplies});

  RecycleSuppliesModel.fromJson(Map<String, dynamic> json) {
    supplies = json['supplies'];
    tcoinamount = json['tcoinamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplies'] = this.supplies;
    data['tcoinamount'] = this.tcoinamount;
    return data;
  }
}