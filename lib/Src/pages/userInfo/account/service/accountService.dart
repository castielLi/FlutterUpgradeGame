import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/user.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'dart:convert' as convert;

class AccountService {
//  static Future<ResultData> changePassword(password, callback) async {
//    User user = new User(password: password);
//    String params = convert.jsonEncode(user);
//    var response = await httpManager.request(ServiceUrl.changePassword(), params, null, Options(method: "post"));
//    if (ConfigSetting.SUCCESS == response.code) {
//      callback(response.code);
//    } else {
//      CommonUtils.showErrorMessage(msg: '网络请求失败，请重试');
//      callback(null);
//    }
//    return response;
//  }
}
