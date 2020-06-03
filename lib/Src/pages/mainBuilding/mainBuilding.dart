import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Src/common/model/baseRuleModel.dart';
import 'package:upgradegame/Src/common/model/globalDataModel.dart';

class MainBuildingDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  MainBuildingDetail({Key key, this.HUD}) : super(key: key);

  _MainBuildingDetailState createState() => new _MainBuildingDetailState();
}

class _MainBuildingDetailState extends State<MainBuildingDetail> {
  // 获取数据
  static int neededWood = 2910;
  static int neededStone = 2910;
  static int coinPerHour = 291;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Provide<BaseUserInfoProvider>(
          builder: (context, child, baseUserInfo) {
        int levelFrom = baseUserInfo.Mainbuildlevel;
        int level = baseUserInfo.Mainbuildlevel + 1;
        return new Container(
          margin: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(150), // 左
              ScreenUtil().setHeight(400), // 上
              ScreenUtil().setWidth(150), // 右
              ScreenUtil().setHeight(180)), // 下
          color: Colors.transparent,
          child: ListView(
            itemExtent: 60, // list高度
            children: <Widget>[
              Text('LV $levelFrom > LV $level',
                  textAlign: TextAlign.left, style: CustomFontSize.textStyle30),
              Text('升级所需资料', style: CustomFontSize.textStyle30),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image(
                      image: new AssetImage('resource/images/wood.png'),
                      height: ScreenUtil().setHeight(100)),
                  Text(
                    '$neededWood ',
                    style: CustomFontSize.textStyle30,
                  ),
                  Image(
                       image: new AssetImage('resource/images/stone.png'),
                       height: ScreenUtil().setHeight(100)),
                  Text('$neededStone', style: CustomFontSize.textStyle30),
                ],
              ),
              Text('升级后产出:' + '$coinPerHour' + 'T币一小时',
                  style: CustomFontSize.textStyle22),
              new ImageButton(
                height: ScreenUtil().setHeight(200),
                width: ScreenUtil().setWidth(400),
                buttonName: "升 级",
                imageUrl: "resource/images/upgradeButton.png",
                callback: () {
                  List<Mainbuild> rule =  Global.getMainBuildingRule();
                  print(rule[0].stoneamount);
                  this.widget.HUD();
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
