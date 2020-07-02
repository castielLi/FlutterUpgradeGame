import 'package:flutter/services.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Src/common/model/requstModel/watchAd.dart';
import 'package:upgradegame/Src/common/model/userInfoAd.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'dart:convert' as convert;

class AdService {
  static Future<ResultData> watchAd(int type, callback) async {
    WatchAd ad = new WatchAd(type: type);
    String params = convert.jsonEncode(ad);

    var response = await httpManager.request(ServiceUrl.watchAd(), params, null, Options(method: "post"));

    callback();
  }
}
