class SetProtectRequestModel {
  String jsonstring;

  SetProtectRequestModel({this.jsonstring});

  SetProtectRequestModel.fromJson(Map<String, dynamic> json) {
    jsonstring = json['jsonstring'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonstring'] = this.jsonstring;
    return data;
  }
}