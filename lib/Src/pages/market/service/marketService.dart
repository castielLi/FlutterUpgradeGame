import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/user.dart';
import 'package:upgradegame/Src/pages/market/model/myTradeListModel.dart';
import 'package:upgradegame/Src/pages/market/model/requstModel/cancelTradeRequestModel.dart';
import 'package:upgradegame/Src/pages/market/model/requstModel/getTradeByTypeRequstModel.dart';
import 'package:upgradegame/Src/pages/market/model/requstModel/marketBuyRequestModel.dart';
import 'package:upgradegame/Src/pages/market/model/requstModel/sendCoinRequestModel.dart';
import 'package:upgradegame/Src/pages/market/model/sellResourceModel.dart';
import 'package:upgradegame/Src/pages/market/model/tradeListModel.dart';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class MarketService {
  static Future<ResultData> searchUser(phoneNo, callback) async {
    User user = new User(phone: phoneNo);
    String params = convert.jsonEncode(user);
    var response = await httpManager.request(ServiceUrl.searchUser(), params, null, Options(method: "post"));
    if (response.code == 200) {
      callback(response.data);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(null);
    }
  }

  static Future<ResultData> getMyMarketTrade(callback) async {
    var response = await httpManager.request(ServiceUrl.getMyMarketTrade(), {}, null, null);
    if (response.code == 200) {
      MyTradeListModel model = MyTradeListModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(null);
    }
  }

  static Future<ResultData> marketBuy(String productId, callback) async {
    MarketBuyRequestModel requestModel = MarketBuyRequestModel(productid: productId);
    String params = convert.jsonEncode(requestModel);

    var response = await httpManager.request(ServiceUrl.marketBuy(), params, null, Options(method: "post"));
    if (response.code == 200) {
      callback(true);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(false);
    }
  }

  static Future<ResultData> getMarketTradeByType(int page, int type, callback) async {
    GetTradeByTypeRequestModel requestModel = GetTradeByTypeRequestModel(page: page, type: type);
    String params = convert.jsonEncode(requestModel);

    var response = await httpManager.request(ServiceUrl.getTradeList(), params, null, Options(method: "post"));
    if (response.code == 200) {
      TradeListModel model = TradeListModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(null);
    }
  }

  static Future<ResultData> cancelMyMarketTrade(String productId, int type, callback) async {
    ///wood = 1 stone = 2
    CancelTradeRequestModel requestModel = CancelTradeRequestModel(productid: productId, type: type);
    String params = convert.jsonEncode(requestModel);
    var response = await httpManager.request(ServiceUrl.cancelMyMarketTrade(), params, null, Options(method: "post"));
    if (response.code == 200) {
      callback(true);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(false);
    }
  }

  static Future<ResultData> sellResource(type, amount, price, callback) async {
    ///wood = 1 stone = 2
    SellResourceModel sellResourceModel = new SellResourceModel(type: type == "wood" ? 1 : 2, amount: amount, price: price);
    String params = convert.jsonEncode(sellResourceModel);
    var response = await httpManager.request(ServiceUrl.sellResource(), params, null, Options(method: "post"));
    if (response.code == 200) {
      callback(true);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(false);
    }
  }

  static Future<ResultData> sendCoin(String userId, int amount, String password, callback) async {
    SendCoinRequestModel requestModel = SendCoinRequestModel(userid: userId, amount: amount, password: password);
    String params = convert.jsonEncode(requestModel);
    var response = await httpManager.request(ServiceUrl.sendCoin(), params, null, Options(method: "post"));
    if (response.code == 200) {
      callback(true);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(false);
    }
  }
}
