class BuySuppliesModel {
  int supplies;

  BuySuppliesModel({this.supplies});

  BuySuppliesModel.fromJson(Map<String, dynamic> json) {
    supplies = json['supplies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplies'] = this.supplies;
    return data;
  }
}