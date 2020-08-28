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
  VoidCallback adWatchFailedCallback;
  Function(int) adOperateFailedCallback;

  factory AdDialog() =>_getInstance();
  static AdDialog get instance => _getInstance();
  static AdDialog _instance;

  bool openApp;
  bool initAdViewSuccess;
  int adStatus = -100;
  bool dialogState = false;
  ///广告类型
  int type;

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

  void setCallback(VoidCallback adWatchSuccessCallback,VoidCallback adWatchFailedCallback,Function(int) adOperateFailedCallback,bool openApp){
    this.openApp = openApp;
    this.adWatchSuccessCallback = adWatchSuccessCallback;
    this.adWatchFailedCallback = adWatchFailedCallback;
    this.adOperateFailedCallback = adOperateFailedCallback;
  }

  ///type选择平台  1：adview 2：baidu 3：腾讯
  ///showType 选择展示 方式 1：开屏广告 2：视频广告
  ///posid 为可选则参数如果有第三个posid参数则用传过来的 否则为andorid模块内默认参数， posid为广告位id
  void showAd(int type, int showType, [String posId]) async {
    this.dialogState = true;
    this.type = type;
    try {
      await platform.invokeMethod('showAd', <String, dynamic>{'type': type, "showType": showType, "posId": posId});
    } on PlatformException catch (e) {
      this.dialogState = false;
      if(type == 1 && showType == 1){
        if(this.adWatchFailedCallback != null){
          this.adWatchFailedCallback();
        }
      }else{
        if(this.adOperateFailedCallback != null){
          this.adOperateFailedCallback(this.type);
        }
      }

      print(e);
    }
  }

  void _onEvent(Object event) {
    if(openApp){
      if("5"==event.toString() || "4" == event.toString()){
        this.initAdViewSuccess = true;
        if(this.adWatchSuccessCallback != null){
          this.adWatchSuccessCallback();
          this.dialogState = false;
        }
      }else if("-1"==event.toString()){
        this.initAdViewSuccess = false;
        if(this.adWatchFailedCallback != null){
          this.adWatchFailedCallback();
          this.dialogState = false;
        }
      }
    }else{
      ///广告出错回调
      if("-1"==event.toString()){
        this.initAdViewSuccess = false;
        if(this.adOperateFailedCallback != null){
          this.dialogState = false;
          this.adOperateFailedCallback(this.type);
        }
      }

      ///返回广告看完的回调
      if ("5"==event.toString()){
        if(this.adWatchSuccessCallback != null){
          this.adWatchSuccessCallback();
          this.adStatus = -100;
          this.dialogState = false;
        }
      }
      ///返回广告已经观看了30秒可以领取资源的回调
      if("6" == event.toString()){
        if(dialogState) {
          this.adStatus = 6;
        }
      }
      ///返回广告关闭的回调
      if("4" == event.toString()){
        if(this.adStatus == 6){
          if(this.adWatchSuccessCallback != null){
            this.adWatchSuccessCallback();
            this.adStatus = -100;
            this.dialogState = false;
          }
        }else{
          if(this.adWatchFailedCallback != null && this.dialogState){
            this.adWatchFailedCallback();
            this.adStatus = -100;
            this.dialogState = false;
          }
        }
      }
    }
    print("=========================================================");
    print("event »" + event.toString());
  }

  void _onError(Object error) {
    print("error »" + error.toString());
  }
}
