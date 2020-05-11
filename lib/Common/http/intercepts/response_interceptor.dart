import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/resultData.dart';

///返回结果封装
class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) async {
    RequestOptions option = response.request;
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return new ResultData(response.data, true, ConfigSetting.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + option.path);
      return new ResultData(response.data, false, response.statusCode,
          headers: response.headers);
    }
  }
}
