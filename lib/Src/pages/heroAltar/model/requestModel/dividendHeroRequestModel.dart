class DividendHeroRequestModel {
  int type;
  String id;

  DividendHeroRequestModel({this.type,this.id});

  DividendHeroRequestModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    return data;
  }
}