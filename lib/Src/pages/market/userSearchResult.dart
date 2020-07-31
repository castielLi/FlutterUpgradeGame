import 'package:flutter/material.dart';
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

  UserSearchResult({Key key, this.user, this.noUserHintText}) : super(key: key);

  @override
  _UserSearchResult createState() => _UserSearchResult();
}

class _UserSearchResult extends State<UserSearchResult> {
  final amountController = TextEditingController();
  final passwordController = TextEditingController();
  bool showFirstOfTwoPages = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
        return Stack(
          children: [
            Offstage(
              offstage: !this.showFirstOfTwoPages,
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
                  height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
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
//                              Image(
//                                image: new AssetImage(user.avatarUrl),
//                                height: ScreenUtil().setHeight(90),
//                              ),
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
              offstage: this.showFirstOfTwoPages,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "赠送数量", prefixIcon: Icon(Icons.attach_money)),
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
                    textSize: SystemFontSize.buttonTextFontSize,
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
                          //TODO 与原密码比较
                          MarketService.sendCoin(this.widget.user.id, int.parse(amountController.text), passwordController.text, (data) {
                            if (data) {
                              CommonUtils.showSuccessMessage(msg: "发送成功");
                              baseUserInfo.sendCoin(int.parse(amountController.text));
                              switchBetweenTwoPages();
                              amountController.clear();
                              passwordController.clear();
                            }
                          });
                          FocusScope.of(context).requestFocus(FocusNode());
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
      this.showFirstOfTwoPages = !this.showFirstOfTwoPages;
    });
  }
}
