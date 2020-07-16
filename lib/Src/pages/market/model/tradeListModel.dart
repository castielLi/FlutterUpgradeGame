import 'package:upgradegame/Src/pages/market/model/tradeItemModel.dart';

class TradeListModel {
  int total;
  int page;
  List<TradeItemModel> datalist;

  TradeListModel({this.total, this.page, this.datalist});

  TradeListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    if (json['datalist'] != null) {
      datalist = new List<TradeItemModel>();
      json['datalist'].forEach((v) {
        datalist.add(new TradeItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['page'] = this.page;
    if (this.datalist != null) {
      data['datalist'] = this.datalist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

