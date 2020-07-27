import 'dart:async';

import 'package:upgradegame/Src/common/widget/resourceDialog/enum/resourceDialogEnum.dart';
import 'package:upgradegame/Src/common/widget/resourceDialog/model/resourceDialogModel.dart';


//混入
class BaseResourceChangeDialogDataModel{
  bool wood;
  bool stone;
  bool coin;
  bool contribution;

  List<ResourceDialogModel> source;



  factory BaseResourceChangeDialogDataModel() =>_getInstance();
  static BaseResourceChangeDialogDataModel get instance => _getInstance();
  static BaseResourceChangeDialogDataModel _instance;
  BaseResourceChangeDialogDataModel._internal() {
    // 初始化
    this.wood = false;
    this.stone = false;
    this.coin = false;
    this.contribution = false;
    this.source = null;
  }

  static BaseResourceChangeDialogDataModel _getInstance() {
    if (_instance == null) {
      _instance = new BaseResourceChangeDialogDataModel._internal();
    }
    return _instance;
  }

  static getSource(){
    return _instance.source;
  }

  static setDisplayed(){
    _instance.wood = false;
    _instance.stone = false;
    _instance.coin = false;
    _instance.contribution = false;
  }

  static setNeedDisplay(List<ResourceDialogModel> source) {
    _instance.source = source;
    for (int i = 0; i < source.length; i++) {
      switch (source[i].type) {
        case ResourceDialogEnum.wood:
          _instance.wood = true;
          break;
        case ResourceDialogEnum.stone:
          _instance.stone = true;
          break;
        case ResourceDialogEnum.coin:
          _instance.coin = true;
          break;
        case ResourceDialogEnum.contribution:
          _instance.contribution = true;
          break;
      }
    }
  }

}
