import 'dart:async';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/trainArmy/model/attackModel.dart';
import 'package:upgradegame/Src/pages/trainArmy/model/requestModel/SetAttackRequsetModel.dart';
import 'package:upgradegame/Src/pages/trainArmy/model/requestModel/SetProtectRequestModel.dart';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class ArmyService {
  static Future<ResultData> setProtectLineup(List<List<int>> protectLineup,callback) async {

    List<List<int>> a = [[0,1,0],[2,0,0],[0,0,1],[1,0,0],[3,0,0]];

    SetProtectRequestModel requestModel = SetProtectRequestModel(jsonstring: convert.jsonEncode(a));

    var params = convert.jsonEncode(requestModel);
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

    List<List<int>> a = [[0,1,0],[0,1,0],[1,0,0],[2,0,0],[0,0,1]];

    SetAttackRequestModel requestModel = SetAttackRequestModel(jsonstring: convert.jsonEncode(a));

    var params = convert.jsonEncode(requestModel);
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
