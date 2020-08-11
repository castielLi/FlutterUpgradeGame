import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/setting/event/settingEventBus.dart';
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
  String tabName = "basic";

  @override
  void initState() {
    super.initState();
    SettingHttpRequestEvent().on("raiders", this.getRaiders);
  }

  void getRaiders() {
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
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          ButtonsList(
            buttonWidth: ScreenUtil().setWidth(SystemButtonSize.largeButtonWidth),
            buttonHeight: ScreenUtil().setHeight(SystemButtonSize.largeButtonHeight),
            buttonBackgroundImageUrl: 'resource/images/teamSwitchBackground.png',
            textSize: ScreenUtil().setSp(SystemFontSize.settingTextFontSize),
            buttons: [
              ImageTextButton(
                buttonName: '基 础',
                callback: () {
                  changeTab('basic');
                },
              ),
              ImageTextButton(
                buttonName: '进 阶',
                callback: () {
                  changeTab('advanced');
                },
              ),
            ],
          ),
          Container(
            height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight - SystemButtonSize.largeButtonHeight),
            child: Stack(
              children: [
                Offstage(
                  offstage: this.tabName != 'basic',
                  child: SingleChildScrollView(
                    child: Text(
                      basic,
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Offstage(
                  offstage: this.tabName != 'advanced',
                  child: SingleChildScrollView(
                    child: Text(
                      advanced,
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          new ImageButton(
            height: ScreenUtil().setHeight(SystemButtonSize.largeButtonHeight),
            width: ScreenUtil().setWidth(SystemButtonSize.largeButtonWidth),
            buttonName: "返回",
            imageUrl: "resource/images/upgradeButton.png",
            callback: () {
//                this.widget.HUD();
              this.widget.viewCallback();
            },
          ),
        ],
      ),
    );
  }

  void changeTab(String tabName) {
    setState(() {
      this.tabName = tabName;
    });
  }
}
