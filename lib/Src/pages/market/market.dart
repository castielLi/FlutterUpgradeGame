import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageTextButtonWithIcon/imageTextButtonWithIcon.dart';
import 'package:upgradegame/Src/common/model/user.dart';
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
  bool showCoin = false;
  bool showWood = true;
  bool showStone = false;
  bool hideUserSearchResult = true;
  int falseId = 0;

  void changeTabs(String tab) {
    setState(() {
      showCoin = false;
      showWood = false;
      showStone = false;
      switch (tab) {
        case 'coin':
          {
            this.showCoin = true;
            break;
          }
        case 'wood':
          {
            this.showWood = true;
            break;
          }
        case 'stone':
          {
            this.showStone = true;
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
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ImageTextButtonWithIcon(
                  imageUrl: 'resource/images/yellowButton.png',
                  imageHeight: SystemIconSize.smallButtonWithIconWidth/2,
                  imageWidth: SystemIconSize.smallButtonWithIconWidth,
                  iconUrl: 'resource/images/gold.png',
                  iconHeight: SystemIconSize.smallIconSize,
                  iconWidth: SystemIconSize.smallIconSize,
                  buttonName: 'T币',
                  textSize: SystemFontSize.smallButtonWithIconFontSize,
                  callback: () {
                    changeTabs('coin');
                  },
                ),
                ImageTextButtonWithIcon(
                  imageUrl: 'resource/images/yellowButton.png',
                  imageHeight: SystemIconSize.smallButtonWithIconWidth/2,
                  imageWidth: SystemIconSize.smallButtonWithIconWidth,
                  iconUrl: 'resource/images/wood.png',
                  iconHeight: SystemIconSize.smallIconSize,
                  iconWidth: SystemIconSize.smallIconSize,
                  buttonName: '木材',
                  textSize: SystemFontSize.smallButtonWithIconFontSize,
                  callback: () {
                    changeTabs('wood');
                  },
                ),
                ImageTextButtonWithIcon(
                  imageUrl: 'resource/images/yellowButton.png',
                  imageHeight: SystemIconSize.smallButtonWithIconWidth/2,
                  imageWidth: SystemIconSize.smallButtonWithIconWidth,
                  iconUrl: 'resource/images/stone.png',
                  iconHeight: SystemIconSize.smallIconSize,
                  iconWidth: SystemIconSize.smallIconSize,
                  buttonName: '石材',
                  textSize: SystemFontSize.smallButtonWithIconFontSize,
                  callback: () {
                    changeTabs('stone');
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:10),
            height: ScreenUtil().setHeight(900),
            child: Stack(
              children: <Widget>[
                Offstage(
                  offstage: !this.showCoin,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(width: 5.0,),
                                  Icon(Icons.search, color: Colors.grey,),
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
                                            hideUserSearchResult = false;
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
                          width: ScreenUtil().setWidth(750),
                          height: ScreenUtil().setHeight(700),
                          child: Offstage(
                            offstage: hideUserSearchResult,
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
                  offstage: !this.showWood,
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
                Offstage(
                  offstage: !this.showStone,
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
              ],
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
