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

  void upgradeBuilding(){
    this.widget.HUD();
    BaseService.upgradeBuilding(BuildingEnum.mainBuilding.index, (model){
      this.widget.HUD();
      if(model != null){
        CommonUtils.showSuccessMessage(msg: "升级成功");
        Provide.value<BaseUserInfoProvider>(context).upgradeBuilding(model);
      }
    });
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

        int productCoinNeedPerWood = currentMainBuildRude.consumewood;

        int productCoinNeedPerStone = currentMainBuildRude.consumestone;

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
              Text('当前等级 LV $levelFrom', textAlign: TextAlign.left, style: CustomFontSize.defaultTextStyle(SystemFontSize.mainBuildingTextFontSize)),
              Text('产出:1小时生产' +'$coinPerHour'+'T币', style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize)),
              Text('升级所需材料', style: CustomFontSize.defaultTextStyle(SystemFontSize.mainBuildingTextFontSize)),
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

              Text('每次生产需要消耗'+ productCoinNeedPerWood.toString()+'木头和'+ productCoinNeedPerStone.toString() +'石头', style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize)),
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

                      showDialog<Null>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return new AlertDialog(
                            title: new Text('您确认要升级主城么?'),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text('取消'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              new FlatButton(
                                child: new Text('确认'),
                                onPressed: () {
                                  this.upgradeBuilding();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      ).then((val) {
                        print(val);
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
