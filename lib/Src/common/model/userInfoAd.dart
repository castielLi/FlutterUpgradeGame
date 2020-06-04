
class Ad {
  int wood;
  int stone;
  int farm;

  Ad({this.wood, this.stone, this.farm});

  Ad.fromJson(Map<String, dynamic> json) {
    wood = json['wood'];
    stone = json['stone'];
    farm = json['farm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wood'] = this.wood;
    data['stone'] = this.stone;
    data['farm'] = this.farm;
    return data;
  }
}