import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class RaidersService {
  static Future<ResultData> getRaidersList() async {
    var response =
    await httpManager.request(ServiceUrl.getRaidersList(), {}, null, null);
    return response;
  }
}
