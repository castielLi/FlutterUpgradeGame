import 'package:upgradegame/Src/common/model/baseRuleModel.dart';

class Global {
  // 工厂模式
  factory Global() =>_getInstance();
  static Global get instance => _getInstance();
  static Global _instance;
  Global._internal() {
    // 初始化
  }

  static BaseRuleModel rule;


  static setBaseRule(BaseRuleModel ruleModel){
    Global.rule = ruleModel;
  }

  static getMainBuildingRule(){
    return rule.mainbuild;
  }

  static Global _getInstance() {
    if (_instance == null) {
      _instance = new Global._internal();
    }
    return _instance;
  }
}