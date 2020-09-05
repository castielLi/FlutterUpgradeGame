import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upgradegame/Src/common/model/enum/adTypeEnum.dart';
import 'package:upgradegame/Src/common/widget/adDialog/adTimer.dart';


//混入
class BaseAdTimerProvider with ChangeNotifier {
  bool farm;
  bool stone;
  bool sawmill;

  bool initFinished = false;

  String farmLastWatchTime;
  String stoneLastWatchTime;
  String sawmillListWatchTime;


  bool get Farm => farm;
  bool get Stone => stone;
  bool get Sawmill => sawmill;

  BaseAdTimerProvider() {
    this.farm = false;
    this.stone = false;
    this.sawmill = false;
  }

  initLastWatchTime() async{
    if(!initFinished) {
      List<dynamic> list = await AdTimer.GetAdTime();
      this.farmLastWatchTime = list[0]['farm'];
      this.stoneLastWatchTime = list[0]['stone'];
      this.sawmillListWatchTime = list[0]['wood'];

      if(this.farmLastWatchTime == "0"){
        this.farm = false;
      }else{
        int time = int.parse(this.farmLastWatchTime);
        int currentTIme = DateTime.now().millisecondsSinceEpoch;
        if(currentTIme  - time > 120000){
          this.farm = false;
        }else{
          this.farm = true;
          Timer timer = Timer.periodic(Duration(seconds: 2), (timer) {
            int time = int.parse(this.farmLastWatchTime);
            int currentTIme = DateTime.now().millisecondsSinceEpoch;
            if(currentTIme  - time > 120000){
              this.farm = false;
              notifyListeners();
              timer.cancel();
            }
          });
        }
      }

      if(this.sawmillListWatchTime == "0"){
        this.sawmill = false;
      }else {
        int time = int.parse(this.sawmillListWatchTime);
        int currentTIme = DateTime
            .now()
            .millisecondsSinceEpoch;
        if (currentTIme - time > 120000) {
          this.sawmill = false;
        } else {
          this.sawmill = true;
          Timer timer = Timer.periodic(Duration(seconds: 2), (timer) {
            int time = int.parse(this.farmLastWatchTime);
            int currentTIme = DateTime
                .now()
                .millisecondsSinceEpoch;
            if (currentTIme - time > 120000) {
              this.sawmill = false;
              notifyListeners();
              timer.cancel();
            }
          });
        }
      }

        if (this.stoneLastWatchTime == "0") {
          this.stone = false;
        } else {
          int time = int.parse(this.stoneLastWatchTime);
          int currentTIme = DateTime
              .now()
              .millisecondsSinceEpoch;
          if (currentTIme - time > 120000) {
            this.stone = false;
          } else {
            this.stone = true;
            Timer timer = Timer.periodic(Duration(seconds: 2), (timer) {
              int time = int.parse(this.farmLastWatchTime);
              int currentTIme = DateTime
                  .now()
                  .millisecondsSinceEpoch;
              if (currentTIme - time > 120000) {
                this.stone = false;
                notifyListeners();
                timer.cancel();
              }
            });
          }
        }

      this.initFinished = true;
    }
  }

  watchAd(AdTypeEnum type){
    int currentTIme = DateTime
        .now()
        .millisecondsSinceEpoch;
    if(type == AdTypeEnum.farm){
      farm = true;
      AdTimer.UpdateAdTime(AdTypeEnum.farm, currentTIme.toString());
    }else if(type == AdTypeEnum.sawmill){
      sawmill = true;
      AdTimer.UpdateAdTime(AdTypeEnum.sawmill, currentTIme.toString());
    }else{
      stone = true;
      AdTimer.UpdateAdTime(AdTypeEnum.stone, currentTIme.toString());
    }
    notifyListeners();
    this.setWatchAdWaitingByType(type);
  }

  setWatchAdWaitingByType(AdTypeEnum type){
      ///正式
    Timer timer = Timer.periodic(Duration(seconds: 120), (timer) {
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
