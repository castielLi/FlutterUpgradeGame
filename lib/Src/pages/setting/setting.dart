import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Src/pages/setting/event/settingEventBus.dart';
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

  @override
  void initState() {
    super.initState();
    SettingHttpRequestEvent();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SettingHttpRequestEvent().off();
  }

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
                      switchPageBetweenFatherAndSon(sonPageName: "攻略");
                      this.widget.changeTitleCallback("攻略");
                      SettingHttpRequestEvent().emit("raiders");
                    },
                  ),
                  ImageTextButton(
                    buttonName: '用户协议',
                    callback: () {
                      switchPageBetweenFatherAndSon(sonPageName: "用户协议");
                      this.widget.changeTitleCallback("用户协议");
                      SettingHttpRequestEvent().emit("protocol");
                    },
                  ),
                  ImageTextButton(
                    buttonName: '隐私条款',
                    callback: () {
                      switchPageBetweenFatherAndSon(sonPageName: "隐私条款");
                      this.widget.changeTitleCallback("隐私条款");
                      SettingHttpRequestEvent().emit("private");
                    },
                  ),
                  ImageTextButton(
                    buttonName: '关于我们',
                    callback: () {
                      switchPageBetweenFatherAndSon(sonPageName: "关于我们");
                      this.widget.changeTitleCallback("关于我们");
                      SettingHttpRequestEvent().emit("aboutus");
                    },
                  ),
                ],
              ),
            ),
          ),
          new Offstage(
            offstage: buttonName != "攻略",
            child: new RaidersDetail(
              HUD: this.widget.HUD,
              viewCallback: () {
                switchPageBetweenFatherAndSon();
                this.widget.displayOriginalTitleCallback();
              },
            ),
          ),
          new Offstage(
            offstage: buttonName != "用户协议",
            child: new ProtocolDetail(
              HUD: this.widget.HUD,
              viewCallback: () {
                switchPageBetweenFatherAndSon();
                this.widget.displayOriginalTitleCallback();
              },
            ),
          ),
          new Offstage(
            offstage: buttonName != "隐私条款",
            child: new PrivateDetail(
              HUD: this.widget.HUD,
              viewCallback: () {
                switchPageBetweenFatherAndSon();
                this.widget.displayOriginalTitleCallback();
              },
            ),
          ),
          new Offstage(
            offstage: buttonName != "关于我们",
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
