import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/userInfo/account/service/accountService.dart';

class AccountDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  AccountDetail({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _AccountDetailState createState() => new _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  final phoneController = TextEditingController();
  final newPasswordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  bool isPasswordValid() {
    String newPassword = newPasswordController.text;
    String repeatPassword = repeatPasswordController.text;

    if (newPassword != repeatPassword) {
      CommonUtils.showErrorMessage(msg: '两次输入密码不一致');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(
        ScreenUtil().setWidth(0), // 左
        ScreenUtil().setHeight(120), // 上
        ScreenUtil().setWidth(0), // 右
        ScreenUtil().setHeight(120),
      ),
      child: Container(
        child: Column(
          children: <Widget>[
            TextField(
              // obscureText: true,
              decoration: InputDecoration(labelText: "手机号码", prefixIcon: Icon(Icons.phone)),
              controller: phoneController,
              onSubmitted: (original) {
                original = phoneController.text;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: "重置密码", prefixIcon: Icon(Icons.lock)),
              obscureText: true,
              controller: newPasswordController,
              onSubmitted: (newPassword) {
                newPassword = newPasswordController.text;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: "确认密码", prefixIcon: Icon(Icons.lock)),
              obscureText: true,
              controller: repeatPasswordController,
              onSubmitted: (repeat) {
                repeat = repeatPasswordController.text;
              },
            ),
            ButtonsList(
              buttonWidth: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
              buttonHeight: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
              buttonBackgroundImageUrl: "resource/images/upgradeButton.png",
              textSize: ScreenUtil().setSp(SystemFontSize.buttonTextFontSize),
              buttons: [
                ImageTextButton(
                  buttonName: '返回',
                  callback: () {
                    this.widget.viewCallback();
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
                ImageTextButton(
                  buttonName: '确定',
                  callback: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (!RegExp(r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$").hasMatch(phoneController.text)) {
                      CommonUtils.showErrorMessage(msg: "请输入正确的手机号码");
                      return;
                    }
                    if (!isPasswordValid()) {
                      return;
                    }
                    showDialog<Null>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return new AlertDialog(
                          title: new Text('您确认修改密码么?'),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text('取消'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            new FlatButton(
                              child: new Text('确认'),
                              onPressed: () {
                                this.widget.HUD();
                                AccountService.changePassword(repeatPasswordController.text, phoneController.text, (data) {
                                  if (ConfigSetting.SUCCESS == data) {
                                    CommonUtils.showSuccessMessage(msg: "密码修改成功");
                                    this.widget.viewCallback();
                                    phoneController.clear();
                                    newPasswordController.clear();
                                    repeatPasswordController.clear();
                                  }
                                });
                                this.widget.HUD();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    ).then((val) {
                      print(val);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    newPasswordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }
}
