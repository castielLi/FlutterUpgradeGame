import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Src/pages/userInfo/event/userInfoEventBus.dart';
import 'package:upgradegame/Src/pages/userInfo/model/serverCenterModel.dart';
import 'package:upgradegame/Src/pages/userInfo/service/userInfoService.dart';

class ServerCenter extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  ServerCenter({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _ServerCenterState createState() => new _ServerCenterState();
}

class _ServerCenterState extends State<ServerCenter> {
  String qq = "";
  String wechat = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserInfoHttpRequestEvent().on("serverCenter", this.getServerCenter);
  }

  void getServerCenter() {
    this.widget.HUD();
    UserInfoService.ServerCenter((ServerCenterModel model) {
      if (model != null) {
        setState(() {
          this.qq = model.qq;
          this.wechat = model.wechat;
        });
      }
      this.widget.HUD();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: [
        new Container(
          margin: EdgeInsets.only(top: ScreenUtil().setHeight(100)),
          height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight),
          width: ScreenUtil().setWidth(SystemScreenSize.displayContentHeight),
          child: Column(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(200)),
                child: new Row(
                  children: <Widget>[
                    Image(image: new AssetImage('resource/images/qq.png'), height: ScreenUtil().setHeight(SystemIconSize.adIconSize)),
                    Text(
                      this.qq,
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                    ),
                  ],
                ),
              ),
              new Padding(
                padding: new EdgeInsets.fromLTRB(ScreenUtil().setWidth(200), ScreenUtil().setWidth(50), ScreenUtil().setWidth(0), ScreenUtil().setWidth(0)),
                child: new Row(
                  children: <Widget>[
                    Image(image: new AssetImage('resource/images/wechat.png'), height: ScreenUtil().setHeight(SystemIconSize.adIconSize)),
                    Text(
                      this.wechat,
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                    ),
                  ],
                ),
              )
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
    );
  }
}
