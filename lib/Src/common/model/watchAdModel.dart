class WatchAdModel {
  int wood;
  int farmone;
  int farmtwo;
  int farmthree;
  int stone;
  int tcoinamount;
  int stoneamount;
  int woodamount;
  String content;

  WatchAdModel(
      {this.wood,
        this.farmone,
        this.farmtwo,
        this.farmthree,
        this.stone,
        this.tcoinamount,
        this.stoneamount,
        this.woodamount,
      this.content});

  WatchAdModel.fromJson(Map<String, dynamic> json) {
    wood = json['wood'];
    farmone = json['farmone'];
    farmtwo = json['farmtwo'];
    farmthree = json['farmthree'];
    stone = json['stone'];
    tcoinamount = json['tcoinamount'];
    stoneamount = json['stoneamount'];
    woodamount = json['woodamount'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wood'] = this.wood;
    data['farmone'] = this.farmone;
    data['farmtwo'] = this.farmtwo;
    data['farmthree'] = this.farmthree;
    data['stone'] = this.stone;
    data['tcoinamount'] = this.tcoinamount;
    data['stoneamount'] = this.stoneamount;
    data['woodamount'] = this.woodamount;
    data['content'] = this.content;
    return data;
  }
}