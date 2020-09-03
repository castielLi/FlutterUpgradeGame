import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
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
                width: ScreenUtil().setWidth(600),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        Image(image: new AssetImage('resource/images/qq.png'), height: ScreenUtil().setHeight(SystemIconSize.adIconSize)),
                        Text(
                          "群号:"+this.qq,
                          style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                        ),
                      ],
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.content_copy,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: this.qq));
                        CommonUtils.showSuccessMessage(msg: 'QQ群号复制成功');
                      },
                    ),
                  ],
                ),
              ),
//              new Padding(
//                padding: new EdgeInsets.only(top: ScreenUtil().setWidth(50)),
//                child: new Container(
//                  width: ScreenUtil().setWidth(600),
//                  child: new Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      new Row(
//                        children: <Widget>[
//                          Image(image: new AssetImage('resource/images/wechat.png'), height: ScreenUtil().setHeight(SystemIconSize.adIconSize)),
//                          Text(
//                            this.wechat,
//                            style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
//                          ),
//                        ],
//                      ),
//                      GestureDetector(
//                        child: Icon(
//                          Icons.content_copy,
//                          color: Colors.white,
//                        ),
//                        onTap: () {
//                          Clipboard.setData(ClipboardData(text: this.wechat));
//                          CommonUtils.showSuccessMessage(msg: '微信号复制成功');
//                        },
//                      ),
//                    ],
//                  ),
//                ),
//              )
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
