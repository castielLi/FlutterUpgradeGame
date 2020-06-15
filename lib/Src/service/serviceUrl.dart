
class ServiceUrl{

  static const String host = "https://www.fastmock.site/mock/095e3520b3833640934d29559631cc16/";
  static const String downloadUrl = '';

  /// rule
  static getRule(){
    return "${host}api/v1/rule";
  }

  /// login
  static login() {
    return "${host}api/v1/user";
  }

  ///storeList
  static getStoreList(){
    return "${host}api/v1/voucher/list";
  }

  /// 广告分红
  static getAdDividendList(){
    return "${host}api/v1/adincome";
  }
  /// 排行榜
  static getRankList(){
    return "${host}api/v1/rank";
  }

  /// 团队
  static getTeamList(){
    return "${host}api/v1/team";
  }

  /// 公告
  static getAnnouncementList(){
    return "${host}api/v1/announcement";
  }
}