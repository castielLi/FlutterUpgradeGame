import 'dart:async';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/fightRank/model/fightRankModel.dart';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class FightRankService {
  static Future<ResultData> getFightRank(callback) async {

    var response = await httpManager.request(ServiceUrl.getFightRankList(),
        {}, null, Options(method: "post"));
    if (ConfigSetting.SUCCESS == response.code) {
      FightRankModel model = FightRankModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(null);
    }
    return response;
  }

}
