import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:dio/dio.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/store/model/requestModel/buyVoucherRequestModel.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'package:upgradegame/Src/pages/store/model/voucherModel.dart';
import 'dart:convert' as convert;

class StoreService {
  static Future<ResultData> getStoreList(callback) async {
    var response = await httpManager.request(ServiceUrl.getStoreList(), {}, null, null);
    if(ConfigSetting.SUCCESS == response.code){
      callback(response.data);
    }else{
      CommonUtils.showErrorMessage(msg: '网络请求失败，请重试');
      callback(null);
    }
    return response;
  }


  static Future<ResultData> buyVoucher(String productId,callback) async{

    BuyVoucherRequestModel requestModel = BuyVoucherRequestModel(productid: productId);
    String params = convert.jsonEncode(requestModel);

    var response = await httpManager.request(
        ServiceUrl.buyVocher(), params, null, Options(method: "post"));

    if(response.code == 200){
      VoucherModel model = VoucherModel.fromJson(response.data);
      callback(model);
    }else{
      CommonUtils.showErrorMessage(msg: "购买出错");
      callback(null);
    }
  }
}
