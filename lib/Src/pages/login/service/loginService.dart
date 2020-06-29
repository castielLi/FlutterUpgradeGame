import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/storge/fileStore.dart';
import 'package:upgradegame/Common/storge/localStore.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Src/pages/login/model/LoginResponseModel.dart';
import 'package:upgradegame/Src/pages/login/requstModel/login.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/baseUserInfoModel.dart';
import 'dart:convert' as convert;

class LoginService{
  static Future<ResultData> login(String wechat,callback) async{

    Login requstModel = Login(wechat: wechat);
    String params = convert.jsonEncode(requstModel);

    var response = await httpManager.request(
        ServiceUrl.login(), params, null, Options(method: "post"));

    if(response.code == 200){
      LoginReponseModel responseModel = LoginReponseModel.fromJson(response.data);
      LocalStorage.save(Config.TOKEN_KEY, responseModel.token);
      FileStorage.saveContent(responseModel.token, "token");
      callback(responseModel.userinfo);
    }else{
      CommonUtils.showErrorMessage(msg: '登录出错');
      callback(null);
    }
  }

  static Future<ResultData> loginWithToken(callback) async{

    var response = await httpManager.request(
        ServiceUrl.getuser(), {}, null, null);

    if(response.code != 200){
      clearAll();
      FileStorage.saveContent("", "token");
      callback(null);
    }else{
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
}