import 'dart:async';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/trainArmy/model/attackModel.dart';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class RecycleService {
  static Future<ResultData> setProtectLineup(List<List<int>> protectLineup,callback) async {

    var params = convert.jsonEncode(protectLineup);
    var response = await httpManager.request(ServiceUrl.setProtectLine(), params, null, Options(method: "post"));
    if (ConfigSetting.SUCCESS == response.code) {
      callback(true);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(false);
    }
    return response;
  }

  static Future<ResultData> attack(List<List<int>> attacLineup,callback) async {

    var params = convert.jsonEncode(attacLineup);
    var response = await httpManager.request(ServiceUrl.attack(), params, null, Options(method: "post"));
    if (ConfigSetting.SUCCESS == response.code) {
      AttackModel model = AttackModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(null);
    }
    return response;
  }

}
