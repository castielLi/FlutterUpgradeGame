import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/heroAltar/model/buyHeroModel.dart';
import 'package:upgradegame/Src/pages/heroAltar/model/requestModel/buyHeroRequestModel.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'dart:convert' as convert;

class HeroService {
  static Future<ResultData> buyHero(type, callback) async {
    BuyHeroRequestModel requestModel = BuyHeroRequestModel(type: type);
    String params = convert.jsonEncode(requestModel);

    var response = await httpManager.request(ServiceUrl.buyHero(), params, null, Options(method: "post"));
    if (response.code == 200) {
      BuyHeroModel model = BuyHeroModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: "购买英雄出错");
      callback(null);
    }
  }
}
