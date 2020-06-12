import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upgradegame/Src/common/model/globalDataModel.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:upgradegame/Src/common/model/baseRuleModel.dart';
import 'package:upgradegame/main.dart';


enum MainBuildingStatus{
  Normal,
  Coin,
  Waiting
}

class BasePageLogicProvider with ChangeNotifier{

  MainBuildingStatus status;

  MainBuildingStatus get Status =>status;

  BasePageLogicProvider(){
    this.status =  MainBuildingStatus.Normal;
  }

  void changeStatusToCoin(){
    status = MainBuildingStatus.Coin;
  }

  void changeStatusToWaiting(){
    status = MainBuildingStatus.Waiting;
  }

  void changeStatusToNormal(){
    status = MainBuildingStatus.Normal;
  }

  bool judgeIfDisplayMainBuildingWaiting(){
    int timeMinute = DateTime.now().minute;
    if(timeMinute <= 50){
      return true;
    }
    return false;
  }



}