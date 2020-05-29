import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/storge/localStore.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/baseUserInfoModel.dart';

class LoginService{
  static Future<ResultData> login(callback) async{

    var response = await httpManager.request(
        ServiceUrl.login(), {}, null, null);
    BaseUserInfoModel model = BaseUserInfoModel.fromJson(response.data);
    callback(model);
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