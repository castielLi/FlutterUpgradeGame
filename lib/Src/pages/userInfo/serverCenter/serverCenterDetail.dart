import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';

class ServerCenter extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  ServerCenter({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _ServerCenterState createState() => new _ServerCenterState();
}

class _ServerCenterState extends State<ServerCenter> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: [
        new Container(
          width: ScreenUtil().setWidth(850),
          margin: EdgeInsets.only(top: 50),
          height: ScreenUtil().setHeight(SystemButtonSize.settingsTextHeight),
          child: Text('客服中心',textAlign: TextAlign.center,style: CustomFontSize.defaultTextStyle(70),),
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
    );
  }
}
