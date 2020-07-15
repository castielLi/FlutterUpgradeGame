
//订阅者回调签名
import 'package:dio/dio.dart';


class SettingHttpRequestEvent {
  Map eventMap;

  factory SettingHttpRequestEvent() =>_getInstance();
  static SettingHttpRequestEvent get instance => _getInstance();
  static SettingHttpRequestEvent _instance;

  SettingHttpRequestEvent._internal() {
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

  static SettingHttpRequestEvent _getInstance() {
    if (_instance == null) {
      _instance = new SettingHttpRequestEvent._internal();
    }
    return _instance;
  }
}