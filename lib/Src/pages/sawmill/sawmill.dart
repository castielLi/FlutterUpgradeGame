import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/widget/adIconRow/adIconRow.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';


class SawmillDetail extends StatefulWidget {

  @override
  _SawmillDetailState createState() => new _SawmillDetailState();
}

class _SawmillDetailState extends State<SawmillDetail> {
  // 获取数据
  static int level = 13;
  static int levelFrom = level-1;
  static int neededWood  = 2910;
  static int neededStone = 2910;
  static int woodPerAd = 100;
  static int watchedAd = 1;
  static int maxWatchableAd = 10;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {
    var textStyleA = TextStyle(fontSize: 32.0, color: Colors.white,
        decoration: TextDecoration.none);
    var textStyleB = TextStyle(fontSize: 30.0, color: Colors.white,
        decoration: TextDecoration.none);
    var textStyleC = TextStyle(fontSize: 23.0, color: Colors.white,
        decoration: TextDecoration.none);

    return new Container(
      child: new Container(
        margin: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(80),   // 左
            ScreenUtil().setHeight(350),  // 上
            ScreenUtil().setWidth(80),   // 右
            ScreenUtil().setHeight(100)), // 下
//        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              margin: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(20),   // 左
                  ScreenUtil().setHeight(0),  // 上
                  ScreenUtil().setWidth(0),   // 右
                  ScreenUtil().setHeight(0)), // 下
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('LV $levelFrom > LV $level',textAlign:TextAlign.left,style: textStyleA),
                  Text('升级所需资料',style: textStyleA),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Image(image: new AssetImage('resource/images/wood.png'), height:30),
                      Text('$neededWood ',style: textStyleB,),
                      new Image(image: new AssetImage('resource/images/stone.png'), height:30),
                      Text('$neededStone',style: textStyleB),
                    ],
                  ),
                  Text('观看广告获取升级资源',style:textStyleC),
                ],
              ),
            ),
            AdIconRow(countInOneRow: 5,adIconHeight: 50.0,imageUrl: 'resource/images/adIcon.png',),
            AdIconRow(countInOneRow: 5,adIconHeight: 50.0,imageUrl: 'resource/images/adIcon.png',),
            new Container(
              margin: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(20),   // 左
                  ScreenUtil().setHeight(0),  // 上
                  ScreenUtil().setWidth(0),   // 右
                  ScreenUtil().setHeight(0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('每次获取 ',style: textStyleC,),
                      new Image(image: new AssetImage('resource/images/wood.png'),height: 30,),
                      Text('$woodPerAd',style: textStyleC,),
                    ],
                  ),
                  Text('今日观看次数 $watchedAd/$maxWatchableAd',style:textStyleC),
                ],
              ),
            ),
            new ImageButton(height:ScreenUtil().setHeight(200),width: ScreenUtil().setWidth(400),buttonName: "升 级",imageUrl: "resource/images/upgradeButton.png",callback: (){
              print('点击升级');
            },),
          ],
        ),
      ),
    );
  }
}