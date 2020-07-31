import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/common/model/enum/buildingEnum.dart';
import 'package:upgradegame/Src/common/service/baseService.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Src/common/model/baseRuleModel.dart';
import 'package:upgradegame/Src/common/model/globalDataModel.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';

class MainBuildingDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  MainBuildingDetail({Key key, this.HUD}) : super(key: key);

  _MainBuildingDetailState createState() => new _MainBuildingDetailState();
}

class _MainBuildingDetailState extends State<MainBuildingDetail> {
  // 获取数据

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
        ///当前建筑等级
        int levelFrom = baseUserInfo.Mainbuildlevel;
        int level = baseUserInfo.Mainbuildlevel + 1;

        ///升级建筑规则
        Mainbuild mainBuildRule = Global.getMainBuildingRule()[level - 1];

        ///当前建筑等级的规则
        Mainbuild currentMainBuildRude = Global.getMainBuildingRule()[levelFrom - 1];

        ///当前建筑规则需要多少木材
        int neededWood = mainBuildRule.woodamount;

        ///当前建筑规则需要多少石材
        int neededStone = mainBuildRule.stoneamount;

        ///当前建筑规则可以产出多少t币
        int coinPerHour = currentMainBuildRude.product;

        int wood = baseUserInfo.WoodAmount;

        int stone = baseUserInfo.StoneAmount;

        return new Container(
          margin: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(150), // 左
              ScreenUtil().setHeight(500), // 上
              ScreenUtil().setWidth(150), // 右
              ScreenUtil().setHeight(250)), // 下
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('LV $levelFrom > LV $level', textAlign: TextAlign.left, style: CustomFontSize.defaultTextStyle(SystemFontSize.mainBuildingTextFontSize)),
              Text('升级所需资料', style: CustomFontSize.defaultTextStyle(SystemFontSize.mainBuildingTextFontSize)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image(image: new AssetImage('resource/images/wood.png'), height: ScreenUtil().setHeight(100)),
                  Text(
                    '$neededWood ',
                    style: TextStyle(fontSize:SystemFontSize.buildingConditionTextFontSize,color: wood>=neededWood?Colors.lightGreenAccent:Colors.grey),
                  ),
                  Image(image: new AssetImage('resource/images/stone.png'), height: ScreenUtil().setHeight(100)),
                  Text('$neededStone',
                      style:TextStyle(fontSize:SystemFontSize.buildingConditionTextFontSize,color: stone>=neededStone?Colors.lightGreenAccent:Colors.grey),
                  )
                ],
              ),
              Text('升级后产出:' + '$coinPerHour' + 'T币一小时', style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize)),
              Text('每产生1T币需要消耗10木头和10石头', style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize)),
              Container(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(100)),
                child: ImageButton(
                  height: ScreenUtil().setHeight(200),
                  width: ScreenUtil().setWidth(400),
                  buttonName: "升 级",
                  imageUrl: "resource/images/upgradeButton.png",
                  callback: () {
                    if (baseUserInfo.stoneamount < neededStone || baseUserInfo.woodamount < neededWood) {
                      CommonUtils.showErrorMessage(msg: "没有足够的资源升级");
                    } else {
                      this.widget.HUD();
                      BaseService.upgradeBuilding(BuildingEnum.mainBuilding.index, (model){
                        this.widget.HUD();
                        if(model != null){
                          Provide.value<BaseUserInfoProvider>(context).upgradeBuilding(model);
                        }
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
