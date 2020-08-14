import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/user.dart';
import 'package:upgradegame/Src/pages/market/service/marketService.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';

class UserSearchResult extends StatefulWidget {
  User user;
  String noUserHintText;


  UserSearchResult({Key key, this.user, this.noUserHintText = ''}) : super(key: key);

  @override
  _UserSearchResult createState() => _UserSearchResult();
}

class _UserSearchResult extends State<UserSearchResult> {
  final amountController = TextEditingController();
  final passwordController = TextEditingController();
  bool showUserSearchResult = true;
  int ticket = 0;
  User currentuser;

  @override
  Widget build(BuildContext context) {

    if(this.widget.user == null){
      this.showUserSearchResult = true;
    }else{
      if(this.currentuser != null){
        if(this.currentuser.id != this.widget.user.id){
          this.showUserSearchResult = true;
        }
      }else{
        this.showUserSearchResult = true;
      }
      this.currentuser = this.widget.user;
    }


    return Container(
      child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
        return Stack(
          children: [
            Offstage(
              offstage: !this.showUserSearchResult,
              child: null == this.widget.user
                  ? Text(
                      this.widget.noUserHintText,
                      textAlign: TextAlign.center,
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                    )
                  : GestureDetector(
                      onTap: () {
                        switchBetweenTwoPages();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 30),
                        height: ScreenUtil().setHeight(SystemScreenSize.inputDecorationHeight),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: new AssetImage('resource/images/userSearchItemBackground.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                '用户:',
                                style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    this.widget.user.name,
                                    style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            Offstage(
              offstage: this.showUserSearchResult,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "赠送数量", prefixIcon: Icon(Icons.attach_money)),
                    controller: amountController,
                    onChanged: (String amount) {
                      setState(() {
                        amount = amountController.text;
                        if (!RegExp(r"^\d*$").hasMatch(amount)) {
                          CommonUtils.showErrorMessage(msg: "请输入正整数");
                          this.ticket = 0;
                        }
                        this.ticket = int.parse(amount);
                      });
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "密码", prefixIcon: Icon(Icons.lock)),
                    obscureText: true,
                    controller: passwordController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          new Image(
                            image: new AssetImage("resource/images/volume.png"),
                            width: ScreenUtil().setWidth(SystemIconSize.mainPageStatusBarSmallIconSize),
                            height: ScreenUtil().setHeight(SystemIconSize.mainPageStatusBarSmallIconSize),
                          ),
                          new Text(
                            baseUserInfo.voucher.toString(),
                            style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                          ),
                        ],
                      ),
                      Text('赠送1T币需要1张赠送券', style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize)),
                    ],
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
                          switchBetweenTwoPages();
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                      ImageTextButton(
                        buttonName: '确 定',
                        callback: () {
                          if (amountController.text == '' || passwordController.text == '') {
                            CommonUtils.showErrorMessage(msg: '输入不能为空');
                            return;
                          }
                          if(baseUserInfo.voucher >= int.parse(amountController.text)){
                            MarketService.sendCoin(this.widget.user.id, int.parse(amountController.text), passwordController.text, (data) {
                              if (data) {
                                CommonUtils.showSuccessMessage(msg: "发送成功");
                                baseUserInfo.sendCoin(int.parse(amountController.text),int.parse(amountController.text));
                                switchBetweenTwoPages();
                                amountController.clear();
                                passwordController.clear();
                              }
                            });
                            FocusScope.of(context).requestFocus(FocusNode());
                          }else{
                            CommonUtils.showErrorMessage(msg: "您的赠送券不足,请在商城购买赠送券");
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  void switchBetweenTwoPages() {
    setState(() {
      this.showUserSearchResult = !this.showUserSearchResult;
    });
  }
}
