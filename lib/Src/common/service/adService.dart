import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/globalDataModel.dart';
import 'package:upgradegame/Src/common/model/requstModel/watchAd.dart';
import 'package:upgradegame/Src/common/model/watchAdModel.dart';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';

class AdService {
  static Future<ResultData> watchAd(int type, callback) async {
    int dateTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    String sign = generateMd5(dateTime.toString()+Global.getKey());

    WatchAd ad = new WatchAd(type: type, datetime: dateTime,sign:sign);
    String params = convert.jsonEncode(ad);

    ///农场1 伐木场2 采石场3
    var response = await httpManager.request(ServiceUrl.watchAd(), params, null, Options(method: "post"));
    if (response.code == 200) {
      WatchAdModel model = WatchAdModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(null);
    }
  }

  static String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }
}
