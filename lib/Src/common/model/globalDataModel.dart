import 'package:upgradegame/Src/common/model/baseRuleModel.dart';
import 'package:upgradegame/Src/common/model/extraRuleModel.dart';

class Global {
  // 工厂模式
  factory Global() =>_getInstance();
  static Global get instance => _getInstance();
  static Global _instance;
  Global._internal() {
    // 初始化
  }

  static BaseRuleModel rule;
  static ExtraRuleModel extraRule;

  static setBaseRule(BaseRuleModel ruleModel){
    Global.rule = ruleModel;
  }

  static setExtraRule(ExtraRuleModel extraRuleModel){
    Global.extraRule = extraRuleModel;
  }

  static getCoinBuyContribution(){
    return rule.contributionbuyrate;
  }

  ///获取广告配置比例
  static getAdSettingValue(){
    return extraRule;
  }


  ///获取是否显示返上级分红配置
  static getCashBackSetting(){
//    return extraRule.cashback;
  return true;
  }


  ///获取最低提现金额
  static getWithdrawLimit(){
    return rule.withdrawlimit;
  }

  ///获取主建筑规则
  static getMainBuildingRule(){
    return rule.mainbuild;
  }

  ///获取采石场建筑规则
  static getStoneBuildingRule(){
    return null==rule?null:rule.stone;
  }

  ///获取伐木场建筑规则
  static getWoodBuildingRule(){
    return null==rule?null:rule.wood;
  }

  ///获取农场建筑规则
  static getFarmBuildingRule(){
    return null==rule?null:rule.farm;
  }

  ///获取广告次数规则
  static getAdSettingRule(){
    return null==rule?null:rule.adSetting;
  }

  static Global _getInstance() {
    if (_instance == null) {
      _instance = new Global._internal();
    }
    return _instance;
  }
}