import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/storge/localStore.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Src/pages/login/model/LoginResponseModel.dart';
import 'package:upgradegame/Src/pages/login/requstModel/login.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/baseUserInfoModel.dart';
import 'dart:convert' as convert;

class LoginService{
  static Future<ResultData> login(String wechat,callback) async{

    Login requstModel = Login(wechat: wechat);
    String params = convert.jsonEncode(requstModel);

    var response = await httpManager.request(
        ServiceUrl.login(), params, null, Options(method: "post"));
    LoginReponseModel responseModel = LoginReponseModel.fromJson(response.data);
    callback(responseModel.userinfo);
  }

  //用于判断用户是否登录
  static Future<String> getToken() async {
    var token = await LocalStorage.get(Config.TOKEN_KEY);
    if (token != null) {
      return token;
    }
    return null;
  }
}