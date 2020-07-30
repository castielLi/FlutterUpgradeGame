class Ad {
  int wood;
  int stone;
  int farmone;
  int farmtwo;
  int farmthree;

  Ad({this.wood, this.stone, this.farmone, this.farmtwo, this.farmthree});

  Ad.fromJson(Map<String, dynamic> json) {
    wood = json['wood'];
    stone = json['stone'];
    farmone = json['farmone'];
    farmtwo = json['farmtwo'];
    farmthree = json['farmthree'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wood'] = this.wood;
    data['stone'] = this.stone;
    data['farmone'] = this.farmone;
    data['farmtwo'] = this.farmtwo;
    data['farmthree'] = this.farmthree;
    return data;
  }
}

enum AdType {
  wood,
  stone,
  farm,
}
