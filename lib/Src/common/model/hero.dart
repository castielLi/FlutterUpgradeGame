

class Heroes {
  int type;
  int days;

  Heroes({this.type, this.days});

  Heroes.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    days = json['days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['days'] = this.days;
    return data;
  }
}