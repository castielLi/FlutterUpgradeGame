import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/setting/raiders/service/raidersService.dart';

import 'model/raidersModel.dart';

class RaidersDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  RaidersDetail({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _RaidersDetailState createState() => new _RaidersDetailState();
}

class _RaidersDetailState extends State<RaidersDetail> {
  String basic = '';
  String advanced = '';
  String tabName = 'basic';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      RaidersService.getRaidersList((data) {
        if (null != data) {
          setState(() {
            basic = RaidersModel.fromJson(data).basic;
            advanced = RaidersModel.fromJson(data).advanced;
          });
        }
        this.widget.HUD();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(0), // 左
          ScreenUtil().setHeight(120), // 上
          ScreenUtil().setWidth(0), // 右
          ScreenUtil().setHeight(120)),
      child: new Column(
        children: <Widget>[
          ButtonsList(
            buttonWidth: ScreenUtil().setWidth(SystemIconSize.largeButtonWithIconWidth),
            buttonHeight: ScreenUtil().setHeight(SystemIconSize.largeButtonWithIconWidth / 2),
            buttonBackgroundImageUrl: 'resource/images/teamSwitchBackground.png',
            textSize: SystemFontSize.settingTextFontSize,
            buttons: [
              ImageTextButton(
                buttonName: '基 础',
                callback: () {
                  changeTabs('basic');
                },
              ),
              ImageTextButton(
                buttonName: '进 阶',
                callback: () {
                  changeTabs('advanced');
                },
              ),
            ],
          ),
          Container(
            height: ScreenUtil().setHeight(600),
            child: Stack(
              children: [
                Offstage(
                  offstage: tabName != 'basic',
                  child: ListView(
                    children: [
                      Text(
                        basic,
                        style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Offstage(
                  offstage: tabName != 'advanced',
                  child: ListView(
                    children: [
                      Text(
                        advanced,
                        style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          new ImageButton(
            height: ScreenUtil().setHeight(200),
            width: ScreenUtil().setWidth(400),
            buttonName: "返回",
            imageUrl: "resource/images/upgradeButton.png",
            callback: () {
              print('点击升级');
//                this.widget.HUD();
              this.widget.viewCallback();
            },
          ),
        ],
      ),
    );
  }

  void changeTabs(String tab) {
    setState(() {
      tabName = tab;
    });
  }
}
