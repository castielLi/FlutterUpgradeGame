import 'dart:async';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/requstModel/watchAd.dart';
import 'package:upgradegame/Src/common/model/watchAdModel.dart';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class AdService {
  static Future<ResultData> watchAd(int type, callback) async {
    int dateTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    WatchAd ad = new WatchAd(type: type, datetime: dateTime);
    String params = convert.jsonEncode(ad);

    ///农场1 伐木场2 采石场3
    var response = await httpManager.request(ServiceUrl.watchAd(), params, null, Options(method: "post"));
    if (response.code == 200) {
      WatchAdModel model = WatchAdModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: "观看广告请求出错");
      callback(null);
    }
  }
}
