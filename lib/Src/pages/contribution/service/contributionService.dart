import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Src/common/model/baseResourceModel.dart';
import 'package:upgradegame/Src/pages/contribution/model/myContributionModel.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/contribution/model/requestModel/buyContributionRequestModel.dart';
import 'dart:convert' as convert;

class ContributionService{
  static Future<ResultData> getContribution(callback) async{
    var response = await httpManager.request(
        ServiceUrl.getMyContribution(), {}, null, null);

    if(response.code == 200){
      MyContributionModel model = MyContributionModel.fromJson(response.data);
      callback(model);
    }else{
      CommonUtils.showErrorMessage(msg: '获取贡献值出错');
      callback(null);
    }
  }

  static Future<ResultData> buyContribution(int tcoinamount,callback) async{

    BuyContributionRequestModel requestModel = BuyContributionRequestModel(tcoinamount:tcoinamount);
    String params = convert.jsonEncode(requestModel);
    var response = await httpManager.request(
        ServiceUrl.buyContribution(), params, null, Options(method: "post"));
    if(response.code == 200){
      BaseResourceModel model = BaseResourceModel.fromJson(response.data);
      callback(model);
    }else{
      CommonUtils.showErrorMessage(msg: '购买贡献值出错');
      callback(null);
    }
  }
}