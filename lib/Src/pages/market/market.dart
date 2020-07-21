import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/widget/textField/myTextField.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/const/resource.dart';
import 'package:upgradegame/Src/common/model/enum/marketTradeTypeEnum.dart';
import 'package:upgradegame/Src/common/model/user.dart';
import 'package:upgradegame/Src/pages/market/event/marketEventBus.dart';
import 'package:upgradegame/Src/pages/market/marketAsk.dart';
import 'package:upgradegame/Src/pages/market/marketBidItem.dart';
import 'package:upgradegame/Src/pages/market/model/tradeListModel.dart';
import 'package:upgradegame/Src/pages/market/service/marketService.dart';
import 'package:upgradegame/Src/pages/market/userSearchResult.dart';

import 'model/tradeItemModel.dart';

class MarketDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  MarketDetail({Key key, this.HUD}) : super(key: key);

  _MarketDetailState createState() => new _MarketDetailState();
}

class _MarketDetailState extends State<MarketDetail> {
  List<User> searchResult = [];
  final controller = TextEditingController();
  String contentName = Resource.WOOD;

  List<TradeItemModel> myTrades = [];
  TradeListModel woodList;
  TradeListModel stoneList;
  int woodPage = 0;
  int stonePage = 0;
  String sellType = "wood";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MarketHttpRequestEvent().on("getMyTradeList", this.getMyTradeList);
    MarketHttpRequestEvent().on("getWoodTradeList", this.getWoodTradeList);
    MarketHttpRequestEvent().on("getStoneTradeList", this.getStoneTradeList);

