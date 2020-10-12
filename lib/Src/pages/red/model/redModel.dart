class RedModel {
  String cash;

  RedModel({this.cash});

  RedModel.fromJson(Map<String, dynamic> json) {
    cash = json['cash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cash'] = this.cash;
    return data;
  }
}