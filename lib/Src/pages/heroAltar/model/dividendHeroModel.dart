class DividendHeroModel {
  int tcoinamount;

  DividendHeroModel({this.tcoinamount});

  DividendHeroModel.fromJson(Map<String, dynamic> json) {
    tcoinamount = json['tcoinamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tcoinamount'] = this.tcoinamount;
    return data;
  }
}