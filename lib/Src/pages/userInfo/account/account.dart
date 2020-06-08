import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';

class AccountDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  AccountDetail({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _AccountDetailState createState() => new _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(
        ScreenUtil().setWidth(0), // 左
        ScreenUtil().setHeight(120), // 上
        ScreenUtil().setWidth(0), // 右
        ScreenUtil().setHeight(150),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Container(
          child: ListView(
            children: <Widget>[
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "原密码", prefixIcon: Icon(Icons.lock)),
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "新密码", prefixIcon: Icon(Icons.lock)),
                obscureText: true,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "重复密码", prefixIcon: Icon(Icons.lock)),
                obscureText: true,
              ),
              new ImageButton(
                height: ScreenUtil().setHeight(200),
                width: ScreenUtil().setWidth(400),
                buttonName: "返回",
                imageUrl: "resource/images/upgradeButton.png",
                callback: () {
                  print('点击升级');
                  this.widget.viewCallback();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
