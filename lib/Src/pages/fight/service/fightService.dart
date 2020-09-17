import 'dart:async';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/fight/model/fightInfoModel.dart';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class FightService {
  static Future<ResultData> getFightInfo(callback) async {

    var response = await httpManager.request(ServiceUrl.getFightInfo(), {}, null, Options(method: "post"));
    if (response.code == 200) {
      FightInfoModel model = FightInfoModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(null);
    }
  }
}
