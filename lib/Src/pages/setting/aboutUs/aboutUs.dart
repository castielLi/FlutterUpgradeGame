import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Src/pages/setting/aboutUs/model/aboutUsModel.dart';
import 'package:upgradegame/Src/pages/setting/aboutUs/service/aboutUsService.dart';
import 'package:upgradegame/Src/pages/setting/event/settingEventBus.dart';

class AboutUsDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  AboutUsDetail({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _AboutUsDetailState createState() => new _AboutUsDetailState();
}

class _AboutUsDetailState extends State<AboutUsDetail> {
  String content = "";

  @override
  void initState() {
    super.initState();
    SettingHttpRequestEvent().on("aboutus", this.getAboutUs);
  }

  void getAboutUs(){
    this.widget.HUD();
    AboutUsService.getAboutUs((data) {
      if (null != data) {
        setState(() {
          content = AboutUsModel.fromJson(data).content;
        });
      }
    });
    this.widget.HUD();
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(SystemButtonSize.settingsTextHeight),
            child: ListView(
              children: <Widget>[
                Text(
                  this.content,
                  textAlign: TextAlign.center,
                  style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
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
}
