
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
    return "${host}api/voucher/list";
  }
}