import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class RankService {
  static Future<ResultData> getRankList() async {
    var response =
        await httpManager.request(ServiceUrl.getRankList(), {}, null, null);
    return response;
  }
}
