import 'dart:async';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/storge/fileStore.dart';
import 'package:upgradegame/Common/storge/localStore.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/baseUserInfoModel.dart';
import 'package:upgradegame/Src/pages/login/model/LoginResponseModel.dart';
import 'package:upgradegame/Src/pages/login/requstModel/login.dart';
import 'package:upgradegame/Src/pages/login/requstModel/loginWithAccountRequestModel.dart';
import 'package:upgradegame/Src/pages/login/requstModel/setUserInfoRequestModel.dart';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class LoginService {
  static Future<ResultData> login(String wechat,String deviceid, callback) async {
    Login requstModel = Login(code: wechat,deviceid: deviceid);
    String params = convert.jsonEncode(requstModel);

    var response = await httpManager.request(ServiceUrl.login(), params, null, Options(method: "post"));

    if (response.code == 200) {
      LoginReponseModel responseModel = LoginReponseModel.fromJson(response.data);
      LocalStorage.save(Config.TOKEN_KEY, responseModel.token);
      FileStorage.saveContent(responseModel.token, "token");
      FileStorage.saveContent(responseModel.verified.toString(), "verified");
      callback(responseModel);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(null);
    }
  }

  static Future<ResultData> setUserInfo(String realName, String idCard, String phone, String account, String password, callback) async {
    SetUserInfoRequestModel requestModel = SetUserInfoRequestModel(password: password, realname: realName, idcard: idCard, telephone: phone, account: account);
    String params = convert.jsonEncode(requestModel);

    var response = await httpManager.request(ServiceUrl.setuserinfo(), params, null, Options(method: "post"));

    if (response.code != 200) {
      callback(false);
      CommonUtils.showErrorMessage(msg: response.message);
    } else {
      FileStorage.saveContent("true", "verified");
      callback(true);
    }
  }

  static Future<ResultData> loginWithAccount(String account, String password, String deviceid,callback) async {
    LoginWithAccountRequestModel requestModel = LoginWithAccountRequestModel(account: account, password: password,deviceid: deviceid);
    String params = convert.jsonEncode(requestModel);

    var response = await httpManager.request(ServiceUrl.loginwithaccount(), params, null, Options(method: "post"));

    if (response.code == 200) {
      LoginReponseModel responseModel = LoginReponseModel.fromJson(response.data);
      LocalStorage.save(Config.TOKEN_KEY, responseModel.token);
      FileStorage.saveContent(responseModel.token, "token");
      FileStorage.saveContent("true", "verified");
      callback(responseModel);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(null);
    }
  }

  static Future<ResultData> loginWithToken(callback) async {
    var response = await httpManager.request(ServiceUrl.getuser(), {}, null, null);

    if (response.code != 200) {
      LocalStorage.remove(Config.TOKEN_KEY);
      await FileStorage.removeContent("token");
      await FileStorage.removeContent("verified");
      clearAll();
      callback(null);
    } else {
      BaseUserInfoModel model = BaseUserInfoModel.fromJson(response.data);
      callback(model);
    }
  }

  ///清除所有信息
  static clearAll() async {
    httpManager.clearAuthorization();
  }

  //用于判断用户是否登录
  static Future<String> getToken() async {
    var token = await FileStorage.getContent("token");
    if (token != null && token != "") {
      return token;
    }
    return null;
  }

  //用于判断用户是否实名认证
  static Future<bool> getVerified() async {
    var verified = await FileStorage.getContent("verified");
    if (verified != null && verified != "") {
      if (verified == "true") {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
