import 'dart:async';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/recycle/model/recycleSuppliesRequestModel.dart';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class StoreService {
  static Future<ResultData> recycleSupplies(String password, String amount ,callback) async {

    RecycleSuppliesRequestModel requestModel = RecycleSuppliesRequestModel(password: password,amount: amount);
    var param = convert.jsonEncode(requestModel);
    var response = await httpManager.request(ServiceUrl.recycleSupplies(), param, null, Options(method: "post"));
    if (ConfigSetting.SUCCESS == response.code) {
      callback(response.data);
    } else {
      CommonUtils.showErrorMessage(msg: response.message);
      callback(null);
    }
    return response;
  }

}
