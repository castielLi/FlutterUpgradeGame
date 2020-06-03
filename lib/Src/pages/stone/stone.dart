import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Src/pages/sawmill/adIconRow.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:provide/provide.dart';


class StoneDetail extends StatefulWidget {

  @override
  VoidCallback HUD;
  StoneDetail({Key key,this.HUD}):super(key:key);
  _StoneDetailState createState() => new _StoneDetailState();
}

class _StoneDetailState extends State<StoneDetail> {


  static int neededWood  = 2910;
  static int woodPerAd = 100;
  static int watchedAd = 1;
  static int maxWatchableAd = 5;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {

    return new Container(

      child:Provide<BaseUserInfoProvider>(
        builder: (context, child, baseUserInfo) {
          int levelFrom = baseUserInfo.Stonelevel;
          int level = baseUserInfo.Stonelevel + 1;
          return new Container(
            margin: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(80),   // 左
                ScreenUtil().setHeight(350),  // 上
                ScreenUtil().setWidth(80),   // 右
                ScreenUtil().setHeight(100)), // 下
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(left:ScreenUtil().setWidth(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('LV $levelFrom > LV $level',textAlign:TextAlign.left,style: CustomFontSize.textStyle30),
                      Text('升级所需资料',style: CustomFontSize.textStyle30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Image(image: new AssetImage('resource/images/gold.png'), height:ScreenUtil().setHeight(100)),
                          Text('$neededWood ',style: CustomFontSize.textStyle30,),
                        ],
                      ),
                      Text('观看广告获取升级资源',style:CustomFontSize.textStyle22),
                    ],
                  ),
                ),
                AdIconRow(countInOneRow: maxWatchableAd,adIconHeight: ScreenUtil().setHeight(150),imageUrl: 'resource/images/adIcon.png',),
                new Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(20),),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('每次获取 ',style: CustomFontSize.textStyle22,),
                          new Image(image: new AssetImage('resource/images/stone.png'),height: ScreenUtil().setHeight(100),),
                          Text('$woodPerAd',style: CustomFontSize.textStyle22,),
                        ],
                      ),
                      Text('今日观看次数 $watchedAd/$maxWatchableAd',style:CustomFontSize.textStyle22),
                    ],
                  ),
                ),
                new ImageButton(height:ScreenUtil().setHeight(200),width: ScreenUtil().setWidth(400),buttonName: "升 级",imageUrl: "resource/images/upgradeButton.png",callback: (){
                  print('点击升级');
                },),
              ],
            ),
          );
        }
      )
    );
  }
}