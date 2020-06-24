import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'package:upgradegame/Src/pages/store/model/voucherModel.dart';

class StoreService{
  static Future<ResultData> getStoreList() async{

    var response = await httpManager.request(
        ServiceUrl.getStoreList(), {}, null, null);
    return response;
  }


  static Future<ResultData> buyVoucher(callback) async{

    var response = await httpManager.request(
        ServiceUrl.buyVocher(), {}, null, null);
    VoucherModel model = VoucherModel.fromJson(response.data);
    callback(model);
  }
}