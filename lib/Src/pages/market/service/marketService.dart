import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/enum/marketTradeTypeEnum.dart';
import 'package:upgradegame/Src/common/model/user.dart';
import 'package:upgradegame/Src/pages/market/model/myTradeListModel.dart';
import 'package:upgradegame/Src/pages/market/model/requstModel/cancelTradeRequestModel.dart';
import 'package:upgradegame/Src/pages/market/model/requstModel/getTradeByTypeRequstModel.dart';
import 'package:upgradegame/Src/pages/market/model/sellResourceModel.dart';
import 'package:upgradegame/Src/pages/market/model/tradeListModel.dart';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'dart:convert' as convert;

class MarketService {
  static Future<ResultData> searchUser(phoneNo, callback) async {
    User user = new User(phone: phoneNo);
    String params = convert.jsonEncode(user);
    var response = await httpManager.request(ServiceUrl.searchUser(), params, null, Options(method: "post"));
    if (response.code == 200) {
      callback(response.data);
    } else {
      CommonUtils.showErrorMessage(msg: "搜索用户出错");
      callback(null);
    }
  }

  static Future<ResultData> getMyMarketTrade(callback) async {

    var response = await httpManager.request(ServiceUrl.getMyMarketTrade(), {}, null, null);
    if (response.code == 200) {
      MyTradeListModel model = MyTradeListModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: "请求我发布的订单出错");
      callback(null);
    }
  }


  static Future<ResultData> getMarketTradeByType(int page ,MarketTradeTypeEnum type,callback) async {

    GetTradeByTypeRequestModel requestModel = GetTradeByTypeRequestModel(page: page,type: type.index);
    String params = convert.jsonEncode(requestModel);

    var response = await httpManager.request(ServiceUrl.getTradeList(), params, null, Options(method: "post"));
    if (response.code == 200) {
      TradeListModel model = TradeListModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: "请求市场订单出错");
      callback(null);
    }
  }


  static Future<ResultData> cancelMyMarketTrade(String productId,MarketTradeTypeEnum type,callback) async {

    CancelTradeRequestModel requestModel = CancelTradeRequestModel(productid: productId,type: type.index);
    String params = convert.jsonEncode(requestModel);

    var response = await httpManager.request(ServiceUrl.getMyMarketTrade(), params, null, Options(method: "post"));
    if (response.code == 200) {
      callback(response.data);
    } else {
      CommonUtils.showErrorMessage(msg: "搜索用户出错");
      callback(null);
    }
  }


  static Future<ResultData> sellResource(type, amount, price, callback) async {
    SellResourceModel sellResourceModel = new SellResourceModel(type: type, amount: amount, price: price);
    String params = convert.jsonEncode(sellResourceModel);
    var response = await httpManager.request(ServiceUrl.sellResource(), params, null, Options(method: "post"));
    if (response.code == 200) {
      callback(response.code);
    } else {
      CommonUtils.showErrorMessage(msg: "发布订单出错");
      callback(null);
    }
  }

  static Future<ResultData> sendCoin(User user, callback) async {
    String params = convert.jsonEncode(user);
    var response = await httpManager.request(ServiceUrl.sendCoin(), params, null, Options(method: "post"));
    if (response.code == 200) {
      callback(response.code);
    } else {
      CommonUtils.showErrorMessage(msg: "赠送T币出错");
      callback(null);
    }
  }
}
