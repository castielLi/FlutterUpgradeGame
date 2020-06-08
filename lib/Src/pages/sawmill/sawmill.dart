import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Src/common/model/baseRuleModel.dart';
import 'package:upgradegame/Src/common/widget/adIcon/adIconRow.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Src/common/model/globalDataModel.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';

class SawmillDetail extends StatefulWidget {

  @override
  VoidCallback HUD;
  SawmillDetail({Key key,this.HUD}):super(key:key);
  _SawmillDetailState createState() => new _SawmillDetailState();
}

class _SawmillDetailState extends State<SawmillDetail> {
  // 获取数据



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {

    return new Container(
      child:
        Provide<BaseUserInfoProvider>(
        builder: (context, child, baseUserInfo) {
          int levelFrom = baseUserInfo.Woodlevel;
          int level = baseUserInfo.Woodlevel + 1;
          Wood woodBuildingRule =  Global.getWoodBuildingRule()[level - 1];
          AdSetting adSetting = Global.getAdSettingRule();
          int needTCoin = woodBuildingRule.tcoinamount;
          int woodPerAd = woodBuildingRule.product;
          int watchedAd = baseUserInfo.ad.wood;
          int maxWatchableAd = adSetting.farm;

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
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(20),),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('LV $levelFrom > LV $level',textAlign:TextAlign.left,style: CustomFontSize.textStyle30),
                      Text('升级所需资料',style: CustomFontSize.textStyle30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Image(image: new AssetImage('resource/images/gold.png'), height:ScreenUtil().setHeight(100)),
                          Text('$needTCoin ',style: CustomFontSize.textStyle30,),
                        ],
                      ),
                      Text('观看广告获取升级资源',style:CustomFontSize.textStyle22),
                    ],
                  ),
                ),
                AdIconRow(countInOneRow: maxWatchableAd,adIconHeight: ScreenUtil().setHeight(150),imageUrlWatched: 'resource/images/adWatched.png',
                imageUrlUnwatch: "resource/images/adUnwatch.png",alreadyWatched: watchedAd,),
                new Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(20),),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('每次获取 ',style: CustomFontSize.textStyle22,),
                          Image(image: new AssetImage('resource/images/wood.png'),height: ScreenUtil().setHeight(100),),
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
        })
    );
  }
}