class ExtraRuleModel {
  double adview;
  double baidu;
  double tengxun;
  double chuanshanjia;
  bool cashback;

  ExtraRuleModel(
      {this.adview,
        this.baidu,
        this.tengxun,
        this.chuanshanjia,
        this.cashback});

  ExtraRuleModel.fromJson(Map<String, dynamic> json) {
    adview = json['adview'];
    baidu = json['baidu'];
    tengxun = json['tengxun'];
    chuanshanjia = json['chuanshanjia'];
    cashback = json['cashback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adview'] = this.adview;
    data['baidu'] = this.baidu;
    data['tengxun'] = this.tengxun;
    data['chuanshanjia'] = this.chuanshanjia;
    data['cashback'] = this.cashback;
    return data;
  }
}