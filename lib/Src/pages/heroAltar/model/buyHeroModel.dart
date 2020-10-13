import 'package:upgradegame/Src/common/model/hero.dart';

class BuyHeroModel {
  int tcoinamount;

  BuyHeroModel({this.tcoinamount});

  BuyHeroModel.fromJson(Map<String, dynamic> json) {

    tcoinamount = json['tcoinamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tcoinamount'] = this.tcoinamount;
    return data;
  }
}