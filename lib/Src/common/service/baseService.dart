import 'dart:async';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/storge/fileStore.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/baseResourceModel.dart';
import 'package:upgradegame/Src/common/model/baseRuleModel.dart';
import 'package:upgradegame/Src/common/model/requstModel/upgradeBuildingRequestModel.dart';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class BaseService {
  static Future<ResultData> getRule(callback) async {
    var response = await httpManager.request(ServiceUrl.getRule(), {}, null, null);
    if (response.code == 200) {
      BaseRuleModel model = BaseRuleModel.fromJson(response.data);
      FileStorage.saveContent(convert.jsonEncode(model), "rule");
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: "请求规则出错");
      callback(null);
    }
  }

  static Future<ResultData> upgradeBuilding(int type, callback) async {
    UpgradeBuildingRequestModel requestModel = UpgradeBuildingRequestModel(type: type);
    String params = convert.jsonEncode(requestModel);

    var response = await httpManager.request(ServiceUrl.upgradeBuilding(), params, null, Options(method: "post"));
    if (response.code == 200) {
      BaseResourceModel model = BaseResourceModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: "升级操作出错");
      callback(null);
    }
  }
}
