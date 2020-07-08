import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';

class Withdraw extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  Withdraw({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _WithdrawState createState() => new _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
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
                decoration: InputDecoration(labelText: "提现数量", prefixIcon: Icon(Icons.lock)),
              ),
              TextField(
                decoration: InputDecoration(labelText: "密码", prefixIcon: Icon(Icons.lock)),
                obscureText: true,
              ),
              ButtonsList(
                buttonWidth: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
                buttonHeight: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
                buttonBackgroundImageUrl: "resource/images/upgradeButton.png",
                textSize: SystemFontSize.buttonTextFontSize,
                buttons: [
                  ImageTextButton(
                    buttonName: '返 回',
                    callback: () {
                      this.widget.viewCallback();
                    },
                  ),
                  ImageTextButton(
                    buttonName: '确 定',
                    callback: () {
                      print('提现');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
