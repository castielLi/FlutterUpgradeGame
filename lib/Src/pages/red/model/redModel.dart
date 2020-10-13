class RedModel {
  String cashamount;

  RedModel({this.cashamount});

  RedModel.fromJson(Map<String, dynamic> json) {
    cashamount = json['cashamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cashamount'] = this.cashamount;
    return data;
  }
}