    ///默认会显示木材的市场，所以第一次进界面的时候需要请求石材和我的发布订单两个http
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getWoodTradeList();
      this.widget.HUD();
      Future.wait([this.getMyTradeList(), this.getStoneTradeList()]).then((List array) {
        this.widget.HUD();
        if (this.judgeAllRequestSuccess(array)) {
          CommonUtils.showErrorMessage(msg: "请求市场数据出错，请关闭界面重新获取");
        }
      });
    });
  }

  ///判断当前的请求都请求成功
  bool judgeAllRequestSuccess(List array) {
    for (int i = 0; i < array.length; i++) {
      if (!array[i]) {
        return false;
      }
    }
    return true;
  }

  /// 获取我所发布的市场订单
  Future<bool> getMyTradeList() async {
    MarketService.getMyMarketTrade((model) {
      if (model != null) {
        setState(() {
          myTrades = model.datalist;
        });
        return true;
      } else {
        return false;
      }
    });
  }

  void getWoodTradeList() {
    this.widget.HUD();
    MarketService.getMarketTradeByType(this.woodPage, MarketTradeTypeEnum.wood, (TradeListModel model) {
      print("请求page:" + this.woodPage.toString() + ", type: wood");
      if (model != null) {
        woodList = model;
      }
      this.widget.HUD();
    });
  }

  ///获取石材的市场订单情况
  Future<bool> getStoneTradeList() async {
    this.widget.HUD();
    MarketService.getMarketTradeByType(this.stonePage, MarketTradeTypeEnum.stone, (TradeListModel model) {
      print("请求page:" + this.stonePage.toString() + ", type: stone");
      this.widget.HUD();
      if (model != null) {
        stoneList = model;
        return true;
      } else {
        return false;
      }
    });
  }

  void changeDisplayContent(String tab) {
    setState(() {
      contentName = tab;
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
                  changeDisplayContent(Resource.COIN);
                },
              ),
              ImageTextButton(
                buttonName: '木头',
                iconUrl: 'resource/images/wood.png',
                callback: () {
                  this.sellType = "wood";
                  changeDisplayContent(Resource.WOOD);
                  MarketHttpRequestEvent().emit("getWoodTradeList");
                },
              ),
              ImageTextButton(
                buttonName: '石材',
                iconUrl: 'resource/images/stone.png',
                callback: () {
                  this.sellType = "stone";
                  changeDisplayContent(Resource.STONE);
                  MarketHttpRequestEvent().emit("getStoneTradeList");
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
                  offstage: contentName != Resource.COIN,
                  child: Column(
                    children: [
                      MyTextField(
                        height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
                        controller: controller,
                        inputType: TextInputType.number,
                        hintText: '输入用户手机号搜索',
                        icon: Icon(Icons.search),
                        onSubmittedCallback: () {
                          String phone = controller.text;
                          MarketService.searchUser(phone, (data) {
                            if (null != data) {
                              setState(() {
                                searchResult.clear();
                                User user = User.fromSearchJson(data);
                                user.phone = phone;
                                searchResult.add(user);
                              });
                            }
                          });
                        },
                      ),
                      Container(
                        height: ScreenUtil().setHeight(SystemButtonSize.settingsTextHeight - SystemButtonSize.inputDecorationHeight),
                        child: UserSearchResult(
                          searchResult: searchResult,
                        ),
                      ),
                    ],
                  ),
                ), // coin
                Offstage(
                  offstage: contentName != Resource.WOOD,
                  child: Container(
                    height: ScreenUtil().setHeight(SystemButtonSize.settingsTextHeight),
                    child: EasyRefresh(
                      refreshFooter: ClassicsFooter(
                        bgColor: Colors.transparent,
                        loadText: "上滑加载",
                        loadReadyText: "松开加载",
                        loadingText: "正在加载",
                        loadedText: "加载完成",
                        noMoreText: "没有更多了",
                        loadHeight: 35,
                        key: new GlobalKey<RefreshFooterState>(),
                      ),
                      refreshHeader: ClassicsHeader(
                        bgColor: Colors.transparent,
                        refreshText: "下拉刷新",
                        refreshReadyText: "松开刷新",
                        refreshingText: "正在刷新",
                        refreshedText: "刷新完成",
                        refreshHeight: 35,
                        key: new GlobalKey<RefreshHeaderState>(),
                      ),
                      // ignore: missing_return
                      loadMore: () {
                        setState(() {
                          woodPage++;
                          getWoodTradeList();
                        });
                      },
                      // ignore: missing_return
                      onRefresh: () {
                        setState(() {
                          getWoodTradeList();
                        });
                      },
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 0),
                          itemCount: null == this.woodList ? 0 : this.woodList.datalist.length,
                          itemBuilder: (BuildContext context, int index) {
                            TradeItemModel tradeItemModel = this.woodList.datalist[index];
                            return MarketBidItem(
                              buttonName: "购 买",
                              name: tradeItemModel.displayname,
                              bidType: "wood",
                              amount: tradeItemModel.amount,
                              needCoin: tradeItemModel.price,
                              buttonCallback: () {
                                print("buy wood");
                              },
                            );
                          }),
                    ),
                  ),
                ), // wood
                Offstage(
                  offstage: contentName != Resource.STONE,
                  child: Container(
                    height: ScreenUtil().setHeight(SystemButtonSize.settingsTextHeight),
                    child: EasyRefresh(
                      refreshFooter: ClassicsFooter(
                        bgColor: Colors.transparent,
                        loadText: "上滑加载",
                        loadReadyText: "松开加载",
                        loadingText: "正在加载",
                        loadedText: "加载完成",
                        noMoreText: "没有更多了",
                        loadHeight: 35,
                        key: new GlobalKey<RefreshFooterState>(),
                      ),
                      refreshHeader: ClassicsHeader(
                        bgColor: Colors.transparent,
                        refreshText: "下拉刷新",
                        refreshReadyText: "松开刷新",
                        refreshingText: "正在刷新",
                        refreshedText: "刷新完成",
                        refreshHeight: 35,
                        key: new GlobalKey<RefreshHeaderState>(),
                      ),
                      // ignore: missing_return
                      loadMore: () {
                        setState(() {
                          stonePage++;
                          getStoneTradeList();
                        });
                      },
                      // ignore: missing_return
                      onRefresh: () {
                        setState(() {
                          getStoneTradeList();
                        });
                      },
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 0),
                          itemCount: null == this.stoneList ? 0 : this.stoneList.datalist.length,
                          itemBuilder: (BuildContext context, int index) {
                            TradeItemModel tradeItemModel = this.stoneList.datalist[index];
                            return MarketBidItem(
                              buttonName: "购 买",
                              name: tradeItemModel.displayname,
                              bidType: "stone",
                              amount: tradeItemModel.amount,
                              needCoin: tradeItemModel.price,
                              buttonCallback: () {
                                print("buy stone");
                              },
                            );
                          }),
                    ),
                  ),
                ), // stone
                Offstage(
                  offstage: contentName != 'myTrade',
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          height: ScreenUtil().setHeight(SystemButtonSize.settingsTextHeight - SystemButtonSize.largeButtonHeight),
                          child: ListView.builder(
                              padding: EdgeInsets.only(top: 0),
                              itemCount: null == myTrades ? 0 : myTrades.length,
                              itemBuilder: (BuildContext context, int index) {
                                TradeItemModel tradeItemModel = myTrades[index];
                                return MarketBidItem(
                                  name: tradeItemModel.displayname,
                                  bidType: tradeItemModel.type == 1 ? "wood" : "stone",
                                  amount: tradeItemModel.amount,
                                  needCoin: tradeItemModel.price,
                                  buttonName: "取 消",
                                  buttonCallback: () {
                                    MarketService.cancelMyMarketTrade("12344", tradeItemModel.type == 1 ? MarketTradeTypeEnum.wood : MarketTradeTypeEnum.stone, (data) {
                                      if (data) {
                                        CommonUtils.showSuccessMessage(msg: "取消订单成功");
                                      }
                                      getMyTradeList();
                                    });
                                  },
                                );
                              }),
                        ),
                        ImageButton(
                          height: ScreenUtil().setHeight(SystemButtonSize.largeButtonHeight),
                          width: ScreenUtil().setWidth(SystemButtonSize.largeButtonWidth),
                          buttonName: "返回",
                          imageUrl: "resource/images/upgradeButton.png",
                          callback: () {
                            changeDisplayContent(Resource.WOOD);
                            MarketHttpRequestEvent().emit("getWoodTradeList");
                          },
                        ),
                      ],
                    ),
                  ),
                ), // my trade
                Offstage(
                  offstage: contentName != "sellResource",
                  child: MarketAsk(
                    sellType: this.sellType,
                    viewCallback: () {
                      changeDisplayContent(this.sellType);
                    },
                  ),
                ), // sell
              ],
            ),
          ),
          Offstage(
            offstage: contentName != Resource.WOOD && contentName != Resource.STONE,
            child: ButtonsList(
              buttonWidth: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
              buttonHeight: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
              buttonBackgroundImageUrl: 'resource/images/upgradeButton.png',
              textSize: SystemFontSize.buttonTextFontSize,
              buttons: (null == myTrades || 0 == myTrades.length)
                  ? [
                      ImageTextButton(
                        buttonName: '发布订单',
                        callback: () {
                          changeDisplayContent("sellResource");
                        },
                      ),
                    ]
                  : [
                      ImageTextButton(
                        buttonName: '发布订单',
                        callback: () {
                          changeDisplayContent("sellResource");
                        },
                      ),
                      ImageTextButton(
                        buttonName: '我的订单',
                        callback: () {
                          changeDisplayContent('myTrade');
                          MarketHttpRequestEvent().emit("getMyTradeList");
                        },
                      ),
                    ],
            ),
          ), // 发布订单
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
