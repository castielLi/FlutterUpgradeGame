import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/baseRuleModel.dart';
import 'package:upgradegame/Src/common/model/enum/adTypeEnum.dart';
import 'package:upgradegame/Src/common/model/enum/buildingEnum.dart';
import 'package:upgradegame/Src/common/model/userInfoAd.dart';
import 'package:upgradegame/Src/common/service/baseService.dart';
import 'package:upgradegame/Src/common/widget/adIcon/adIconRow.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Src/common/model/globalDataModel.dart';

class FarmDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  FarmDetail({Key key, this.HUD}) : super(key: key);

  _FarmDetailState createState() => new _FarmDetailState();
}

class _FarmDetailState extends State<FarmDetail> {
  @override
  Widget build(BuildContext context) {
    return new Container(child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
      int levelFrom = 0;
      int level = 0;
      int neededCoin = 0;
      int watchedAd = 0;
      int maxWatchableAd = 0;
      int speedUpPercent = 0;
      Farm farmBuildingRule;
      Adsetting adSetting;
      int woodLevel = 0;
      int stoneLevel = 0;
      if (null != baseUserInfo) {
        levelFrom = baseUserInfo.Farmlevel;
        level = baseUserInfo.Farmlevel + 1;

        ///农场等级是从1级开始
        farmBuildingRule = null == Global.getFarmBuildingRule() ? null : Global.getFarmBuildingRule()[level - 1];
        adSetting = Global.getAdSettingRule();
        if (null != farmBuildingRule) {
          neededCoin = farmBuildingRule.tcoinamount;
          woodLevel = farmBuildingRule.woodlevel;
          stoneLevel = farmBuildingRule.stonelevel;
        }

        ///农产的广告在每天0点12点18点的时候进行刷新

        int timeHour = DateTime.now().hour;
        if (timeHour >= 0 && timeHour < 12) {
          watchedAd = null == baseUserInfo.ad ? 0 : baseUserInfo.ad.farmone;
          maxWatchableAd = null == adSetting ? 5 : adSetting.farmone;
        } else if (timeHour >= 12 && timeHour < 18) {
          watchedAd = null == baseUserInfo.ad ? 0 : baseUserInfo.ad.farmtwo;
          maxWatchableAd = null == adSetting ? 5 : adSetting.farmtwo;
        } else {
          watchedAd = null == baseUserInfo.ad ? 0 : baseUserInfo.ad.farmthree;
          maxWatchableAd = null == adSetting ? 5 : adSetting.farmthree;
        }
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
                  Text('LV $levelFrom > LV $level', textAlign: TextAlign.left, style: CustomFontSize.defaultTextStyle(SystemFontSize.mainBuildingTextFontSize)),
                  Text('升级所需资料', style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image(image: new AssetImage('resource/images/coin.png'), height: ScreenUtil().setHeight(SystemIconSize.adIconSize)),
                      Text(
                        '$neededCoin  ',
                        style: CustomFontSize.defaultTextStyle(SystemFontSize.mainBuildingTextFontSize),
                      ),
                      Image(image: new AssetImage('resource/images/fellingBuilding.png'), height: ScreenUtil().setHeight(SystemIconSize.adIconSize)),
                      Text(
                        'lv' + '$woodLevel ',
                        style: CustomFontSize.defaultTextStyle(SystemFontSize.mainBuildingTextFontSize),
                      ),
                      Image(image: new AssetImage('resource/images/stoneBuilding.png'), height: ScreenUtil().setHeight(SystemIconSize.adIconSize)),
                      Text(
                        'lv' + '$stoneLevel ',
                        style: CustomFontSize.defaultTextStyle(SystemFontSize.mainBuildingTextFontSize),
                      ),
                    ],
                  ),
                  Text('观看广告以随机获取资源', style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize)),
                ],
              ),
            ),
            AdIconRow(
              countInOneRow: maxWatchableAd,
              adIconHeight: ScreenUtil().setHeight(SystemIconSize.adIconSize),
              imageUrlWatched: 'resource/images/adWatched.png',
              imageUrlUnwatch: "resource/images/adUnwatch.png",
              imageUrlWaiting: "resource/images/adWaiting.png",
              alreadyWatched: watchedAd,
              HUD: this.widget.HUD,
              type: AdTypeEnum.farm,
            ),
            new Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '每次采石场和伐木场提速 $speedUpPercent%',
                        style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize),
                      ),
                    ],
                  ),
                  Text('本阶段观看次数 $watchedAd/$maxWatchableAd', style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize)),
                ],
              ),
            ),
            new ImageButton(
              height: ScreenUtil().setHeight(SystemButtonSize.largeButtonHeight),
              width: ScreenUtil().setWidth(SystemButtonSize.largeButtonWidth),
              buttonName: "升 级",
              imageUrl: "resource/images/upgradeButton.png",
              callback: () {
                if (null != baseUserInfo && null != farmBuildingRule) {
                  if (baseUserInfo.tcoinamount < farmBuildingRule.tcoinamount || baseUserInfo.stonelevel < farmBuildingRule.stonelevel || baseUserInfo.woodlevel < farmBuildingRule.woodlevel) {
                    CommonUtils.showErrorMessage(msg: "未达到升级条件");
                  } else {
                    this.widget.HUD();
                    BaseService.upgradeBuilding(BuildingEnum.farm.index, (model) {
                      this.widget.HUD();
                      if (model != null) {
                        Provide.value<BaseUserInfoProvider>(context).upgradeBuilding(model);
                      }
                    });
                  }
                }
              },
            ),
          ],
        ),
      );
    }));
  }
}
