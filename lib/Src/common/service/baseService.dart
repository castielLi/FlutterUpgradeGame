import 'dart:async';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/storge/fileStore.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/baseResourceModel.dart';
import 'package:upgradegame/Src/common/model/baseRuleModel.dart';
import 'package:upgradegame/Src/common/model/extraRuleModel.dart';
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
      CommonUtils.showErrorMessage(msg: "网络异常,请求规则配置出错,请重新打开程序");
      callback(null);
    }
  }

  static Future<ResultData> getRule2(callback) async {
    var response = await httpManager.request(ServiceUrl.getRule(), {}, null, null);
    if (response.code == 200) {
      ExtraRuleModel model = ExtraRuleModel.fromJson(response.data);
      FileStorage.saveContent(convert.jsonEncode(model), "rule2");
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: "网络异常,请求系统配置出错,请重新打开程序");
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
      CommonUtils.showErrorMessage(msg: response.message);
      callback(null);
    }
  }
}
