import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsInOneRow/buttonsInOneRow.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Src/common/model/user.dart';
import 'package:upgradegame/Src/pages/market/marketAsk.dart';
import 'package:upgradegame/Src/pages/market/marketBid.dart';
import 'package:upgradegame/Src/pages/market/userSearchResult.dart';

class MarketDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  MarketDetail({Key key, this.HUD}) : super(key: key);

  _MarketDetailState createState() => new _MarketDetailState();
}

class _MarketDetailState extends State<MarketDetail> {
  List<User> searchResult = [];
  final controller = TextEditingController();
  bool bidPageHide = false;
  bool askPageHide = true;
  bool coinHide = true;
  bool woodHide = false;
  bool stoneHide = true;
  bool userSearchResultHide = true;
  int falseId = 0;
  String sellType;

  void changeTabs(String tab) {
    setState(() {
      coinHide = true;
      woodHide = true;
      stoneHide = true;
      switch (tab) {
        case 'coin':
          {
            this.coinHide = false;
            break;
          }
        case 'wood':
          {
            this.woodHide = false;
            break;
          }
        case 'stone':
          {
            this.stoneHide = false;
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(100), // 左
          ScreenUtil().setHeight(400), // 上
          ScreenUtil().setWidth(100), // 右
          ScreenUtil().setHeight(200)), // 下
      child: Stack(
        children: [
          Offstage(
            offstage: bidPageHide,
            child: Column(
              children: <Widget>[
                ButtonsInOneRow(
                  buttonWidth: ScreenUtil().setWidth(SystemIconSize.smallButtonWithIconWidth),
                  buttonHeight: ScreenUtil().setHeight(SystemIconSize.smallButtonWithIconWidth / 2),
                  iconWidth: ScreenUtil().setWidth(SystemIconSize.smallIconSize),
                  iconHeight: ScreenUtil().setHeight(SystemIconSize.smallIconSize),
                  buttonBackgroundImageUrl: 'resource/images/yellowButton.png',
                  textSize: SystemFontSize.smallButtonWithIconFontSize,
                  buttons: [
                    ImageTextButton(
                      buttonName: 'T币',
                      iconUrl: 'resource/images/gold.png',
                      callback: () {
                        changeTabs('coin');
                      },
                    ),
                    ImageTextButton(
                      buttonName: '木头',
                      iconUrl: 'resource/images/wood.png',
                      callback: () {
                        changeTabs('wood');
                      },
                    ),
                    ImageTextButton(
                      buttonName: '石材',
                      iconUrl: 'resource/images/stone.png',
                      callback: () {
                        changeTabs('stone');
                      },
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: ScreenUtil().setHeight(900),
                  child: Stack(
                    children: <Widget>[
                      Offstage(
                        offstage: this.coinHide,
                        child: Scaffold(
                          resizeToAvoidBottomInset: false,
                          backgroundColor: Colors.transparent,
                          body: Column(
                            children: [
                              Container(
                                child: Container(
                                  height: ScreenUtil().setHeight(150),
                                  padding: EdgeInsets.only(top: 5),
                                  child: new Card(
                                      child: new Container(
                                    child: new Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Icon(
                                          Icons.search,
                                          color: Colors.grey,
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: TextField(
                                              controller: controller,
                                              decoration: new InputDecoration(
                                                  hintText: '输入用户名',
                                                  border: InputBorder.none),
                                              onSubmitted: (String input) {
                                                // TODO 获取搜索用户数据
                                                input = controller.text;
                                                setState(() {
                                                  searchResult.clear();
                                                  userSearchResultHide = false;
                                                  searchResult.add(User(
                                                    avatarUrl:
                                                        'resource/images/avatar.png',
                                                    name: '黄小龙',
                                                    id: '1000' +
                                                        (falseId++).toString(),
                                                  ));
                                                  searchResult.add(User(
                                                    avatarUrl:
                                                        'resource/images/avatar.png',
                                                    name: '张三',
                                                    id: '1000' +
                                                        (falseId++).toString(),
                                                  ));
                                                  searchResult.add(User(
                                                    avatarUrl:
                                                        'resource/images/avatar.png',
                                                    name: '李四',
                                                    id: '1000' +
                                                        (falseId++).toString(),
                                                  ));
                                                });
                                              },
                                              // onChanged: onSearchTextChanged,
                                            ),
                                          ),
                                        ),
                                        new IconButton(
                                          icon: new Icon(Icons.cancel),
                                          color: Colors.grey,
                                          iconSize: 18.0,
                                          onPressed: () {
                                            controller.clear();
                                          },
                                        ),
                                      ],
                                    ),
                                  )),
                                ),
                              ),
                              Container(
                                height: ScreenUtil().setHeight(700),
                                child: Offstage(
                                  offstage: userSearchResultHide,
                                  child: UserSearchResult(
                                    searchResult: searchResult,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Offstage(
                        offstage: this.woodHide,
                        child: Column(
                          children: [
                            Container(
                              height: ScreenUtil().setHeight(750),
                              child: ListView.builder(
                                  padding: EdgeInsets.only(top: 0),
                                  itemCount: 4,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return MarketBidItem(
                                      avatarUrl: 'resource/images/avatar.png',
                                      name: '黄小龙',
                                      bidType: 'wood',
                                      amount: 21231,
                                      needCoin: 192,
                                    );
                                  }),
                            ),
                            ImageButton(
                              height: ScreenUtil().setHeight(150),
                              width: ScreenUtil().setWidth(400),
                              buttonName: "发布订单",
                              imageUrl: "resource/images/upgradeButton.png",
                              callback: () {
                                setState(() {
                                  sellType = "木材";
                                  askPageHide = false;
                                  bidPageHide = true;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Offstage(
                        offstage: this.stoneHide,
                        child: Column(
                          children: [
                            Container(
                              height: ScreenUtil().setHeight(750),
                              child: ListView.builder(
                                  padding: EdgeInsets.only(top: 0),
                                  itemCount: 2,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return MarketBidItem(
                                      avatarUrl: 'resource/images/avatar.png',
                                      name: '黄小龙',
                                      bidType: 'stone',
                                      amount: 21231,
                                      needCoin: 192,
                                    );
                                  }),
                            ),
                            ImageButton(
                              height: ScreenUtil().setHeight(150),
                              width: ScreenUtil().setWidth(400),
                              buttonName: "发布订单",
                              imageUrl: "resource/images/upgradeButton.png",
                              callback: () {
                                setState(() {
                                  askPageHide = false;
                                  bidPageHide = true;
                                });
                                sellType = "石头";
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Offstage(
            offstage: askPageHide,
            child: MarketAsk(
              sellType: sellType,
              viewCallback: () {
                setState(() {
                  askPageHide = true;
                  bidPageHide = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
