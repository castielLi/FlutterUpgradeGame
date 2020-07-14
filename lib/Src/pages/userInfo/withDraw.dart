import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/userInfo/service/userInfoService.dart';
import 'package:upgradegame/Src/provider/baseUserCashProvider.dart';
import 'package:upgradegame/Src/route/application.dart';

class Withdraw extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  Withdraw({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _WithdrawState createState() => new _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  final accountController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  withdraw(){
    this.widget.HUD();
    UserInfoService.withdraw("aliaccount", "cashamount", "password", (bool success){
      this.widget.HUD();
      if(success){
        CommonUtils.showSuccessMessage(msg: "你已经发起了提现操作,等待工作人员发放,若要修改请在客服中心联系管理员");
        Provide.value<BaseUserCashProvider>(context).withdraw();
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

      child: Provide<BaseUserCashProvider>(builder: (context, child, cashInfo){
        return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "支付宝账号", prefixIcon: Icon(Icons.email)),
                controller: accountController,
              ),
              TextField(
                decoration: InputDecoration(labelText: "姓名", prefixIcon: Icon(Icons.person)),
                controller: nameController,
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
                      if(!cashInfo.hasWithdraw){
                        this.withdraw();
                      }else{
                        CommonUtils.showWarningMessage(msg: "你已经发起了提现操作,若要取消操作请在客服中心联系管理员");
                      }
                      print("Account:" + accountController.text + ",name:" + nameController.text + ",password:" + passwordController.text);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        );
      }),
    );
  }

  @override
  void dispose() {
    accountController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
