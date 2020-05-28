import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/storge/localStore.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';

class LoginService{
//  static Future<ResultData> login() async{
//
//    var response = await httpManager.request(
//        ServiceUrl.login(), {}, null, new Options(method: 'post'));
//    ApiResult model = ApiResult.fromJson(response.data);
//    if (model.status == 0) {
//      await LocalStorage.save(Config.TOKEN_KEY, model.tag);
//      return ResultData(null, true);
//    } else {
//      CommonUtils.showWarningMessage(msg: '用户名或密码错误');
//    }
//    return ResultData(null, false);
//
//  }

  //用于判断用户是否登录
  static Future<String> getToken() async {
    var token = await LocalStorage.get(Config.TOKEN_KEY);
    if (token != null) {
      return token;
    }
    return null;
  }
}