
import 'package:upgradegame/Src/common/model/baseUserInfoModel.dart';

class LoginReponseModel {
  String token;
  BaseUserInfoModel userinfo;

  LoginReponseModel({this.token, this.userinfo});

  LoginReponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userinfo = json['userinfo'] != null
        ? new BaseUserInfoModel.fromJson(json['userinfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.userinfo != null) {
      data['userinfo'] = this.userinfo.toJson();
    }
    return data;
  }
}