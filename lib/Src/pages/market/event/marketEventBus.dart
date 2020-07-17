
//订阅者回调签名
import 'package:dio/dio.dart';


class MarketHttpRequestEvent {
  Map eventMap;

  factory MarketHttpRequestEvent() =>_getInstance();
  static MarketHttpRequestEvent get instance => _getInstance();
  static MarketHttpRequestEvent _instance;

  MarketHttpRequestEvent._internal() {
    // 初始化
    this.eventMap = new Map<String, VoidCallback>();
  }

  //添加订阅者
  void on(eventName, VoidCallback callback) {
    if (eventName == null || callback == null) return;
    eventMap[eventName]=callback;
  }

  //触发事件，事件触发后该事件所有订阅者会被调用
  void emit(eventName) {
    var callback = eventMap[eventName];
    callback();
  }

  void off(){
    this.eventMap.clear();
  }

  static MarketHttpRequestEvent _getInstance() {
    if (_instance == null) {
      _instance = new MarketHttpRequestEvent._internal();
    }
    return _instance;
  }
}