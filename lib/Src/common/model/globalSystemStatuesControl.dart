
import 'package:event_bus/event_bus.dart';

class GlobalSystemStatuesControl {
  // 工厂模式
  factory GlobalSystemStatuesControl() =>_getInstance();
  static GlobalSystemStatuesControl get instance => _getInstance();
  static GlobalSystemStatuesControl _instance;
  bool active;
  EventBus eventBus = new EventBus();
  GlobalSystemStatuesControl._internal() {
    // 初始化
    this.active = true;
  }


  static GlobalSystemStatuesControl _getInstance() {
    if (_instance == null) {
      _instance = new GlobalSystemStatuesControl._internal();
    }
    return _instance;
  }

  static systemKill(){
    _instance = null;
  }

  static setSystemForegournd(){
    _instance.active = true;
    _instance.eventBus.fire(new SystemStatus(true));
  }

  static setSystemBackground(){
    _instance.active = false;
    _instance.eventBus.fire(new SystemStatus(false));
  }
}

class SystemStatus {
  final bool active;

  SystemStatus(this.active);
}