import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/user.dart';
import 'package:upgradegame/Src/pages/market/service/marketService.dart';

class UserSearchResult extends StatefulWidget {
  List<User> searchResult = [];

  UserSearchResult({Key key, this.searchResult}) : super(key: key);

  @override
  _UserSearchResult createState() => _UserSearchResult();
}

class _UserSearchResult extends State<UserSearchResult> {
  final amountController = TextEditingController();
  final passwordController = TextEditingController();
  bool userSearchResultHide = false;
  bool sendCoinPageHide = true;
  User user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Offstage(
          offstage: this.userSearchResultHide,
          child: this.widget.searchResult.length == 0
              ? Text(
                  '没有搜索到用户',
                  textAlign: TextAlign.center,
                  style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                )
              : ListView.builder(
                  itemCount: this.widget.searchResult.length,
                  itemExtent: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
                  itemBuilder: (BuildContext context, int index) {
                    User user = this.widget.searchResult[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          this.sendCoinPageHide = false;
                          this.userSearchResultHide = true;
                        });
                        this.user = user;
                        print('Send coin to ' + user.name);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 3),
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
                                    user.name,
                                    style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
        ),
        Offstage(
          offstage: this.sendCoinPageHide,
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
                      showUserSearchResultPage();
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  ),
                  ImageTextButton(
                    buttonName: '确 定',
                    callback: () {
                      MarketService.sendCoin(this.user, (data) {
                        if (data) {
                          CommonUtils.showSuccessMessage(msg: "发送成功");
                          Future.delayed(Duration(seconds: 1), () {
                            showUserSearchResultPage();
                            amountController.clear();
                            passwordController.clear();
                          });
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
  }

  void showUserSearchResultPage() {
    setState(() {
      this.sendCoinPageHide = true;
      this.userSearchResultHide = false;
    });
  }
}
