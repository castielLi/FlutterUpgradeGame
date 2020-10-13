class HoldHeroDisplayModel {
  int days;
  String id;
  bool collected;

  HoldHeroDisplayModel({this.days, this.id,this.collected});

  HoldHeroDisplayModel.fromJson(Map<String, dynamic> json) {
    days = json['days'];
    id = json['id'];
    collected = json['collected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['days'] = this.days;
    data['id'] = this.id;
    data['collected'] = this.collected;
    return data;
  }
}