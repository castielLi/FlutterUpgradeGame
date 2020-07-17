class GetTradeByTypeRequestModel {
  int page;
  int type;

  GetTradeByTypeRequestModel({this.page, this.type});

  GetTradeByTypeRequestModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['type'] = this.type;
    return data;
  }
}