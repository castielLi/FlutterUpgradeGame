import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';

class AccountDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  AccountDetail({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _AccountDetailState createState() => new _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  final originalPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(
        ScreenUtil().setWidth(0), // 左
        ScreenUtil().setHeight(120), // 上
        ScreenUtil().setWidth(0), // 右
        ScreenUtil().setHeight(120),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Container(
          child: ListView(
            children: <Widget>[
              TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: "原密码", prefixIcon: Icon(Icons.lock)),
                controller: originalPasswordController,
                onSubmitted: (original) {
                  original = originalPasswordController.text;
                  print(original);
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "新密码", prefixIcon: Icon(Icons.lock)),
                obscureText: true,
                controller: newPasswordController,
                onSubmitted: (newPassword) {
                  newPassword = newPasswordController.text;
                  print(newPassword);
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "重复密码", prefixIcon: Icon(Icons.lock)),
                obscureText: true,
                controller: repeatPasswordController,
                onSubmitted: (repeat) {
                  repeat = repeatPasswordController.text;
                  print(repeat);
                },
              ),
              ButtonsList(
                buttonWidth: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
                buttonHeight: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
                buttonBackgroundImageUrl: "resource/images/upgradeButton.png",
                textSize: SystemFontSize.buttonTextFontSize,
                buttons: [
                  ImageTextButton(
                    buttonName: '返回',
                    callback: () {
                      this.widget.viewCallback();
                    },
                  ),
                  ImageTextButton(
                    buttonName: '确定',
                    callback: () {
                      String newPassword = newPasswordController.text;
                      String repeatPassword = repeatPasswordController.text;
                      print("原密码：" + originalPasswordController.text + "新密码：" + newPasswordController.text + "重复：" + repeatPasswordController.text);
                      if (newPassword != repeatPassword) {
                        CommonUtils.showErrorMessage(msg: '两次输入密码不一致');
                      } else {

                        print("修改密码");
                      }
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

  @override
  void dispose() {
    originalPasswordController.dispose();
    newPasswordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }
}
