import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Src/common/model/baseRuleModel.dart';
import 'package:upgradegame/Src/common/model/enum/adTypeEnum.dart';
import 'package:upgradegame/Src/common/model/enum/buildingEnum.dart';
import 'package:upgradegame/Src/common/service/baseService.dart';
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

  SawmillDetail({Key key, this.HUD}) : super(key: key);

  _SawmillDetailState createState() => new _SawmillDetailState();
}

class _SawmillDetailState extends State<SawmillDetail> {
  @override
  Widget build(BuildContext context) {
    return new Container(child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
      int level = 0;
      int nextLevel = 0;
      Wood woodBuildingRule;
      Wood currentWoodBuildingRule;
      Adsetting adSetting;
      int needTCoin = 0;
      int woodPerAd = 0;
      int watchedAd = 0;
      int maxWatchableAd = 0;
      int needFarmLevel = 0;
      int farmLevel = baseUserInfo.Farmlevel;
      int tCoinAmount = baseUserInfo.TCoinAmount;
      if (null != baseUserInfo) {
        level = baseUserInfo.Woodlevel;
        nextLevel = baseUserInfo.Woodlevel + 1;
        woodBuildingRule = null == Global.getWoodBuildingRule() ? null : Global.getWoodBuildingRule()[nextLevel - 1];
        currentWoodBuildingRule = null == Global.getWoodBuildingRule() ? null : Global.getWoodBuildingRule()[level - 1];
        adSetting = Global.getAdSettingRule();
        if (null != woodBuildingRule) {
          needTCoin = woodBuildingRule.tcoinamount;
          woodPerAd = currentWoodBuildingRule.product;
          needFarmLevel = woodBuildingRule.farmlevel;
        }
        watchedAd = null == baseUserInfo.ad ? 0 : baseUserInfo.ad.wood;
        maxWatchableAd = null == adSetting ? 5 : adSetting.wood;
      }

      return new Container(
        margin: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(80), // 左
            ScreenUtil().setHeight(350), // 上
            ScreenUtil().setWidth(80), // 右
            ScreenUtil().setHeight(100)), // 下
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('LV $level > LV $nextLevel', textAlign: TextAlign.left, style: CustomFontSize.defaultTextStyle(SystemFontSize.mainBuildingTextFontSize)),
                  Text('升级条件', style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Image(image: new AssetImage('resource/images/coin.png'), height: ScreenUtil().setHeight(SystemIconSize.adIconSize)),
                      Text(
                        '$needTCoin ',
                        style: TextStyle(fontSize:SystemFontSize.buildingConditionTextFontSize,color: tCoinAmount>=needTCoin?Colors.lightGreenAccent:Colors.grey),
                      ),
                      Image(image: new AssetImage('resource/images/farmBuilding.png'), height: ScreenUtil().setHeight(SystemIconSize.adIconSize)),
                      Text(
                        'lv' + '$needFarmLevel ',
                        style: TextStyle(fontSize:SystemFontSize.buildingConditionTextFontSize,color: farmLevel>=needFarmLevel?Colors.lightGreenAccent:Colors.grey),
                      ),
                    ],
                  ),
                  Text('观看广告获取升级资源',
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize)),
                ],
              ),
            ),
            AdIconRow(
              countInOneRow: maxWatchableAd,
              adIconHeight: ScreenUtil().setHeight(SystemIconSize.adIconSize),
              imageUrlWatched: 'resource/images/adWatched.png',
              imageUrlUnwatch: "resource/images/adUnwatch.png",
              imageUrlWaiting: "resource/images/adWaiting.png",
              HUD: this.widget.HUD,
              type: AdTypeEnum.sawmill,
              alreadyWatched: watchedAd,
            ),
            new Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '每次获取 ',
                        style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize),
                      ),
                      Image(
                        image: new AssetImage('resource/images/wood.png'),
                        height: ScreenUtil().setHeight(SystemIconSize.adIconSize),
                      ),
                      Text(
                        '$woodPerAd',
                        style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize),
                      ),
                    ],
                  ),
                  Text('今日观看次数 $watchedAd/$maxWatchableAd', style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize)),
                ],
              ),
            ),
            new ImageButton(
              height: ScreenUtil().setHeight(SystemButtonSize.largeButtonHeight),
              width: ScreenUtil().setWidth(SystemButtonSize.largeButtonWidth),
              buttonName: "升 级",
              imageUrl: "resource/images/upgradeButton.png",
              callback: () {
                if (baseUserInfo.tcoinamount < woodBuildingRule.tcoinamount || baseUserInfo.farmlevel < woodBuildingRule.farmlevel) {
                  CommonUtils.showErrorMessage(msg: "未达到升级条件");
                } else {
                  this.widget.HUD();
                  BaseService.upgradeBuilding(BuildingEnum.sawmill.index, (model) {
                    this.widget.HUD();
                    if (model != null) {
                      Provide.value<BaseUserInfoProvider>(context).upgradeBuilding(model);
                    }
                  });
                }
              },
            ),
          ],
        ),
      );
    }));
  }
}
