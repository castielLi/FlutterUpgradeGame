import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/user.dart';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'dart:convert' as convert;

class MarketService {
  static Future<ResultData> searchUser(phoneNo, callback) async {
    User user = new User(phone: phoneNo);
    String params = convert.jsonEncode(user);
    var response = await httpManager.request(ServiceUrl.searchUser(), params, null, Options(method: "post"));
    if (response.code == 200) {
      callback(response.data);
    } else {
      CommonUtils.showErrorMessage(msg: "搜索用户出错");
      callback(null);
    }
    return response;
  }
}
