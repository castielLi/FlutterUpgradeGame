
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Src/pages/adDividend/model/AdDividendModel.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class AdDividendService{
  static Future<ResultData> getAdDividendList() async{

    var response = await httpManager.request(
        ServiceUrl.getAdDividendList(), {}, null, null);
    return response;
  }
}