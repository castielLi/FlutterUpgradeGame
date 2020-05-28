
class ResultData {
  int code;
  String message;
  dynamic data;

  ResultData(this.data, this.message,this.code);

  ResultData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }
}