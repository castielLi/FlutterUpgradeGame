import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class AboutUsService {
  static Future<ResultData> getAboutUs() async {
    var response = await httpManager.request(
        ServiceUrl.getAboutUs(), {}, null, null);
    return response;
  }
}
