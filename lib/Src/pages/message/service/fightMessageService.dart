import 'dart:async';

import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/message/model/fightMessageModel.dart';
import 'package:upgradegame/Src/pages/message/model/fightMessageRequestModel.dart';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'dart:convert' as convert;

class FightMessageService {
  static Future<ResultData> getFightMessage(int page, callback) async {

    FightMessageRequestModel requestModel = FightMessageRequestModel(page:page);
    var param = convert.jsonEncode(requestModel);

    var response = await httpManager.request(ServiceUrl.getFightMessageList(), param, null, Options(method: "post"));
    if (ConfigSetting.SUCCESS == response.code) {
      FightMessageModel model = FightMessageModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(null);
    }
    return response;
  }
}
