import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/storge/localStore.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Src/common/model/baseUserInfoModel.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';

class MainService{
  static Future<ResultData> getBaseInfo(callback) async{
    var response = await httpManager.request(
        ServiceUrl.login(), {}, null, null);
    BaseUserInfoModel model = BaseUserInfoModel.fromJson(response.data);
    callback(model);
  }
}