class ServiceUrl {
  static const String host =
//      "https://test.buluo888.com/";
  "http://192.168.31.57:8080/";
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
}
