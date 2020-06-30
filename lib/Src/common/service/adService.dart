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
  static const platform = const MethodChannel('samples.flutter.ad');
  static const EventChannel _eventChannel = const EventChannel('samples.flutter.ad.event');
  VoidCallback adWatchSuccessCallback;

  AdService({this.adWatchSuccessCallback}){
    print('初始化');
    _eventChannel.receiveBroadcastStream().listen(this._onEvent, onError: this._onError);
  }

  static Future<ResultData> watchAd(int type, callback) async {
    WatchAd ad = new WatchAd(type: type);
    String params = convert.jsonEncode(ad);

    var response = await httpManager.request(ServiceUrl.watchAd(), params, null, Options(method: "post"));

    callback();
  }

  void showAd(int type, int showType, [String posId]) async {
    try {
      print('show add');
      await platform.invokeMethod('showAd', <String, dynamic>{'type': type, "showType": showType, "posId": posId});
    } on PlatformException catch (e) {
      print(e);
    }
  }

  void _onEvent(Object event) {
    print("广告观看状态!!!!!："+event.toString());
    if("5"==event.toString()){
      print("广告观看成功!!!!!!");
//      this.adWatchSuccessCallback();
    }
    print("event »" + event.toString());
  }

  void _onError(Object error) {
    print("error »" + error.toString());
  }
}
