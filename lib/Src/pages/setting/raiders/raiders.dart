import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/widget/buttonsInOneRow/buttonsInOneRow.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageTextButtonWithIcon/imageTextButtonWithIcon.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/setting/raiders/model/RaidersModel.dart';
import 'package:upgradegame/Src/pages/setting/raiders/service/raidersService.dart';

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
  bool basicHide = false;
  bool advancedHide = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      RaidersService.getRaidersList().then((data) {
        if (data.code == ConfigSetting.SUCCESS && data.data != null) {
          setState(() {
            basic = RaidersModel.fromJson(data.data).basic;
            advanced = RaidersModel.fromJson(data.data).advanced;
          });
        } else {
          CommonUtils.showErrorMessage(msg: "网络请求失败，请重试");
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
          ButtonsInOneRow(
            buttonWidth:
                ScreenUtil().setWidth(SystemIconSize.largeButtonWithIconWidth),
            buttonHeight: ScreenUtil()
                .setHeight(SystemIconSize.largeButtonWithIconWidth / 2),
            buttonBackgroundImageUrl:
                'resource/images/teamSwitchBackground.png',
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
            width: ScreenUtil().setWidth(800),
            height: ScreenUtil().setHeight(600),
            child: Stack(
              children: [
                Offstage(
                  offstage: basicHide,
                  child: ListView(
                    children: [
                      Text(
                        basic,
                        style: CustomFontSize.defaultTextStyle(
                            SystemFontSize.moreMoreLargerTextSize),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Offstage(
                  offstage: advancedHide,
                  child: ListView(
                    children: [
                      Text(
                        advanced,
                        style: CustomFontSize.defaultTextStyle(
                            SystemFontSize.moreMoreLargerTextSize),
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
      basicHide = true;
      advancedHide = true;
      switch (tab) {
        case 'basic':
          {
            this.basicHide = false;
            break;
          }
        case 'advanced':
          {
            this.advancedHide = false;
          }
      }
    });
  }
}
