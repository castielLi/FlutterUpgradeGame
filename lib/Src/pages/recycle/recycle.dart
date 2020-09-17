import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/widget/textField/myTextField.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/provider/baseUserCashProvider.dart';

class RecycleDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  RecycleDetail({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _RecycleDetailState createState() => new _RecycleDetailState();
}

class _RecycleDetailState extends State<RecycleDetail> {
  final amountController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: ScreenUtil().setHeight(1000),
      width: ScreenUtil().setWidth(850),
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(600), ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(250)),
      child: Provide<BaseUserCashProvider>(builder: (context, child, cashInfo) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new MyTextField(
              height: ScreenUtil().setHeight(SystemScreenSize.inputDecorationHeight),
              controller: amountController,
              hintText: "回收数量",
              icon: Icon(Icons.attach_money),
              // warningText: "提现收取5%的手续费",
            ),
            new MyTextField(
              height: ScreenUtil().setHeight(SystemScreenSize.inputDecorationHeight),
              controller: passwordController,
              hintText: '密码:',
              icon: Icon(Icons.lock),
              obscureText: true,
            ),
            ButtonsList(
              buttonWidth: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
              buttonHeight: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
              buttonBackgroundImageUrl: "resource/images/upgradeButton.png",
              textSize: ScreenUtil().setSp(SystemFontSize.buttonTextFontSize),
              buttons: [
                ImageTextButton(
                  buttonName: '确 定',
                  callback: () {
                    // String aliPayAccount = accountController.text;
                    String password = passwordController.text;
                    String amount = amountController.text;
                    if (password == "" || amount == "") {
                      CommonUtils.showWarningMessage(msg: "输入不能为空");
                      return;
                    }
                    if (!RegExp(r"^\d*$").hasMatch(amountController.text)) {
                      CommonUtils.showWarningMessage(msg: "请输入正整数");
                      return;
                    }
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
