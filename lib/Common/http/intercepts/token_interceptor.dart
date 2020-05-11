import 'package:dio/dio.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/storge/localStore.dart';

class TokenInterceptor extends InterceptorsWrapper {
  String _token;

  @override
  onRequest(RequestOptions options) async {
    ///添加授权码
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        _token = authorizationCode;
      }
    }
    options.headers["Authorization"] = _token;
    return options;
  }

  ///清除本地授权
  clearAuthorization() async {
    this._token = null;
    LocalStorage.remove(Config.TOKEN_KEY);
  }

  ///获取授权token
  getAuthorization() async {
    String token = await LocalStorage.get(Config.TOKEN_KEY);
    return token;
  }
}
