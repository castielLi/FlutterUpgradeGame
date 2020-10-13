import 'dart:async';

import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/red/model/redModel.dart';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class RedService {
  static Future<ResultData> recycleRed(callback) async {
    var response = await httpManager.request(ServiceUrl.recycleRed(), {}, null, Options(method: "post"));
    if (ConfigSetting.SUCCESS == response.code) {
      RedModel model = RedModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(null);
    }
    return response;
  }
}
