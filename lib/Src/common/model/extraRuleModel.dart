class ExtraRuleModel {
  double adview;
  double baidu;
  double tengxun;
  double chuanshanjia;
  bool cashback;
  int stone;
  int farmone;
  int farmtwo;
  int farmthree;
  int wood;
  String appversion;
  String downloadurl;

  ExtraRuleModel(
      {this.adview,
        this.baidu,
        this.tengxun,
        this.chuanshanjia,
        this.cashback,
        this.stone,
        this.farmone,
        this.farmtwo,
        this.farmthree,
        this.wood,
      this.appversion,
      this.downloadurl});

  ExtraRuleModel.fromJson(Map<String, dynamic> json) {
    adview = json['adview'];
    appversion = json['appversion'];
    downloadurl = json['downloadurl'];
    baidu = json['baidu'];
    tengxun = json['tengxun'];
    chuanshanjia = json['chuanshanjia'];
    cashback = json['cashback'];
    stone = json['stone'];
    farmone = json['farmone'];
    farmtwo = json['farmtwo'];
    farmthree = json['farmthree'];
    wood = json['wood'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adview'] = this.adview;
    data['appversion'] = this.appversion;
    data['downloadurl'] = this.downloadurl;
    data['baidu'] = this.baidu;
    data['tengxun'] = this.tengxun;
    data['chuanshanjia'] = this.chuanshanjia;
    data['cashback'] = this.cashback;
    data['stone'] = this.stone;
    data['farmone'] = this.farmone;
    data['farmtwo'] = this.farmtwo;
    data['farmthree'] = this.farmthree;
    data['wood'] = this.wood;
    return data;
  }
}