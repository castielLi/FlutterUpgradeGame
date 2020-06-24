import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class ProtocolService {
  static Future<ResultData> getProtocolList() async {
    var response = await httpManager.request(
        ServiceUrl.getProtocol(), {}, null, null);
    return response;
  }
}
