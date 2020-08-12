class GetChangeContributionModel {
  List<Datalist> datalist;

  GetChangeContributionModel({this.datalist});

  GetChangeContributionModel.fromJson(Map<String, dynamic> json) {
    if (json['datalist'] != null) {
      datalist = new List<Datalist>();
      json['datalist'].forEach((v) {
        datalist.add(new Datalist.fromJson(v));
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

class Datalist {
  String productid;
  int tcoinamount;
  int contributionamount;
  bool isbuy;

  Datalist({this.productid, this.tcoinamount, this.contributionamount, this.isbuy});

  Datalist.fromJson(Map<String, dynamic> json) {
    productid = json['productid'];
    tcoinamount = json['tcoinamount'];
    contributionamount = json['contributionamount'];
    isbuy = json['isbuy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productid'] = this.productid;
    data['tcoinamount'] = this.tcoinamount;
    data['contributionamount'] = this.contributionamount;
    data['isbuy'] = this.isbuy;
    return data;
  }
}
