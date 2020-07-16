import 'package:upgradegame/Src/pages/market/model/tradeItemModel.dart';

class MyTradeListModel {
  List<TradeItemModel> datalist;

  MyTradeListModel({this.datalist});

  MyTradeListModel.fromJson(Map<String, dynamic> json) {
    if (json['datalist'] != null) {
      datalist = new List<TradeItemModel>();
      json['datalist'].forEach((v) {
        datalist.add(new TradeItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datalist != null) {
      data['datalist'] = this.datalist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
