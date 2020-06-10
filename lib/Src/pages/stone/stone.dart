import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Src/common/model/baseRuleModel.dart';
import 'package:upgradegame/Src/common/widget/adIcon/adIconRow.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Src/common/model/baseRuleModel.dart';
import 'package:upgradegame/Src/common/model/globalDataModel.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';


class StoneDetail extends StatefulWidget {

  @override
  VoidCallback HUD;
  StoneDetail({Key key,this.HUD}):super(key:key);
  _StoneDetailState createState() => new _StoneDetailState();
}

class _StoneDetailState extends State<StoneDetail> {

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
          ///当前建筑规则
          Stone stoneBuildingRule =  Global.getStoneBuildingRule()[level - 1];
          AdSetting adSetting = Global.getAdSettingRule();
          int needTCoin  = stoneBuildingRule.tcoinamount;
          int woodPerAd = stoneBuildingRule.product;
          int watchedAd = baseUserInfo.ad.stone;
          int maxWatchableAd = adSetting.stone;

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
                      Text('LV $levelFrom > LV $level',textAlign:TextAlign.left,style: CustomFontSize.defaultTextStyle(75)),
                      Text('升级所需资料',style: CustomFontSize.defaultTextStyle(75)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Image(image: new AssetImage('resource/images/gold.png'), height:ScreenUtil().setHeight(100)),
                          Text('$needTCoin ',style: CustomFontSize.defaultTextStyle(75),),
                        ],
                      ),
                      Text('观看广告获取升级资源',style:CustomFontSize.defaultTextStyle(55)),
                    ],
                  ),
                ),
                AdIconRow(countInOneRow: maxWatchableAd,adIconHeight: ScreenUtil().setHeight(150),imageUrlWatched: 'resource/images/adWatched.png',
                imageUrlUnwatch: "resource/images/adUnwatch.png",alreadyWatched: watchedAd,),
                new Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(20),),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('每次获取 ',style: CustomFontSize.defaultTextStyle(55),),
                          new Image(image: new AssetImage('resource/images/stone.png'),height: ScreenUtil().setHeight(100),),
                          Text(' $woodPerAd',style: CustomFontSize.defaultTextStyle(55),),
                        ],
                      ),
                      Text('今日观看次数 $watchedAd/$maxWatchableAd',style:CustomFontSize.defaultTextStyle(55)),
                    ],
                  ),
                ),
                new ImageButton(height:ScreenUtil().setHeight(200),width: ScreenUtil().setWidth(400),buttonName: "升 级",imageUrl: "resource/images/upgradeButton.png",callback: (){
                  if(baseUserInfo.tcoinamount < stoneBuildingRule.tcoinamount){
                    CommonUtils.showErrorMessage(msg: "没有足够的资源升级");
                  }else{
                    this.widget.HUD();
                  }
                },),
              ],
            ),
          );
        }
      )
    );
  }
}