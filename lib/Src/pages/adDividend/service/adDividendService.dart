import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'package:upgradegame/Src/pages/adDividend/model/AdDividendModel.dart';

class AdDividendService {
  static Future<ResultData> getAdDividendList(callback) async {
    var response = await httpManager.request(ServiceUrl.getAdDividendList(), {}, null, null);
    if (ConfigSetting.SUCCESS == response.code) {
      AdDividendListModel model = AdDividendListModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: '网络请求失败，请重试');
      callback(null);
    }
    return response;
  }
}
