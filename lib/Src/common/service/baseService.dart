import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/storge/localStore.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'package:upgradegame/Src/common/model/baseRuleModel.dart';
import 'package:upgradegame/Common/storge/fileStore.dart';
import 'dart:convert' as convert;

class BaseService{
  static Future<ResultData> getRule(callback) async{

    var response = await httpManager.request(
        ServiceUrl.getRule(), {}, null, null);
    BaseRuleModel model = BaseRuleModel.fromJson(response.data);
    FileStorage.saveRule(convert.jsonEncode(model),"rule");
    callback(model);
  }
}