import 'package:upgradegame/Src/common/model/hero.dart';

class BuyHeroModel {
  List<Heroes> datalist;
  int tcoinamount;

  BuyHeroModel({this.datalist, this.tcoinamount});

  BuyHeroModel.fromJson(Map<String, dynamic> json) {
    if (json['datalist'] != null) {
      datalist = new List<Heroes>();
      json['datalist'].forEach((v) {
        datalist.add(new Heroes.fromJson(v));
      });
    }
    tcoinamount = json['tcoinamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datalist != null) {
      data['datalist'] = this.datalist.map((v) => v.toJson()).toList();
    }
    data['tcoinamount'] = this.tcoinamount;
    return data;
  }
}