import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/userInfo/model/requestModel/changePasswordRequestModel.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'dart:convert' as convert;

class AccountService {
  static Future<ResultData> changePassword(password, phone,callback) async {
    ChangePasswordRequestModel requestModel = new ChangePasswordRequestModel(password: password,phone: phone);
    String params = convert.jsonEncode(requestModel);
    var response = await httpManager.request(ServiceUrl.changePassword(), params, null, Options(method: "post"));
    if (ConfigSetting.SUCCESS == response.code) {
      callback(response.code);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(null);
    }
  }
}
