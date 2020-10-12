import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/widget/textField/myTextField.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/globalDataModel.dart';
import 'package:upgradegame/Src/pages/userInfo/service/userInfoService.dart';
import 'package:upgradegame/Src/provider/baseUserCashProvider.dart';

class Withdraw extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  Withdraw({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _WithdrawState createState() => new _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  final accountController = TextEditingController(text: "");
  final amountController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");
  int lastClickTime;

  withdraw(String account, String password, String amount) {
    this.widget.HUD();
    UserInfoService.withdraw(account, amount, password, (bool success) {
      this.widget.HUD();
      if (success) {
        CommonUtils.showSuccessMessage(msg: "你已经发起了提现操作,等待工作人员发放,若要修改请在客服中心联系管理员");
        Provide.value<BaseUserCashProvider>(context).withdraw();
        this.widget.viewCallback();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(
        ScreenUtil().setWidth(0), // 左
        ScreenUtil().setHeight(125), // 上
        ScreenUtil().setWidth(0), // 右
        ScreenUtil().setHeight(150),
      ),
      child: Provide<BaseUserCashProvider>(builder: (context, child, cashInfo) {
        int withdrawLimitAmount = Global.getWithdrawLimit();
        double cashAmount = cashInfo.cashAmount == null ? 0 : cashInfo.cashAmount;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
              child: Text(
                "可提现金额: ¥" + cashAmount.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: ScreenUtil().setSp(SystemFontSize.moreMoreLargerTextSize), color: Colors.white, decoration: TextDecoration.none),
              ),
            ),
            new MyTextField(
              height: ScreenUtil().setHeight(SystemScreenSize.inputDecorationHeight),
              controller: accountController,
              hintText: '支付宝账号:',
              icon: Icon(Icons.email),
            ),
            new MyTextField(
              height: ScreenUtil().setHeight(SystemScreenSize.inputDecorationHeight),
              controller: amountController,
              hintText: "金额(最小提现金额为:$withdrawLimitAmount)",
              icon: Icon(Icons.attach_money),
              warningText: "提现收取5%的手续费",
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
                  buttonName: '返 回',
                  callback: () {
                    this.widget.viewCallback();
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
                ImageTextButton(
                  buttonName: '确 定',
                  callback: () {
                    if (null == this.lastClickTime || (DateTime.now().millisecondsSinceEpoch - this.lastClickTime > 5000)) {
                      this.lastClickTime = DateTime.now().millisecondsSinceEpoch;
                      String aliPayAccount = accountController.text;
                      String password = passwordController.text;
                      String amount = amountController.text;
                      if (aliPayAccount == "" || password == "" || amount == "") {
                        CommonUtils.showWarningMessage(msg: "输入不能为空");
                        return;
                      }
                      if (!RegExp(r"^\d*$").hasMatch(amountController.text)) {
                        CommonUtils.showWarningMessage(msg: "请输入正整数");
                        return;
                      }
                      if (double.parse(amountController.text) > cashAmount) {
                        CommonUtils.showWarningMessage(msg: '可提现金额不足，请重新输入');
                        return;
                      }
                      if (!cashInfo.hasWithdraw) {
                        if (double.parse(amountController.text) < withdrawLimitAmount) {
                          CommonUtils.showWarningMessage(msg: "您的提现金额不足" + withdrawLimitAmount.toString() + "还需努力哟!");
                        } else {
                          showDialog<Null>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return new AlertDialog(
                                title: new Text('您确认要发起提现操作么?'),
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
                                      this.withdraw(accountController.text, passwordController.text, amountController.text);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          ).then((val) {
                            print(val);
                          });
                        }
                      } else {
                        CommonUtils.showWarningMessage(msg: "你已经发起了提现操作,若要取消操作请在客服中心联系管理员");
                      }
                      FocusScope.of(context).requestFocus(FocusNode());
                    }
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
    accountController.dispose();
    amountController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
