import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/resultData.dart';

///是否需要弹提示
const NOT_TIP_KEY = "noTip";

///错误拦截
class ErrorInterceptors extends InterceptorsWrapper {
  final Dio _dio;

  ErrorInterceptors(this._dio);

  @override
  onRequest(RequestOptions options) async {
    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return _dio.resolve(new ResultData(null,
          ConfigSetting.errorHandleFunction(ConfigSetting.NETWORK_ERROR, "", false),
          ConfigSetting.NETWORK_ERROR));
    }
    return options;
  }
}
