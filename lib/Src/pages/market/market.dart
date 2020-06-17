import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageTextButtonWithIcon/imageTextButtonWithIcon.dart';
import 'package:upgradegame/Src/pages/market/marketBid.dart';
import 'package:upgradegame/Src/pages/market/userSearchItem.dart';

class MarketDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  MarketDetail({Key key, this.HUD}) : super(key: key);

  _MarketDetailState createState() => new _MarketDetailState();
}

class _MarketDetailState extends State<MarketDetail> {
  List<UserSearchItem> searchResult = [];
  final controller = TextEditingController();
  bool showCoin = false;
  bool showWood = true;
  bool showStone = false;

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
          ScreenUtil().setWidth(120), // 左
          ScreenUtil().setHeight(400), // 上
          ScreenUtil().setWidth(100), // 右
          ScreenUtil().setHeight(220)), // 下
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ImageTextButtonWithIcon(
                  imageUrl: 'resource/images/yellowButton.png',
                  imageHeight: 120,
                  imageWidth: 240,
                  iconUrl: 'resource/images/gold.png',
                  iconHeight: 90,
                  iconWidth: 90,
                  buttonName: 'T币',
                  textSize: SystemFontSize.buttonWithIconFontSize,
                  callback: () {
                    changeTabs('coin');
                  },
                ),
                ImageTextButtonWithIcon(
                  imageUrl: 'resource/images/yellowButton.png',
                  imageHeight: 120,
                  imageWidth: 240,
                  iconUrl: 'resource/images/wood.png',
                  iconHeight: 90,
                  iconWidth: 90,
                  buttonName: '木材',
                  textSize: SystemFontSize.buttonWithIconFontSize,
                  callback: () {
                    changeTabs('wood');
                  },
                ),
                ImageTextButtonWithIcon(
                  imageUrl: 'resource/images/yellowButton.png',
                  imageHeight: 120,
                  imageWidth: 240,
                  iconUrl: 'resource/images/stone.png',
                  iconHeight: 90,
                  iconWidth: 90,
                  buttonName: '石材',
                  textSize: SystemFontSize.buttonWithIconFontSize,
                  callback: () {
                    changeTabs('stone');
                  },
                ),
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(800),
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
                                            searchResult.add(UserSearchItem(
                                              avatarUrl:
                                                  'resource/images/avatar.png',
                                              name: '黄小龙',
                                              id: '123441212',
                                            ));
                                            searchResult.add(UserSearchItem(
                                              avatarUrl:
                                                  'resource/images/avatar.png',
                                              name: '张三',
                                              id: '123441212',
                                            ));
                                            searchResult.add(UserSearchItem(
                                              avatarUrl:
                                                  'resource/images/avatar.png',
                                              name: '李四',
                                              id: '123441212',
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
                                      searchResult.clear();
                                    },
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(800),
                          height: ScreenUtil().setHeight(700),
                          child: ListView.builder(
                              itemCount: searchResult.length,
                              itemExtent: ScreenUtil().setSp(150),
                              itemBuilder: (BuildContext context, int index) {
                                return UserSearchItem(
                                  avatarUrl: searchResult[index].avatarUrl,
                                  name: searchResult[index].name,
                                  id: searchResult[index].id,
                                  callback: (){
                                    print('Send coin to '+searchResult[index].name);
                                  },
                                );
                              }),
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
