import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return new Container(
      width: ScreenUtil().setWidth(850),
      margin: EdgeInsets.only(top: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('客服中心'),
          new ImageButton(
            height: ScreenUtil().setHeight(200),
            width: ScreenUtil().setWidth(400),
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
