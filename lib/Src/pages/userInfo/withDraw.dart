import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/userInfo/service/userInfoService.dart';
import 'package:upgradegame/Src/provider/baseUserCashProvider.dart';
import 'package:upgradegame/Src/common/model/globalDataModel.dart';

class Withdraw extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  Withdraw({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _WithdrawState createState() => new _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  final accountController = TextEditingController();
  final amountController = TextEditingController();
  final passwordController = TextEditingController();

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
    int withdrawLimitAmount = Global.getWithdrawLimit();
    return new Container(
      margin: EdgeInsets.fromLTRB(
        ScreenUtil().setWidth(0), // 左
        ScreenUtil().setHeight(125), // 上
        ScreenUtil().setWidth(0), // 右
        ScreenUtil().setHeight(150),
      ),
      child: Provide<BaseUserCashProvider>(builder: (context, child, cashInfo) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(45)),
              child: Text(
                "可提现金额: ¥"+(cashInfo.cashAmount == null ? "0" : cashInfo.cashAmount.toString()),
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: ScreenUtil().setSp(SystemFontSize.moreMoreLargerTextSize), color: Colors.white, decoration: TextDecoration.none),
              ),
            ),
            TextField(
              decoration: InputDecoration(labelText: "支付宝账号", prefixIcon: Icon(Icons.email)),
              controller: accountController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "金额", prefixIcon: Icon(Icons.attach_money)),
              controller: amountController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "密码", prefixIcon: Icon(Icons.lock)),
              obscureText: true,
              controller: passwordController,
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
                    String aliPayAccount = accountController.text;
                    String password = passwordController.text;
                    String amount = amountController.text;
                    if (aliPayAccount == "" || password == "" || amount == "") {
                      CommonUtils.showErrorMessage(msg: "输入不能为空");
                      return;
                    }
                    if (!cashInfo.hasWithdraw) {
                      if(double.parse(amountController.text)<withdrawLimitAmount){
                        CommonUtils.showWarningMessage(msg: "您的资产不足" + withdrawLimitAmount.toString() +"还需努力哟!");
                      }else{
                        this.withdraw(accountController.text, passwordController.text, amountController.text);
                      }
                    }else {
                      CommonUtils.showWarningMessage(msg: "你已经发起了提现操作,若要取消操作请在客服中心联系管理员");
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
    accountController.dispose();
    amountController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
