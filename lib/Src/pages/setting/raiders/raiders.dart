import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/app/config.dart';
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
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                  child: new ImageTextButton(
                    imageUrl: "resource/images/teamSwitchBackground.png",
                    imageWidth: ScreenUtil().setWidth(SystemIconSize.mediumButtonWithIconWidth),
                    imageHeight: ScreenUtil().setHeight(SystemIconSize.mediumButtonWithIconWidth / 2),
                    buttonName: "基 础",
                    textSize: SystemFontSize.settingTextFontSize,
                    callback: () {
                      setState(() {
                        basicHide = false;
                        advancedHide = true;
                      });
                    },
                  ),
                ),
                new Expanded(
                  child: new ImageTextButton(
                    imageUrl: "resource/images/teamSwitchBackground.png",
                    imageWidth: ScreenUtil().setWidth(SystemIconSize.mediumButtonWithIconWidth),
                    imageHeight: ScreenUtil().setHeight(SystemIconSize.mediumButtonWithIconWidth / 2),
                    buttonName: "进 阶",
                    textSize: SystemFontSize.settingTextFontSize,
                    callback: () {
                      setState(() {
                        basicHide = true;
                        advancedHide = false;
                      });
                    },
                  ),
                )
              ],
            ),
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
}
