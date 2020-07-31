import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/setting/event/settingEventBus.dart';
import 'package:upgradegame/Src/pages/setting/private/service/privacyService.dart';

import 'model/privacyModel.dart';

class PrivateDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  PrivateDetail({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _PrivateDetailState createState() => new _PrivateDetailState();
}

class _PrivateDetailState extends State<PrivateDetail> {
  String privacy = '';

  @override
  void initState() {
    super.initState();
    SettingHttpRequestEvent().on("private", this.getPrivacy);
  }

  void getPrivacy(){
    this.widget.HUD();
    PrivacyService.getPrivacy((data) {
      if (null != data) {
        setState(() {
          privacy = PrivacyModel.fromJson(data).content;
        });
      }
    });
    this.widget.HUD();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: ScreenUtil().setWidth(SystemButtonSize.displayContentHeight),
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(0), // 左
          ScreenUtil().setHeight(120), // 上
          ScreenUtil().setWidth(0), // 右
          ScreenUtil().setHeight(120)),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(SystemButtonSize.displayContentHeight),
            child: SingleChildScrollView(
              child: Text(
                this.privacy,
                textAlign: TextAlign.center,
                style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
              ),
            ),
          ),
          new ImageButton(
            height: ScreenUtil().setHeight(SystemButtonSize.largeButtonHeight),
            width: ScreenUtil().setWidth(SystemButtonSize.largeButtonWidth),
            buttonName: "返回",
            imageUrl: "resource/images/upgradeButton.png",
            callback: () {
              this.widget.viewCallback();
            },
          ),
        ],
      ),
    );
  }
}
