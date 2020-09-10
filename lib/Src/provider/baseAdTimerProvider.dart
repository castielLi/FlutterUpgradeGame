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
  Timer farmTimer;
  Timer woodTimer;
  Timer stoneTimer;

  Timer sqlFarmTimer;
  Timer sqlWoodTimer;
  Timer sqlStoneTime;


  bool get Farm => farm;
  bool get Stone => stone;
  bool get Sawmill => sawmill;

  BaseAdTimerProvider() {
    this.farm = false;
    this.stone = false;
    this.sawmill = false;
  }

  logout(){
    if(this.woodTimer != null){
      this.woodTimer.cancel();
    }
    if(this.farmTimer != null){
      this.farmTimer.cancel();
    }
    if(this.stoneTimer != null){
      this.stoneTimer.cancel();
    }
    if(this.sqlFarmTimer != null){
      this.sqlFarmTimer.cancel();
    }
    if(this.sqlStoneTime != null){
      this.sqlStoneTime.cancel();
    }
    if(this.sqlWoodTimer != null){
      this.sqlWoodTimer.cancel();
    }
    this.initFinished = false;
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
          sqlFarmTimer = Timer.periodic(Duration(seconds: 2), (timer) {
            int time = int.parse(this.farmLastWatchTime);
            int currentTIme = DateTime.now().millisecondsSinceEpoch;
            if(currentTIme  - time > 120000){
              this.farm = false;
              notifyListeners();
              sqlFarmTimer.cancel();
              sqlFarmTimer = null;
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
          sqlWoodTimer = Timer.periodic(Duration(seconds: 2), (timer) {
            int time = int.parse(this.sawmillListWatchTime);
            int currentTIme = DateTime
                .now()
                .millisecondsSinceEpoch;
            if (currentTIme - time > 120000) {
              this.sawmill = false;
              notifyListeners();
              sqlWoodTimer.cancel();
              sqlFarmTimer = null;
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
            sqlStoneTime = Timer.periodic(Duration(seconds: 2), (timer) {
              int time = int.parse(this.stoneLastWatchTime);
              int currentTIme = DateTime
                  .now()
                  .millisecondsSinceEpoch;
              if (currentTIme - time > 120000) {
                this.stone = false;
                notifyListeners();
                sqlStoneTime.cancel();
                sqlStoneTime = null;
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
      this.farmLastWatchTime = currentTIme.toString();
      AdTimer.UpdateAdTime(AdTypeEnum.farm, currentTIme.toString());
    }else if(type == AdTypeEnum.sawmill){
      this.sawmillListWatchTime = currentTIme.toString();
      sawmill = true;
      AdTimer.UpdateAdTime(AdTypeEnum.sawmill, currentTIme.toString());
    }else{
      this.stoneLastWatchTime = currentTIme.toString();
      stone = true;
      AdTimer.UpdateAdTime(AdTypeEnum.stone, currentTIme.toString());
    }
    notifyListeners();
    this.setWatchAdWaitingByType(type);
  }

  setWatchAdWaitingByType(AdTypeEnum type){
    if(type == AdTypeEnum.farm){
      farmTimer = Timer.periodic(Duration(seconds: 12), (timer) {
        int currentTIme = DateTime
            .now()
            .millisecondsSinceEpoch;
        if(currentTIme - int.parse(this.farmLastWatchTime) > 120000){
          farm = false;
          notifyListeners();
          farmTimer.cancel();
          farmTimer = null;
        }
      });
    }else if(type == AdTypeEnum.sawmill){
      woodTimer = Timer.periodic(Duration(seconds: 12), (timer) {
        int currentTIme = DateTime
            .now()
            .millisecondsSinceEpoch;
        if(currentTIme - int.parse(this.sawmillListWatchTime) > 120000) {
          sawmill = false;
          notifyListeners();
          woodTimer.cancel();
          woodTimer = null;
        }
      });
    }else{
      stoneTimer = Timer.periodic(Duration(seconds: 12), (timer) {
        int currentTIme = DateTime
            .now()
            .millisecondsSinceEpoch;
        if(currentTIme - int.parse(this.stoneLastWatchTime) > 120000) {
          stone = false;
          notifyListeners();
          stoneTimer.cancel();
          stoneTimer = null;
        }
      });
    }
  }
}
