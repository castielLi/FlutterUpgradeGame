
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class AnnouncementService{
  static Future<ResultData> getAnnouncementList() async{

    var response = await httpManager.request(
        ServiceUrl.getAnnouncementList(), {}, null, null);
    return response;
  }
}