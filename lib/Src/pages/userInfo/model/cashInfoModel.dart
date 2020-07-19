class CashInfoModel {
  String cashamount;
  bool withdrawing;

  CashInfoModel({this.cashamount, this.withdrawing});

  CashInfoModel.fromJson(Map<String, dynamic> json) {
    cashamount = json['cashamount'];
    withdrawing = json['withdrawing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cashamount'] = this.cashamount;
    data['withdrawing'] = this.withdrawing;
    return data;
  }
}