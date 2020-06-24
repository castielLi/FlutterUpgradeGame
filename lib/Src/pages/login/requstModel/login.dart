class Login {
  String wechat;

  Login({this.wechat});

  Login.fromJson(Map<String, dynamic> json) {
    wechat = json['wechat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wechat'] = this.wechat;
    return data;
  }
}