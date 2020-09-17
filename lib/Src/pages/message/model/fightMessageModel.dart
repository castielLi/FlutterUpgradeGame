class FightMessageModel {
  int page;
  int total;
  List<Datalist> datalist;

  FightMessageModel({this.page, this.total, this.datalist});

  FightMessageModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    total = json['total'];
    if (json['datalist'] != null) {
      datalist = new List<Datalist>();
      json['datalist'].forEach((v) {
        datalist.add(new Datalist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total'] = this.total;
    if (this.datalist != null) {
      data['datalist'] = this.datalist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datalist {
  String time;
  String displayname;
  String lineup;

  Datalist({this.time, this.displayname, this.lineup});

  Datalist.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    displayname = json['displayname'];
    lineup = json['lineup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['displayname'] = this.displayname;
    data['lineup'] = this.lineup;
    return data;
  }
}