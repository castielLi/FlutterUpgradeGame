import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/widget/textField/myTextField.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/const/resource.dart';
import 'package:upgradegame/Src/common/model/user.dart';
import 'package:upgradegame/Src/pages/market/event/marketEventBus.dart';
import 'package:upgradegame/Src/pages/market/marketAsk.dart';
import 'package:upgradegame/Src/pages/market/marketBidItem.dart';
import 'package:upgradegame/Src/pages/market/model/tradeListModel.dart';
import 'package:upgradegame/Src/pages/market/service/marketService.dart';
import 'package:upgradegame/Src/pages/market/userSearchResult.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';

import 'model/tradeItemModel.dart';

class MarketDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  MarketDetail({Key key, this.HUD}) : super(key: key);

  _MarketDetailState createState() => new _MarketDetailState();
}

class _MarketDetailState extends State<MarketDetail> {
  User searchedUser;
  bool showResult = false;
  final phoneController = TextEditingController();

  int RequestHttpWood = 1;
  int RequestHttpStone = 2;

  TradeListModel woodList = new TradeListModel(datalist: []);
  TradeListModel stoneList = new TradeListModel(datalist: []);
  List<TradeItemModel> myTrades = [];
  String contentName = Resource.WOOD;
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
    bool flag = false;
    MarketService.getMyMarketTrade((model) {
      if (model != null) {
        setState(() {
          myTrades = model.datalist;
        });
        flag = true;
      }
    });
    return flag;
  }

  void getWoodTradeList() {
    this.widget.HUD();
    MarketService.getMarketTradeByType(this.woodPage, this.RequestHttpWood, (TradeListModel model) {
      print("请求page:" + this.woodPage.toString() + ", type: wood");
      if (model != null) {
        woodList.total = model.total;
        woodList.page = model.page;
        if (model.page == 0) {
          woodList.datalist = [];
        }
        if (model.datalist.length == 0) {
          CommonUtils.showErrorMessage(msg: "没有更多了");
        }
        woodList.datalist += model.datalist;
      }
      this.widget.HUD();
    });
  }

  ///获取石材的市场订单情况
  Future<bool> getStoneTradeList() async {
    bool flag = false;
    this.widget.HUD();
    MarketService.getMarketTradeByType(this.stonePage, this.RequestHttpStone, (TradeListModel model) {
      print("请求page:" + this.stonePage.toString() + ", type: stone");
      this.widget.HUD();
      if (model != null) {
        stoneList.total = model.total;
        stoneList.page = model.page;
        if (model.page == 0) {
          stoneList.datalist = [];
        }
        if (model.datalist.length == 0) {
          CommonUtils.showErrorMessage(msg: "没有更多了");
        }
        stoneList.datalist += model.datalist;
        flag = true;
      }
    });
    return flag;
  }

  void changeDisplayContent(String tab) {
    setState(() {
      contentName = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
        return Container(
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
                      this.woodPage = 0;
                      changeDisplayContent(Resource.WOOD);
                      MarketHttpRequestEvent().emit("getWoodTradeList");
                    },
                  ),
                  ImageTextButton(
                    buttonName: '石材',
                    iconUrl: 'resource/images/stone.png',
                    callback: () {
                      this.sellType = "stone";
                      this.stonePage = 0;
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
                            controller: phoneController,
                            inputType: TextInputType.number,
                            hintText: '输入用户手机号搜索',
                            icon: Icon(Icons.search),
                            onSubmittedCallback: () {
                              String phone = phoneController.text;
                              if (!RegExp(r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$").hasMatch(phone)) {
                                CommonUtils.showErrorMessage(msg: "请输入正确的手机号码");
                                return;
                              }
                              MarketService.searchUser(phone, (data) {
                                if (null != data) {
                                  setState(() {
                                    this.searchedUser = User.fromSearchJson(data);
                                    this.searchedUser.phone = phone;
                                    this.showResult = true;
                                  });
                                }
                              });
                            },
                          ),
                          Container(
                            height: ScreenUtil().setHeight(SystemButtonSize.settingsTextHeight - SystemButtonSize.inputDecorationHeight),
                            child: UserSearchResult(
                              user: this.searchedUser,
                              showResult: this.showResult,
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
                              this.woodPage++;
                              getWoodTradeList();
                            });
                          },
                          // ignore: missing_return
                          onRefresh: () {
                            setState(() {
                              this.woodPage = 0;
                              getWoodTradeList();
                            });
                          },
                          child: ListView.builder(
                              padding: EdgeInsets.only(top: 0),
                              itemCount: null == this.woodList ? 0 : this.woodList.datalist.length,
                              itemBuilder: (BuildContext context, int index) {
                                TradeItemModel tradeItemModel = this.woodList.datalist[index];
                                print("wood count:" + this.woodList.datalist.length.toString());
                                return MarketBidItem(
                                  buttonName: "购 买",
                                  name: tradeItemModel.displayname,
                                  bidType: "wood",
                                  myTrade: tradeItemModel.mytrade,
                                  amount: tradeItemModel.amount,
                                  needCoin: tradeItemModel.price,
                                  buttonCallback: () {
                                    MarketService.marketBuy(tradeItemModel.productid, (bool success) {
                                      if (success) {
                                        ///wood = 1 stone = 2
                                        baseUserInfo.buyResource(1, tradeItemModel.amount, tradeItemModel.price);
                                        setState(() {
                                          for (int i = 0; i < this.woodList.datalist.length; i++) {
                                            if (tradeItemModel.productid == this.woodList.datalist[i].productid) {
                                              this.woodList.datalist.removeAt(i);
                                              return;
                                            }
                                          }
                                        });
                                      }
                                    });
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
                              this.stonePage++;
                              getStoneTradeList();
                            });
                          },
                          // ignore: missing_return
                          onRefresh: () {
                            setState(() {
                              this.woodPage = 0;
                              getStoneTradeList();
                            });
                          },
                          child: ListView.builder(
                              padding: EdgeInsets.only(top: 0),
                              itemCount: null == this.stoneList ? 0 : this.stoneList.datalist.length,
                              itemBuilder: (BuildContext context, int index) {
                                TradeItemModel tradeItemModel = this.stoneList.datalist[index];
                                print("stone count:" + this.stoneList.datalist.length.toString());
                                return MarketBidItem(
                                  buttonName: "购 买",
                                  name: tradeItemModel.displayname,
                                  bidType: "stone",
                                  myTrade: tradeItemModel.mytrade,
                                  amount: tradeItemModel.amount,
                                  needCoin: tradeItemModel.price,
                                  buttonCallback: () {
                                    MarketService.marketBuy(tradeItemModel.productid, (bool success) {
                                      if (success) {
                                        ///wood = 1 stone = 2
                                        baseUserInfo.buyResource(2, tradeItemModel.amount, tradeItemModel.price);
                                        setState(() {
                                          for (int i = 0; i < this.stoneList.datalist.length; i++) {
                                            if (tradeItemModel.productid == this.stoneList.datalist[i].productid) {
                                              this.stoneList.datalist.removeAt(i);
                                              return;
                                            }
                                          }
                                        });
                                      }
                                    });
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
                                        MarketService.cancelMyMarketTrade(tradeItemModel.productid, tradeItemModel.type, (data) {
                                          if (data) {
                                            CommonUtils.showSuccessMessage(msg: "取消订单成功");
                                            baseUserInfo.cancelBid(tradeItemModel.type, tradeItemModel.amount);
                                            getMyTradeList();
                                          }
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
      }),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
