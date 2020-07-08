class WatchAdModel {
  int wood;
  int farm;
  int stone;
  int tcoinamount;
  int stoneamount;
  int woodamount;

  WatchAdModel(
      {this.wood,
        this.farm,
        this.stone,
        this.tcoinamount,
        this.stoneamount,
        this.woodamount});

  WatchAdModel.fromJson(Map<String, dynamic> json) {
    wood = json['wood'];
    farm = json['farm'];
    stone = json['stone'];
    tcoinamount = json['tcoinamount'];
    stoneamount = json['stoneamount'];
    woodamount = json['woodamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wood'] = this.wood;
    data['farm'] = this.farm;
    data['stone'] = this.stone;
    data['tcoinamount'] = this.tcoinamount;
    data['stoneamount'] = this.stoneamount;
    data['woodamount'] = this.woodamount;
    return data;
  }
}