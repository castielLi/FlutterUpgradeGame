import 'dart:async';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/store/model/buyVoucherWeChatResponseModel.dart';
import 'package:upgradegame/Src/pages/store/model/requestModel/buyVoucherRequestModel.dart';
import 'package:upgradegame/Src/pages/store/model/requestModel/weChatConfirmOrderRequestModel.dart';
import 'package:upgradegame/Src/pages/store/model/voucherModel.dart';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class StoreService {
  static Future<ResultData> getStoreList(callback) async {
    var response = await httpManager.request(ServiceUrl.getStoreList(), {}, null, null);
    if (ConfigSetting.SUCCESS == response.code) {
      callback(response.data);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(null);
    }
    return response;
  }

  static Future<ResultData> buyVoucher(String productId, callback) async {
    BuyVoucherRequestModel requestModel = BuyVoucherRequestModel(productid: productId);
    String params = convert.jsonEncode(requestModel);

    var response = await httpManager.request(ServiceUrl.buyVocher(), params, null, Options(method: "post"));

    if (response.code == 200) {
      BuyVoucherWeChatResponseModel model = BuyVoucherWeChatResponseModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(null);
    }
  }

  static Future<ResultData> ConfirmOrder(String orderId, callback) async {
    WeChatConfirmOrderRequestModel requestModel = WeChatConfirmOrderRequestModel(orderid: orderId);
    String params = convert.jsonEncode(requestModel);

    var response = await httpManager.request(ServiceUrl.confirmOrder(), params, null, Options(method: "post"));

    if (response.code == 200) {
      VoucherModel model = VoucherModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: response.message + "!!请联系管理员!!");
      callback(null);
    }
  }
}
