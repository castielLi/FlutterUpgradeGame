import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/team/model/qrCodeModel.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class TeamService {
  static Future<ResultData> getTeamList(callback) async {
    var response = await httpManager.request(ServiceUrl.getTeamList(), {}, null, null);
    if (ConfigSetting.SUCCESS == response.code) {
      callback(response.data);
    } else {
      CommonUtils.showErrorMessage(msg: '网络请求失败，请重试');
      callback(null);
    }
    return response;
  }

  static Future<ResultData> getQRCode(callback) async {
    var response = await httpManager.request(ServiceUrl.getQRCode(), {}, null, null);
    if (ConfigSetting.SUCCESS == response.code) {
      QRCodeModel model = QRCodeModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: '网络请求失败，请重试');
      callback(null);
    }
    return response;
  }
}
