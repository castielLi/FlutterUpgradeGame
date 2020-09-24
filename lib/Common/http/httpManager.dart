import 'dart:async';
import 'dart:collection';

import 'package:dio/dio.dart';
import 'dart:io';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/intercepts/error_interceptor.dart';
import 'package:upgradegame/Common/http/intercepts/header_interceptor.dart';
import 'package:upgradegame/Common/http/intercepts/log_interceptor.dart';
import 'package:upgradegame/Common/http/intercepts/token_interceptor.dart';
import 'package:upgradegame/Common/http/resultData.dart';

class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
  Dio _dio = new Dio(); // 使用默认配置
  //请求头添加上token
  final TokenInterceptor _tokenInterceptor = new TokenInterceptor();

  HttpManager() {
    _dio.interceptors.add(new HeaderInterceptors());
    //对所有请求添加上token
    _dio.interceptors.add(_tokenInterceptor);
    _dio.interceptors.add(new LogsInterceptors());

    //对网络错误进行拦截
    _dio.interceptors.add(new ErrorInterceptors(_dio));
  }

  ///网络请求
  ///[url] 请求url
  ///[ params] 请求参数
  ///[ header] 请求头额外参数
  ///[ option] 配置 post get
  ///返回结果，错误，不管，数据返回即可
  Future<ResultData> request(url, params, Map<String, dynamic> header, Options option, {noTip = false}) async {
    Map<String, dynamic> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "get");
      option.headers = headers;
    }
    Response response;
    try {
      response = await _dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      //错误请求处理
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = ConfigSetting.NETWORK_TIMEOUT;
      }
      return new ResultData(null, ConfigSetting.errorHandleFunction(errorResponse.statusCode, e.message, noTip), errorResponse.statusCode);
    }
    ResultData data = ResultData.fromJson(response.data);
    if (data.code == 401) {
      return new ResultData(null, ConfigSetting.errorHandleFunction(401, "登录信息失效", noTip), 401);
    } else {
      return ResultData.fromJson(response.data);
    }
  }

  /// 下载安卓更新包
  Future<File> downloadAndroid(String storagePath,String url,progressCallback,successCallback) async {
    File file = new File('$storagePath/app-release.apk');
    if (!file.existsSync()) {
      file.createSync();
    }
    try {

      var _downloadDio = new Dio();
      /// 发起下载请求
      Response response = await _downloadDio.get(url,
          onReceiveProgress: (int count,int total){
            double radio = count/total;
            progressCallback(radio);
          },
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
          ));
      file.writeAsBytesSync(response.data);
      successCallback();
    } catch (e) {
      print(e);
    }
  }



  ///清除授权
  clearAuthorization() {
    _tokenInterceptor.clearAuthorization();
  }

  ///获取授权token
  getAuthorization() async {
    return _tokenInterceptor.getAuthorization();
  }
}

final HttpManager httpManager = new HttpManager();
