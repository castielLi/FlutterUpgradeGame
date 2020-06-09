
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Src/pages/store/model/storeModel.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class StoreService{
  static Future<ResultData> getStoreList(callback) async{

    var response = await httpManager.request(
        ServiceUrl.login(), {}, null, null);
    List list = response.data["data"].map((v) => v.toJson()).toList();
    List<StoreModel> storeList;
    for(int i = 0;i<list.length;i++){
      storeList.add(StoreModel.fromJson(list[i]));
    }

    callback(storeList);
  }
}