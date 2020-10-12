import 'dart:async';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class RedService {
  static Future<ResultData> recycleRed(callback) async {

    var response = await httpManager.request(ServiceUrl.recycleRed(),
        {}, null, Options(method: "post"));
    if (ConfigSetting.SUCCESS == response.code) {

      callback(null);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(null);
    }
    return response;
  }

}
