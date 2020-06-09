import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


enum MainBuildingStatus{
  Normal,
  Coin,
  Waiting
}

class BasePageLogicProvider with ChangeNotifier{
  MainBuildingStatus status;

  MainBuildingStatus get Status =>status;

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
    if(timeMinute <= 20){
      return true;
    }
    return false;
  }



}