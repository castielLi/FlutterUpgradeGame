import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:upgradegame/Src/common/model/userInfoAd.dart';

class AdDialog {

  static const adview = "POSID8rbrja0ih10i";
  static const baidu = "7111030";
  static const tencent = "6031610694170610";

  static AdType adType;
  static const platform = const MethodChannel('samples.flutter.ad');
  static const EventChannel _eventChannel = const EventChannel('samples.flutter.ad.event');
  VoidCallback adWatchSuccessCallback;

  factory AdDialog() =>_getInstance();
  static AdDialog get instance => _getInstance();
  static AdDialog _instance;

  bool openApp;
  bool initAdViewSuccess;

  AdDialog._internal() {
    // 初始化
    _eventChannel.receiveBroadcastStream().listen(this._onEvent, onError: this._onError);
    this.openApp = true;
    this.initAdViewSuccess = false;
  }

  static AdDialog _getInstance() {
    if (_instance == null) {
      _instance = new AdDialog._internal();
    }
    return _instance;
  }

  void setCallback(VoidCallback adWatchSuccessCallback,bool openApp){
    this.openApp = openApp;
    this.adWatchSuccessCallback = adWatchSuccessCallback;
  }

  ///type选择平台  1：adview 2：baidu 3：腾讯
  ///showType 选择展示 方式 1：开屏广告 2：视频广告
  ///posid 为可选则参数如果有第三个posid参数则用传过来的 否则为andorid模块内默认参数， posid为广告位id
  void showAd(int type, int showType, [String posId]) async {
    try {
      await platform.invokeMethod('showAd', <String, dynamic>{'type': type, "showType": showType, "posId": posId});
    } on PlatformException catch (e) {
      print(e);
    }
  }

  void _onEvent(Object event) {
    print("广告观看状态!!!!!："+event.toString());
    if(openApp){
      if("5"==event.toString() || "4" == event.toString()){
        print("广告观看成功!!!!!!");
        this.initAdViewSuccess = true;
        if(this.adWatchSuccessCallback != null){
          this.adWatchSuccessCallback();
        }
      }else if("-1"==event.toString()){
        this.initAdViewSuccess = false;
      }
    }else if ("5"==event.toString()){
      print("广告观看成功!!!!!!");
      if(this.adWatchSuccessCallback != null){
        this.adWatchSuccessCallback();
      }
    }
    print("event »" + event.toString());
  }

  void _onError(Object error) {
    print("error »" + error.toString());
  }
}
