import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/storge/localStore.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';

class MainService{
  static Future<ResultData> getBaseInfo() async{

    ResultData response = await httpManager.request(
        ServiceUrl.getBaseInfo(), {}, null,null);

    print(response.data);

    return null;

  }
}