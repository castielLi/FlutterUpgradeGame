class BuySuppliesModel {
  int suppliesamount;
  int tcoinamount;

  BuySuppliesModel({this.suppliesamount,this.tcoinamount});

  BuySuppliesModel.fromJson(Map<String, dynamic> json) {
    suppliesamount = json['suppliesamount'];
    tcoinamount = json['tcoinamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['suppliesamount'] = this.suppliesamount;
    data['tcoinamount'] = this.tcoinamount;
    return data;
  }
}