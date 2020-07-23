class TCoinDetailModel {
  int total;
  int page;
  List<Datalist> datalist;

  TCoinDetailModel({this.total, this.page, this.datalist});

  TCoinDetailModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    if (json['datalist'] != null) {
      datalist = new List<Datalist>();
      json['datalist'].forEach((v) {
        datalist.add(new Datalist.fromJson(v));
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

class Datalist {
  String datetime;
  String detail;
  String change;

  Datalist({this.datetime, this.detail, this.change});

  Datalist.fromJson(Map<String, dynamic> json) {
    datetime = json['datetime'];
    detail = json['detail'];
    change = json['change'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datetime'] = this.datetime;
    data['detail'] = this.detail;
    data['change'] = this.change;
    return data;
  }
}