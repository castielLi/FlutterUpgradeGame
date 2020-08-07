import 'dart:async';

import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class RaidersService {
  static Future<ResultData> getRaidersList(callback) async {
    var response = await httpManager.request(ServiceUrl.getRaidersList(), {}, null, null);
    if (ConfigSetting.SUCCESS == response.code) {
      callback(response.data);
    } else {
      CommonUtils.showErrorMessage(msg: '网络请求失败，请重试');
      callback(null);
    }
    return response;
  }
}
