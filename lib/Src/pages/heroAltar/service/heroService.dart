import 'dart:async';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/heroAltar/model/buyHeroModel.dart';
import 'package:upgradegame/Src/pages/heroAltar/model/heroBaseInfoListModel.dart';
import 'package:upgradegame/Src/pages/heroAltar/model/heroListModel.dart';
import 'package:upgradegame/Src/pages/heroAltar/model/requestModel/buyHeroRequestModel.dart';
import 'package:upgradegame/Src/pages/heroAltar/model/requestModel/dividendHeroRequestModel.dart';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class HeroService {
  static Future<ResultData> buyHero(type, callback) async {
    BuyHeroRequestModel requestModel = BuyHeroRequestModel(type: type);
    String params = convert.jsonEncode(requestModel);

    var response = await httpManager.request(ServiceUrl.buyHero(), params, null, Options(method: "post"));
    if (response.code == 200) {
      CommonUtils.showSuccessMessage(msg: "购买英雄成功");
      BuyHeroModel model = BuyHeroModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(null);
    }
  }

  static Future<ResultData> dividendHero(type, callback) async {
    DividendHeroRequestModel requestModel = DividendHeroRequestModel(type: type);
    String params = convert.jsonEncode(requestModel);

    var response = await httpManager.request(ServiceUrl.dividendHero(), params, null, Options(method: "post"));
    if (response.code == 200) {
      CommonUtils.showSuccessMessage(msg: "获取分红成功,请在现金账户中查看,有疑问请咨询管理");
      BuyHeroModel model = BuyHeroModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(null);
    }
  }

  static Future<ResultData> getHeroList(callback) async {
    var response = await httpManager.request(ServiceUrl.getHeroList(), {}, null, null);
    if (response.code == 200) {
      HeroListModel model = HeroListModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(null);
    }
  }
}
