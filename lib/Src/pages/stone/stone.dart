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

class StoneDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  StoneDetail({Key key, this.HUD}) : super(key: key);

  _StoneDetailState createState() => new _StoneDetailState();
}

class _StoneDetailState extends State<StoneDetail> {
  @override
  Widget build(BuildContext context) {
    return new Container(child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
      int level = 0;
      int nextLevel = 0;
      Stone stoneBuildingRule;
      Stone currentStoneBuildingRule;
      Adsetting adSetting;
      int needTCoin = 0;
      int woodPerAd = 0;
      int watchedAd = 0;
      int maxWatchableAd = 0;
      int needFarmLevel = 0;
      int tCoinAmount = baseUserInfo.TCoinAmount;
      int farmLevel = baseUserInfo.Farmlevel;
      if (null != baseUserInfo) {
        level = baseUserInfo.Stonelevel;
        nextLevel = baseUserInfo.Stonelevel + 1;
        stoneBuildingRule = null == Global.getStoneBuildingRule() ? null : Global.getStoneBuildingRule()[nextLevel - 1];
        currentStoneBuildingRule = null == Global.getStoneBuildingRule() ? null : Global.getStoneBuildingRule()[level - 1];
        adSetting = Global.getAdSettingRule();
        if (null != stoneBuildingRule) {
          needTCoin = stoneBuildingRule.tcoinamount;
          woodPerAd = currentStoneBuildingRule.product;
          needFarmLevel = stoneBuildingRule.farmlevel;
        }
        watchedAd = null == baseUserInfo.ad ? 0 : baseUserInfo.ad.stone;
        maxWatchableAd = null == adSetting ? 5 : adSetting.stone;
      }

      bool canUpdate() {
        if (baseUserInfo.tcoinamount < stoneBuildingRule.tcoinamount) {
          CommonUtils.showErrorMessage(msg: "T币不足");
          return false;
        }
        if (baseUserInfo.farmlevel < stoneBuildingRule.farmlevel) {
          CommonUtils.showErrorMessage(msg: "农场等级不足");
          return false;
        }
        return true;
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
                      Image(image: new AssetImage('resource/images/coin.png'), height: ScreenUtil().setHeight(SystemIconSize.adIconSize)),
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
                  Text('观看广告获取升级资源', style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize)),
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
              type: AdTypeEnum.stone,
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
                        image: new AssetImage('resource/images/stone.png'),
                        height: ScreenUtil().setHeight(SystemIconSize.adIconSize),
                      ),
                      Text(
                        ' $woodPerAd',
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
                if (canUpdate()) {
                  this.widget.HUD();
                  BaseService.upgradeBuilding(BuildingEnum.stone.index, (model) {
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
