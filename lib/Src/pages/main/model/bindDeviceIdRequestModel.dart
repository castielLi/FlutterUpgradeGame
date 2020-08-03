class BindDeviceIdRequestModel {
  String deviceid;

  BindDeviceIdRequestModel({this.deviceid});

  BindDeviceIdRequestModel.fromJson(Map<String, dynamic> json) {
    deviceid = json['deviceid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceid'] = this.deviceid;
    return data;
  }
}