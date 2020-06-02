import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';

class PrivateDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  PrivateDetail({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _PrivateDetailState createState() => new _PrivateDetailState();
}

class _PrivateDetailState extends State<PrivateDetail> {
  String privacyContext = '隐私条款';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Stack(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(0), // 左
                ScreenUtil().setHeight(120), // 上
                ScreenUtil().setWidth(0), // 右
                ScreenUtil().setHeight(120)),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(820),
                  child: ListView(
                    children: <Widget>[
                      Text(this.privacyContext),
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
          ),
        ],
      ),
    );
  }
}
