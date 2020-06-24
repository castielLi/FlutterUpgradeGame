import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsInOneRow/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Src/pages/setting/raiders/raiders.dart';
import 'package:upgradegame/Src/pages/setting/protocol/protocol.dart';
import 'package:upgradegame/Src/pages/setting/private/private.dart';
import 'package:upgradegame/Src/pages/setting/aboutUs/aboutUs.dart';

class SettingDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  final changeTitleCallback;
  VoidCallback displayOriginalTitleCallback;

  SettingDetail({Key key, this.HUD, this.changeTitleCallback, this.displayOriginalTitleCallback}) : super(key: key);

  _SettingDetailState createState() => new _SettingDetailState();
}

class _SettingDetailState extends State<SettingDetail> {
  bool settingHide = false;
  String buttonName = '';

  switchPageBetweenFatherAndSon({String sonPageName}) {
    setState(() {
      // 子界面名称
      buttonName = sonPageName;
      // 父界面是否隐藏
      settingHide = (null != sonPageName && '' != sonPageName);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return new Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(80), // 左
          ScreenUtil().setHeight(280), // 上
          ScreenUtil().setWidth(80), // 右
          ScreenUtil().setHeight(100)), // 下
      child: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: this.settingHide,
            child: new Center(
              child: ButtonsList(
                buttonWidth: ScreenUtil().setWidth(900),
                buttonHeight: ScreenUtil().setHeight(190),
                buttonBackgroundImageUrl: 'resource/images/settingButtonBackground.png',
                textSize: SystemFontSize.settingTextFontSize,
                isColumn: true,
                buttons: [
                  ImageTextButton(
                    buttonName: '攻 略',
                    callback: () {
                      switchPageBetweenFatherAndSon(sonPageName: "raiders");
                      this.widget.changeTitleCallback("攻略");
                    },
                  ),
                  ImageTextButton(
                    buttonName: '用户协议',
                    callback: () {
                      switchPageBetweenFatherAndSon(sonPageName: "protocol");
                      this.widget.changeTitleCallback("用户协议");
                    },
                  ),
                  ImageTextButton(
                    buttonName: '隐私条款',
                    callback: () {
                      switchPageBetweenFatherAndSon(sonPageName: "privacy");
                      this.widget.changeTitleCallback("隐私条款");
                    },
                  ),
                  ImageTextButton(
                    buttonName: '关于我们',
                    callback: () {
                      switchPageBetweenFatherAndSon(sonPageName: "aboutUs");
                      this.widget.changeTitleCallback("关于我们");
                    },
                  ),
                ],
              ),
            ),
          ),
          new Offstage(
            offstage: buttonName != "raiders",
            child: new RaidersDetail(
              HUD: this.widget.HUD,
              viewCallback: () {
                switchPageBetweenFatherAndSon();
                this.widget.displayOriginalTitleCallback();
              },
            ),
          ),
          new Offstage(
            offstage: buttonName != "protocol",
            child: new ProtocolDetail(
              HUD: this.widget.HUD,
              viewCallback: () {
                switchPageBetweenFatherAndSon();
                this.widget.displayOriginalTitleCallback();
              },
            ),
          ),
          new Offstage(
            offstage: buttonName != "privacy",
            child: new PrivateDetail(
              HUD: this.widget.HUD,
              viewCallback: () {
                switchPageBetweenFatherAndSon();
                this.widget.displayOriginalTitleCallback();
              },
            ),
          ),
          new Offstage(
            offstage: buttonName != "aboutUs",
            child: new AboutUsDetail(
              HUD: this.widget.HUD,
              viewCallback: () {
                switchPageBetweenFatherAndSon();
                this.widget.displayOriginalTitleCallback();
              },
            ),
          ),
        ],
      ),
    );
  }
}
