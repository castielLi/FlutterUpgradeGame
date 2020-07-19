import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upgradegame/Src/common/model/enum/adTypeEnum.dart';


//混入
class BaseAdTimerProvider with ChangeNotifier {
  bool farm;
  bool stone;
  bool sawmill;

  bool get Farm => farm;
  bool get Stone => stone;
  bool get Sawmill => sawmill;

  BaseAdTimerProvider() {
    this.farm = false;
    this.stone = false;
    this.sawmill = false;
  }

  watchAd(AdTypeEnum type){
    if(type == AdTypeEnum.farm){
      farm = true;
    }else if(type == AdTypeEnum.sawmill){
      sawmill = true;
    }else{
      stone = true;
    }
    notifyListeners();
    this.setWatchAdWaitingByType(type);
  }

  setWatchAdWaitingByType(AdTypeEnum type){
    Timer timer = Timer.periodic(Duration(seconds: 10), (timer) {
      if(type == AdTypeEnum.farm){
        farm = false;
      }else if(type == AdTypeEnum.sawmill){
        sawmill = false;
      }else{
        stone = false;
      }
      notifyListeners();
      timer.cancel();
    });
  }
}
