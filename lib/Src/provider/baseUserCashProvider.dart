import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upgradegame/Src/common/model/enum/adTypeEnum.dart';
import 'package:upgradegame/Src/pages/userInfo/model/cashInfoModel.dart';


//混入
class BaseUserCashProvider with ChangeNotifier {
  bool hasWithdraw;
  double cashAmount;

  bool get HasWithdraw => this.hasWithdraw;
  double get CashAmount => this.cashAmount;

  withdraw(){
    this.hasWithdraw = true;
  }

  initUserCashProvider(CashInfoModel model){
    this.hasWithdraw = model.withdrawing;
    this.cashAmount = double.parse(model.cashamount);
    notifyListeners();
  }
}
