import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/storge/fileStore.dart';
import 'package:upgradegame/Common/storge/localStore.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'dart:async';
import 'dart:convert' as convert;

class UserInfoService{
  static Future<ResultData> logout(callback) async{

    LocalStorage.remove(Config.TOKEN_KEY);
    await FileStorage.removeContent("token");
    await FileStorage.removeContent("verified");
    callback();
  }
}