
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:dio/dio.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Src/pages/store/model/storeModel.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';

class StoreService{
  static Future<StoreListModel> getStoreList() async{

    var response = await httpManager.request(
        ServiceUrl.getStoreList(), {}, null, null);
    return StoreListModel.fromJson(response.data);
  }
}