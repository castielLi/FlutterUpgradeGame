class Login {
  String code;
  String deviceid;

  Login({this.code,this.deviceid});

  Login.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    deviceid = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['deviceId'] = this.deviceid;
    return data;
  }
}