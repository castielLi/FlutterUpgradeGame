import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'package:upgradegame/Src/pages/store/model/voucherModel.dart';

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

  static Future<ResultData> buyVoucher(callback) async {
    var response = await httpManager.request(ServiceUrl.buyVocher(), {}, null, null);
    VoucherModel model = VoucherModel.fromJson(response.data);
    callback(model);
  }
}
