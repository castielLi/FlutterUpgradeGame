class SetAttackRequestModel {
  String jsonstring;

  SetAttackRequestModel({this.jsonstring});

  SetAttackRequestModel.fromJson(Map<String, dynamic> json) {
    jsonstring = json['jsonstring'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonstring'] = this.jsonstring;
    return data;
  }
}