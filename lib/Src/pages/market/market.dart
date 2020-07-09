import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Src/common/model/const/resource.dart';
import 'package:upgradegame/Src/common/model/user.dart';
import 'package:upgradegame/Src/pages/market/marketAsk.dart';
import 'package:upgradegame/Src/pages/market/marketBid.dart';
import 'package:upgradegame/Src/pages/market/service/marketService.dart';
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
  bool userSearchResultHide = true;
  bool bidPageHide = false;
  bool askPageHide = true;
  String tabName = Resource.WOOD;

  int falseId = 0;
  String sellType;

  void changeTabs(String tab) {
    setState(() {
      tabName = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(100), // 左
          ScreenUtil().setHeight(400), // 上
          ScreenUtil().setWidth(100), // 右
          ScreenUtil().setHeight(100)), // 下
      child: Stack(
        children: [
          Offstage(
            offstage: bidPageHide,
            child: Column(
              children: <Widget>[
                ButtonsList(
                  buttonWidth: ScreenUtil().setWidth(SystemButtonSize.smallButtonWidth),
                  buttonHeight: ScreenUtil().setHeight(SystemButtonSize.smallButtonHeight),
                  iconWidth: ScreenUtil().setWidth(SystemIconSize.smallIconSize),
                  iconHeight: ScreenUtil().setHeight(SystemIconSize.smallIconSize),
                  buttonBackgroundImageUrl: 'resource/images/yellowButton.png',
                  textSize: SystemFontSize.smallButtonWithIconFontSize,
                  buttons: [
                    ImageTextButton(
                      buttonName: 'T币',
                      iconUrl: 'resource/images/coin.png',
                      callback: () {
                        changeTabs(Resource.COIN);
                      },
                    ),
                    ImageTextButton(
                      buttonName: '木头',
                      iconUrl: 'resource/images/wood.png',
                      callback: () {
                        changeTabs(Resource.WOOD);
                      },
                    ),
                    ImageTextButton(
                      buttonName: '石材',
                      iconUrl: 'resource/images/stone.png',
                      callback: () {
                        changeTabs(Resource.STONE);
                      },
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: ScreenUtil().setHeight(SystemButtonSize.settingsTextHeight),
                  child: Stack(
                    children: <Widget>[
                      Offstage(
                        offstage: tabName != Resource.COIN,
                        child: Scaffold(
                          resizeToAvoidBottomInset: false,
                          backgroundColor: Colors.transparent,
                          body: Column(
                            children: [
                              Container(
                                child: Container(
                                  height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
                                  padding: EdgeInsets.only(top: 5),
                                  child: new Card(
                                      child: new Container(
                                    child: new Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                              keyboardType: TextInputType.number,
                                              decoration: new InputDecoration(hintText: '输入用户手机号搜索', border: InputBorder.none),
                                              onSubmitted: (String phone) {
                                                phone = controller.text;
                                                MarketService.searchUser(phone, (data) {
                                                  if (null != data) {
                                                    setState(() {
                                                      searchResult.clear();
                                                      userSearchResultHide = false;
                                                      User user = User.fromSearchJson(data);
                                                      user.phone = phone;
                                                      searchResult.add(user);
                                                    });
                                                  }
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
                                height: ScreenUtil().setHeight(SystemButtonSize.settingsTextHeight - SystemButtonSize.inputDecorationHeight),
                                child: UserSearchResult(
                                  userSearchResultHide: userSearchResultHide,
                                  searchResult: searchResult,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Offstage(
                        offstage: tabName != Resource.WOOD,
                        child: Container(
                          height: ScreenUtil().setHeight(SystemButtonSize.settingsTextHeight),
                          child: ListView.builder(
                              padding: EdgeInsets.only(top: 0),
                              itemCount: 4,
                              itemBuilder: (BuildContext context, int index) {
                                return MarketBidItem(
                                  avatarUrl: 'resource/images/avatar.png',
                                  name: '黄小龙',
                                  bidType: 'wood',
                                  amount: 21231,
                                  needCoin: 192,
                                );
                              }),
                        ),
                      ),
                      Offstage(
                        offstage: tabName != Resource.STONE,
                        child: Container(
                          height: ScreenUtil().setHeight(SystemButtonSize.settingsTextHeight),
                          child: ListView.builder(
                              padding: EdgeInsets.only(top: 0),
                              itemCount: 2,
                              itemBuilder: (BuildContext context, int index) {
                                return MarketBidItem(
                                  avatarUrl: 'resource/images/avatar.png',
                                  name: '黄小龙',
                                  bidType: 'stone',
                                  amount: 21231,
                                  needCoin: 192,
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                Offstage(
                  offstage: tabName != Resource.WOOD && tabName != Resource.STONE,
                  child: ImageButton(
                    height: ScreenUtil().setHeight(SystemButtonSize.largeButtonHeight),
                    width: ScreenUtil().setWidth(SystemButtonSize.largeButtonWidth),
                    buttonName: "发布订单",
                    imageUrl: "resource/images/upgradeButton.png",
                    callback: () {
                      setState(() {
                        askPageHide = false;
                        bidPageHide = true;
                      });
                    },
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
