

import 'package:event_bus/event_bus.dart';

class NotificationEvent {
  // 工厂模式
  factory NotificationEvent() =>_getInstance();
  static NotificationEvent get instance => _getInstance();
  static NotificationEvent _instance;
  EventBus eventBus;
  String deviceId;
  NotificationEvent._internal() {
    // 初始化
    this.eventBus = EventBus();
    this.deviceId = "";
  }

  static fireEvent(Map<String, dynamic> message){
    _instance.eventBus.fire(RecieveNotificationEvent(message));
  }

  static setDeviceId(String deviceId){
    _instance.deviceId = deviceId;
  }


  static NotificationEvent _getInstance() {
    if (_instance == null) {
      _instance = new NotificationEvent._internal();
    }
    return _instance;
  }
}

class RecieveNotificationEvent{
  Map<String, dynamic> message;
  RecieveNotificationEvent(this.message);
}