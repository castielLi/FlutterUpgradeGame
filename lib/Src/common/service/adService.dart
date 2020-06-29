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
  static AdType adType;

  static Future<ResultData> watchAd(int type, callback) async {
    WatchAd ad = new WatchAd(type: type);
    String params = convert.jsonEncode(ad);

    var response = await httpManager.request(ServiceUrl.watchAd(), params, null, Options(method: "post"));

    callback();
  }

  void showAd(int type, int showType, [String posId]) async {
    const platform = const MethodChannel('samples.flutter.ad');
    const EventChannel _eventChannel = const EventChannel('samples.flutter.ad.event');
    _eventChannel.receiveBroadcastStream().listen(this._onEvent, onError: this._onError);
    try {
      await platform.invokeMethod('showAd', <String, dynamic>{'type': type, "showType": showType, "posId": posId});
    } on PlatformException catch (e) {
      print(e);
    }
  }

  void _onEvent(Object event) {
    print("event »" + event);
  }

  void _onError(Object error) {
    print("event »" + error);
  }

  void adWatchSuccess(VoidCallback callBack){

  }
}
