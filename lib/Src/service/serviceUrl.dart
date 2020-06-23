class ServiceUrl {
  static const String host =
      "https://www.fastmock.site/mock/095e3520b3833640934d29559631cc16/";
//  "http://192.168.31.57:80/";
  static const String downloadUrl = '';

  /// rule
  static getRule() {
    return "${host}api/v1/rule";
  }

  /// login
  static login() {
    return "${host}api/v1/user";
  }

  static getUserInfo(){
    return "${host}api/v1/user";
  }

  ///storeList
  static getStoreList() {
    return "${host}api/v1/voucher/list";
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
    return "${host}api/api/useragreement";
  }
  /// 关于我们
  static getAboutUs(){
    return "${host}api/api/aboutus";
  }
  /// 隐私条款
  static getPrivacyPolicy(){
    return "${host}api/api/privacy";
  }

}

