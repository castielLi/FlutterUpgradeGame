import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class TeamService {
  static Future<ResultData> getTeamList() async {
    var response =
    await httpManager.request(ServiceUrl.getTeamList(), {}, null, null);
    return response;
  }
}
