class GetUserWithdrawRequestModel {
  int page;

  GetUserWithdrawRequestModel({this.page});

  GetUserWithdrawRequestModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    return data;
  }
}