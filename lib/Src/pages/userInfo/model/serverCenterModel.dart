class ServerCenterModel {
  String qq;
  String wechat;

  ServerCenterModel({this.qq, this.wechat});

  ServerCenterModel.fromJson(Map<String, dynamic> json) {
    qq = json['qq'];
    wechat = json['wechat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qq'] = this.qq;
    data['wechat'] = this.wechat;
    return data;
  }
}