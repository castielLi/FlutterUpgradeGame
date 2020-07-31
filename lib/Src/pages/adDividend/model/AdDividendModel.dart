class AdDividendListModel {
  String oneyesterdayprice;
  int onetotal;
  int oneproduct;
  String threeyesterdayprice;
  int threetotal;
  int threeproduct;

  AdDividendListModel(
      {this.oneyesterdayprice,
        this.onetotal,
        this.oneproduct,
        this.threeyesterdayprice,
        this.threetotal,
        this.threeproduct});

  AdDividendListModel.fromJson(Map<String, dynamic> json) {
    oneyesterdayprice = json['oneyesterdayprice'];
    onetotal = json['onetotal'];
    oneproduct = json['oneproduct'];
    threeyesterdayprice = json['threeyesterdayprice'];
    threetotal = json['threetotal'];
    threeproduct = json['threeproduct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oneyesterdayprice'] = this.oneyesterdayprice;
    data['onetotal'] = this.onetotal;
    data['oneproduct'] = this.oneproduct;
    data['threeyesterdayprice'] = this.threeyesterdayprice;
    data['threetotal'] = this.threetotal;
    data['threeproduct'] = this.threeproduct;
    return data;
  }
}