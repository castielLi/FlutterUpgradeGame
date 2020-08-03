import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/storge/fileStore.dart';
import 'package:upgradegame/Common/storge/localStore.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Src/common/model/baseUserInfoModel.dart';
import 'package:upgradegame/Src/pages/main/model/bindDeviceIdRequestModel.dart';
import 'package:upgradegame/Src/pages/main/model/productCoinModel.dart';
import 'package:upgradegame/Src/pages/main/model/takeCoinModel.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'dart:convert' as convert;

class MainService{
  static Future<ResultData> getBaseInfo(callback) async{
    var response = await httpManager.request(
        ServiceUrl.getuser(), {}, null, null);
    BaseUserInfoModel model = BaseUserInfoModel.fromJson(response.data);
    callback(model);
  }

  static Future<ResultData> bindDeviceId(String deviceId,callback) async{
    BindDeviceIdRequestModel requestModel = BindDeviceIdRequestModel(deviceid:deviceId);
    String params = convert.jsonEncode(requestModel);
    var response = await httpManager.request(
        ServiceUrl.bindDeviceId(), params, null, Options(method:"post"));
    if(response.code != 200){
      CommonUtils.showErrorMessage(msg: "绑定极光设备出错");
      callback(false);
    }else{
      callback(true);
    }
  }


  static Future<ResultData> requestBackendProductCoin(callback) async{
    var response = await httpManager.request(
        ServiceUrl.requestBackendProductCoin(), {}, null, Options(method: "post"));
    ProductCoinModel model = ProductCoinModel.fromJson(response.data);
    callback(model);
  }

  static Future<ResultData> takeCoin(callback) async{
    var response = await httpManager.request(
        ServiceUrl.takeCoin(), {}, null, Options(method: "post"));
    TakeCoinModel model = TakeCoinModel.fromJson(response.data);
    callback(model);
  }

  static Future<ResultData> localLogout(callback) async{
    LocalStorage.remove(Config.TOKEN_KEY);
    await FileStorage.removeContent("token");
    await FileStorage.removeContent("verified");
    clearAll();
    callback(true);
  }

  ///清除所有信息
  static clearAll() async {
    httpManager.clearAuthorization();
  }
}