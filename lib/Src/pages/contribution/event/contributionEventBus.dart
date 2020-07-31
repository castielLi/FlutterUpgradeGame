
//订阅者回调签名
import 'package:dio/dio.dart';


class ContributionHttpRequestEvent {
  Map eventMap;

  factory ContributionHttpRequestEvent() =>_getInstance();
  static ContributionHttpRequestEvent get instance => _getInstance();
  static ContributionHttpRequestEvent _instance;

  ContributionHttpRequestEvent._internal() {
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

  static ContributionHttpRequestEvent _getInstance() {
    if (_instance == null) {
      _instance = new ContributionHttpRequestEvent._internal();
    }
    return _instance;
  }
}