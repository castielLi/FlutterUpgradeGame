
class ServiceUrl{

  static const String host = "https://www.fastmock.site/mock/095e3520b3833640934d29559631cc16/";
  static const String downloadUrl = '';

  /// login
  static login() {
    return "${host}api/user";
  }



  /// main
  static getBaseInfo(){
    return "${host}api/user";
  }
}