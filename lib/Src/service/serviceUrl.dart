class ServiceUrl {
  static const String host =
  ///fastock
//      "https://www.fastmock.site/mock/095e3520b3833640934d29559631cc16/";
  ///server
  "https://test.buluo888.com/";
  static const String downloadUrl = '';

  /// rule
  static getRule() {
    return "${host}api/v1/rule";
  }

  /// login
  static login() {
    return "${host}api/v1/login";
  }

  ///getuser
  static getuser() {
    return "${host}api/v1/user";
  }

  ///观看广告
  static watchAd(){
    return "${host}api/v1/ad/watch";
  }

  static getUserInfo(){
    return "${host}api/v1/user";
  }

  ///storeList
  static getStoreList() {
    return "${host}api/v1/voucher/list";
  }

  ///购买英雄
  static buyHero() {
    return "${host}api/v1/hero/buy";
  }

  ///购买赠送券
  static buyVocher() {
    return "${host}api/v1/voucher/buy";
  }

  /// 广告分红
  static getAdDividendList() {
    return "${host}api/v1/adincome";
  }

  /// 排行榜
  static getRankList() {
    return "${host}api/v1/rank";
  }

  /// 团队
  static getTeamList() {
    return "${host}api/v1/team";
  }

  /// 公告
  static getAnnouncementList() {
    return "${host}api/v1/announcement";
  }
  /// 攻略
  static getRaidersList(){
    return "${host}api/v1/strategy";
  }

  /// 获取t币
  static takeCoin() {
    return "${host}api/v1/mainbuild/tcoin/fetch";
  }
  /// 获取协议
  static getProtocol(){
    return "${host}api/v1/useragreement";
  }
  /// 关于我们
  static getAboutUs(){
    return "${host}api/v1/aboutus";
  }
  /// 隐私条款
  static getPrivacyPolicy(){
    return "${host}api/v1/privacy";
  }

  /// 升级建筑
  static upgradeBuilding(){
    return "${host}api/v1/upgradebuilding";
  }
}

