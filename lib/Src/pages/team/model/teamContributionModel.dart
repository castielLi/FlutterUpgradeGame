class TeamContributionModel {
  Today today;
  Today yesterday;

  TeamContributionModel({this.today, this.yesterday});

  TeamContributionModel.fromJson(Map<String, dynamic> json) {
    today = json['today'] != null ? new Today.fromJson(json['today']) : null;
    yesterday = json['yesterday'] != null
        ? new Today.fromJson(json['yesterday'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.today != null) {
      data['today'] = this.today.toJson();
    }
    if (this.yesterday != null) {
      data['yesterday'] = this.yesterday.toJson();
    }
    return data;
  }
}

class Today {
  int total;
  int my;
  int first;
  int second;
  int exchange;

  Today({this.total, this.my, this.first, this.second,this.exchange});

  Today.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    exchange = json['exchange'];
    my = json['my'];
    first = json['first'];
    second = json['second'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['my'] = this.my;
    data['exchange'] = this.exchange;
    data['first'] = this.first;
    data['second'] = this.second;
    return data;
  }
}