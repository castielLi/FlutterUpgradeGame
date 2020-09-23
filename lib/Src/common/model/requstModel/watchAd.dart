class WatchAd {
  int type;
  int datetime;
  String sign;

  WatchAd({this.type,this.datetime,this.sign});

  WatchAd.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    datetime = json['datetime'];
    sign = json['sign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['datetime'] = this.datetime;
    data['sign'] = this.sign;
    return data;
  }
}