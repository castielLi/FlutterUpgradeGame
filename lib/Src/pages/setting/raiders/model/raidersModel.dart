class RaidersModel {
  String basic;
  String advanced;

  RaidersModel({this.basic, this.advanced});

  RaidersModel.fromJson(Map<String, dynamic> json) {
    basic = json['basic'];
    advanced = json['advanced'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['basic'] = this.basic;
    data['advanced'] = this.advanced;
    return data;
  }
}