import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class AdDividendService {
  static Future<ResultData> getAdDividendList(callback) async {
    var response = await httpManager.request(ServiceUrl.getAdDividendList(), {}, null, null);
    if (200 == response.code) {
      callback(response.data);
    } else {
      CommonUtils.showErrorMessage(msg: '网络请求失败，请重试');
      callback(null);
    }
    return response;
  }
}
