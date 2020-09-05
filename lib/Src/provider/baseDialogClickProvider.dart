import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upgradegame/Src/pages/userInfo/model/cashInfoModel.dart';

//混入
class BaseDialogClickProvider with ChangeNotifier {
  bool hasClickDialog;

  initBaseDialogClick(){
    hasClickDialog = false;
  }

  setDialogShow(){
    this.hasClickDialog = true;
  }

  setDialogHide(){
    this.hasClickDialog = false;
  }

}
