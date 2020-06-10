import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/store/model/storeModel.dart';
import 'package:upgradegame/Src/pages/store/storeService/storeService.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Src/pages/store/productItem.dart';
import 'dart:async';

class StoreDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  StoreDetail({Key key,this.HUD}):super(key:key);
  _StoreDetailState createState() => new _StoreDetailState();
}

class _StoreDetailState extends State<StoreDetail> {

  List<StoreModel> storeList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      this.widget.HUD();
      StoreService.getStoreList().then((data
          ){
        if(data.code == ConfigSetting.SUCCESS && data.data != null){
          setState(() {
            storeList = StoreListModel.fromJson(data.data).datalist;
          });
        }else{
          CommonUtils.showErrorMessage(msg: "网络请求失败，请重试");
        }
      this.widget.HUD();
      });
    });
  }



  @override
  Widget build(BuildContext context) {

    return new Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(80),   // 左
          ScreenUtil().setHeight(280),  // 上
          ScreenUtil().setWidth(80),   // 右
          ScreenUtil().setHeight(100)), // 下
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new ProductItem(
              volumeAmount: storeList == null?"":storeList[0].amount.toString(),
              callback: (){

              },
              cashAmount: storeList == null?"":storeList[0].price.toString(),
            ),
            new ProductItem(
              volumeAmount: "108",
              callback: (){

              },
              cashAmount: "50",
            ),
            new ProductItem(
              volumeAmount: "158",
              callback: (){

              },
              cashAmount: "70",
            ),
            new ProductItem(
              volumeAmount: "258",
              callback: (){

              },
              cashAmount: "100",
            )
          ],
        ),
      ),
    );
  }
}