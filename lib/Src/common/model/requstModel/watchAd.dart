class WatchAd {
  int type;
  int datetime;

  WatchAd({this.type,this.datetime});

  WatchAd.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['datetime'] = this.datetime;
    return data;
  }
}