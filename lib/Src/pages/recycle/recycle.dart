import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/widget/textField/myTextField.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/provider/baseFightLineupProvider.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:upgradegame/Src/pages/recycle/service/recycleService.dart';

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

  void recycleSupplies(String password,String amount){
    this.widget.HUD();
    RecycleService.recycleSupplies(password, amount, (model){
      this.widget.HUD();
      if(model!=null) {
        CommonUtils.showSuccessMessage(msg: "兑换成功,金额已经打入您的现金账户,请查看");
        Provide.value<BaseFightLineupProvider>(context).exchangeSupplies(
            model.supplies);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(
        ScreenUtil().setWidth(80), // 左
        ScreenUtil().setHeight(425), // 上
        ScreenUtil().setWidth(80), // 右
        ScreenUtil().setHeight(150),
      ),
      child: Provide<BaseFightLineupProvider>(builder: (context, child, model) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                child: new Row(
                  children: <Widget>[
                    Image(
                      image: new AssetImage("resource/images/coin.png"),
                      width: ScreenUtil().setWidth(120),
                      height: ScreenUtil().setHeight(120),
                      fit: BoxFit.fill,
                    ),
                    Text(
                      "今日物资回收价格为:" + model.suppliesprice.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: ScreenUtil().setSp(SystemFontSize.moreMoreLargerTextSize), color: Colors.white, decoration: TextDecoration.none),
                    ),
                  ],
                )),
            Container(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
              child: Text(
                "可兑换物资:" + model.supplies.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: ScreenUtil().setSp(SystemFontSize.moreMoreLargerTextSize), color: Colors.white, decoration: TextDecoration.none),
              ),
            ),
            new MyTextField(
              height: ScreenUtil().setHeight(SystemScreenSize.inputDecorationHeight),
              controller: amountController,
              hintText: "数量(最小兑换额为:" + model.limitsuppliesrecycle.toString() + ")",
              icon: Icon(Icons.attach_money),
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
                    if (!RegExp(r"^\d*$").hasMatch(amountController.text)) {
                      CommonUtils.showWarningMessage(msg: "请输入正整数");
                      return;
                    }
                    if (double.parse(amountController.text) > model.supplies) {
                      CommonUtils.showWarningMessage(msg: '可兑换余额不足，请重新输入');
                      return;
                    }
                    if (double.parse(amountController.text) < model.limitsuppliesrecycle) {
                      CommonUtils.showWarningMessage(msg: "您的兑换金额不足" + model.limitsuppliesrecycle.toString() + "还需努力哟!");
                    } else {
                      showDialog<Null>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return new AlertDialog(
                            title: new Text('您确认要发起兑换操作么?'),
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
                                  this.recycleSupplies(passwordController.text, amountController.text);
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
