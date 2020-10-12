class Login {
  String code;
  String deviceid;
  String sign;

  Login({this.code,this.deviceid,this.sign});

  Login.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    deviceid = json['deviceId'];
    sign = json['sign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['deviceId'] = this.deviceid;
    data['sign'] = this.sign;
    return data;
  }
}