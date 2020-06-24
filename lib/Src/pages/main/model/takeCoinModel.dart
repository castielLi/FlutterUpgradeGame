class TakeCoinModel {
  int tcoinamount;
  int stoneamount;
  int woodamount;

  TakeCoinModel({this.tcoinamount, this.stoneamount, this.woodamount});

  TakeCoinModel.fromJson(Map<String, dynamic> json) {
    tcoinamount = json['tcoinamount'];
    stoneamount = json['stoneamount'];
    woodamount = json['woodamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tcoinamount'] = this.tcoinamount;
    data['stoneamount'] = this.stoneamount;
    data['woodamount'] = this.woodamount;
    return data;
  }
}