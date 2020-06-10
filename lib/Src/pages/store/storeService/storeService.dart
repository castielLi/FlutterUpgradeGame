import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class StoreService{
  static Future<ResultData> getStoreList() async{

    var response = await httpManager.request(
        ServiceUrl.getStoreList(), {}, null, null);
    return response;
  }
}