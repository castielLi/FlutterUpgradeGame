import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class PrivacyService {
  static Future<ResultData> getPrivacy() async {
    var response = await httpManager.request(
        ServiceUrl.getPrivacyPolicy(), {}, null, null);
    return response;
  }
}
