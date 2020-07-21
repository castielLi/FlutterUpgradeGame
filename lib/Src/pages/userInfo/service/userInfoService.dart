import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/storge/fileStore.dart';
import 'package:upgradegame/Common/storge/localStore.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/userInfo/model/cashInfoModel.dart';
import 'dart:async';
import 'dart:convert' as convert;

import 'package:upgradegame/Src/pages/userInfo/model/requestModel/withdrawRequestModel.dart';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class UserInfoService{
  static Future<ResultData> logout(callback) async{

    var response = await httpManager.request(ServiceUrl.logout(), {}, null, Options(method: "post"));
    if(response.code==200){
      LocalStorage.remove(Config.TOKEN_KEY);
      await FileStorage.removeContent("token");
      await FileStorage.removeContent("verified");
      clearAll();
      callback(true);
    }else{
      CommonUtils.showErrorMessage(msg: "登出失败");
      callback(false);
    }
  }

  static Future<ResultData> withdraw(String aliaccount,String cashamount ,String password ,callback) async{
    WithdrawRequestModel requestModel = WithdrawRequestModel(aliaccount: aliaccount,cashamount: cashamount,password: password);
    String params = convert.jsonEncode(requestModel);
    var response = await httpManager.request(ServiceUrl.withdraw(), params, null, Options(method: "post"));
    if (response.code == 200) {
      callback(true);
    } else {
      CommonUtils.showErrorMessage(msg: "提现操作失败");
      callback(false);
    }
  }

  static Future<ResultData> getUserCashInfo(callback) async{
    var response = await httpManager.request(ServiceUrl.getUserCashInfo(), {}, null, null);
    if (response.code == 200) {
      CashInfoModel responseModel = CashInfoModel.fromJson(response.data);
      callback(responseModel);
    } else {
      CommonUtils.showErrorMessage(msg: "获取现金账户失败");
      callback(null);
    }
    callback();
  }

  ///清除所有信息
  static clearAll() async {
    httpManager.clearAuthorization();
  }
}