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
import 'package:upgradegame/Src/common/model/userSearch.dart';
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
  UserSearch searchedUser;
  String noResultHintText = '';
  String noOrderHintText = '';
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
  double woodListOffset = 0;
  double stoneListOffset = 0;
  ScrollController woodController = new ScrollController();
  ScrollController stoneController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MarketHttpRequestEvent().on("getMyTradeList", this.getMyTradeList);
    MarketHttpRequestEvent().on("getWoodTradeList", this.getWoodList);
    MarketHttpRequestEvent().on("getStoneTradeList", this.getStoneTradeList);

    ///默认会显示木材的市场，所以第一次进界面的时候需要请求石材和我的发布订单两个http
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      Future.wait([this.getMyTradeList(), this.getWoodTradeList()]).then((List array) {
        this.widget.HUD();
        if (!this.judgeAllRequestSuccess(array)) {
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
    await MarketService.getMyMarketTrade((model) {
      if (model != null) {
        setState(() {
          myTrades = model.datalist;
        });
        flag = true;
      } else {
        flag = false;
      }
    });
    return flag;
  }

  void getWoodList() {
    this.widget.HUD();
    MarketService.getMarketTradeByType(this.woodPage, this.RequestHttpWood, (TradeListModel model) {
      this.widget.HUD();
      if (model != null) {
        woodList.total = model.total;
        woodList.page = model.page;
        if (model.page == 0) {
          if(model.datalist.length > 0){
            setState(() {
              woodList.datalist = model.datalist;
            });
            this.woodListOffset = 0;
          }else{
            this.noOrderHintText = '目前没有订单';
          }
        }else{
          if(model.datalist.length > 0){
            setState(() {
              woodList.datalist += model.datalist;
            });
            WidgetsBinding.instance.addPostFrameCallback((mag) {
              this.woodController.jumpTo(this.woodListOffset);
            });
          }else{
            CommonUtils.showErrorMessage(msg: "没有更多了");
            this.woodPage -= 1;
            WidgetsBinding.instance.addPostFrameCallback((mag) {
              this.woodController.jumpTo(this.woodListOffset);
            });
          }
        }
      }
    });
  }

  Future<bool> getWoodTradeList() async {
    bool flag = false;
    await MarketService.getMarketTradeByType(this.woodPage, this.RequestHttpWood, (TradeListModel model) {
      if (model != null) {
        woodList.total = model.total;
        woodList.page = model.page;
        if (model.page == 0) {
          if(model.datalist.length > 0){
            setState(() {
              woodList.datalist = model.datalist;
            });
            this.woodListOffset = 0;
          }else{
            this.noOrderHintText = '目前没有订单';
          }
        }else{
          if(model.datalist.length > 0){
            setState(() {
              woodList.datalist += model.datalist;
            });
          }else{
            CommonUtils.showErrorMessage(msg: "没有更多了");
          }
        }
        flag = true;
      }
      else {
        flag = false;
      }

    });
    return flag;
  }

  ///获取石材的市场订单情况
  void getStoneTradeList(){
    this.widget.HUD();
    MarketService.getMarketTradeByType(this.stonePage, this.RequestHttpStone, (TradeListModel model) {
      this.widget.HUD();
      if (model != null) {
        stoneList.total = model.total;
        stoneList.page = model.page;
        if (model.page == 0) {
          if(model.datalist.length > 0){
            setState(() {
              stoneList.datalist = model.datalist;
            });
          }else{
            this.noOrderHintText = '目前没有订单';
          }
          this.stoneListOffset = 0;
        }else{
          if(model.datalist.length == 0){
            CommonUtils.showErrorMessage(msg: "没有更多了");
            this.stonePage -=1;
            WidgetsBinding.instance.addPostFrameCallback((mag) {
              this.stoneController.jumpTo(this.stoneListOffset);
            });
          }else{
            setState(() {
              stoneList.datalist += model.datalist;
            });
            WidgetsBinding.instance.addPostFrameCallback((mag) {
              this.stoneController.jumpTo(this.stoneListOffset);
            });
          }
        }
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
    return Container(
      child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
        return Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(SystemScreenSize.detailDialogTop),
              ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(SystemScreenSize.detailDialogBottom)),
          child: Column(
            children: <Widget>[
              ButtonsList(
                buttonWidth: ScreenUtil().setWidth(SystemButtonSize.smallButtonWidth),
                buttonHeight: ScreenUtil().setHeight(SystemButtonSize.smallButtonHeight),
                iconWidth: ScreenUtil().setWidth(SystemIconSize.smallIconSize),
                iconHeight: ScreenUtil().setHeight(SystemIconSize.smallIconSize),
                buttonBackgroundImageUrl: 'resource/images/yellowButton.png',
                textSize: ScreenUtil().setSp(SystemButtonSize.smallButtonFontSize),
                buttons: [
                  ImageTextButton(
                    buttonName: '金币',
                    iconUrl: 'resource/images/coin.png',
                    callback: () {
                      changeDisplayContent(Resource.COIN);
                      FocusScope.of(context).requestFocus(FocusNode());
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
                      FocusScope.of(context).requestFocus(FocusNode());
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
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight),
                child: Stack(
                  children: <Widget>[
                    Offstage(
                      offstage: contentName != Resource.COIN,
                      child: Column(
                        children: [
                          MyTextField(
                            height: ScreenUtil().setHeight(SystemScreenSize.inputDecorationHeight),
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
                                setState(() {
                                  this.noResultHintText = '没有搜索到用户';
                                  this.searchedUser = null;
                                  if (null != data) {
                                    this.searchedUser = UserSearch.fromJson(data);
                                    this.searchedUser.phone = phone;
                                  }
                                });
                              });
                            },
                          ),
                          Container(
                            height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight - SystemScreenSize.inputDecorationHeight - 50),
                            child: UserSearchResult(
                              user: this.searchedUser,
                              noUserHintText: this.noResultHintText,
                              HUD: this.widget.HUD,
                            ),
                          ),
                        ],
                      ),
                    ), // coin
                    Offstage(
                      offstage: contentName != Resource.WOOD,
                      child: Container(
                        height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight),
                        child: this.woodList.datalist.length == 0
                            ? Text(
                                this.noOrderHintText,
                                textAlign: TextAlign.center,
                                style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                              )
                            : EasyRefresh(
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
                                  this.woodPage +=1;
                                  this.woodListOffset = this.woodController.offset;
                                  getWoodList();
                                },
                                // ignore: missing_return
                                onRefresh: () {
                                  this.woodPage = 0;
                                  getWoodList();
                                },
                                child: ListView.builder(
                                    padding: EdgeInsets.only(top: 0),
                                    itemCount: this.woodList.datalist.length,
                                    controller: this.woodController,
                                    itemBuilder: (BuildContext context, int index) {
                                      TradeItemModel tradeItemModel = this.woodList.datalist[index];
                                      return MarketBidItem(
                                        buttonName: "购 买",
                                        name: tradeItemModel.mytrade ? "我" : tradeItemModel.displayname,
                                        bidType: "wood",
                                        myTrade: tradeItemModel.mytrade,
                                        amount: tradeItemModel.amount,
                                        needCoin: tradeItemModel.price,
                                        buttonCallback: () {
                                          if (tradeItemModel.price > baseUserInfo.tcoinamount) {
                                            CommonUtils.showErrorMessage(msg: "您当前的金币数量不足");
                                            return;
                                          }
                                          showDialog<Null>(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return new AlertDialog(
                                                title: new Text('您确认购买木材么?'),
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
                                                      this.widget.HUD();
                                                      MarketService.marketBuy(tradeItemModel.productid, (bool success) {
                                                        this.widget.HUD();
                                                        if (success) {
                                                          ///wood = 1 stone = 2
                                                          CommonUtils.showSuccessMessage(msg: "购买成功");
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
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          ).then((val) {
                                            print(val);
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
                        height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight),
                        child: this.stoneList.datalist.length == 0
                            ? Text(
                                '目前没有订单',
                                textAlign: TextAlign.center,
                                style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                              )
                            : EasyRefresh(
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
                                  this.stonePage += 1;
                                  this.stoneListOffset = this.stoneController.offset;
                                  getStoneTradeList();
//                                  double offset = this.stoneController.offset;
//                                  print(offset);
//                                  var getData = ()async{
//                                    this.stonePage++;
//                                    await getStoneTradeList();
//                                    this.stoneController.jumpTo(offset);
//                                    print(this.stoneController.offset);
//                                  };
//                                  setState(() {
//                                    getData();
//                                  });
                                },
                                // ignore: missing_return
                                onRefresh: () {
                                  setState(() {
                                    this.stonePage = 0;
                                    getStoneTradeList();
                                  });
                                },
                                child: ListView.builder(
                                    padding: EdgeInsets.only(top: 0),
                                    itemCount: this.stoneList.datalist.length,
                                    controller: this.stoneController,
                                    itemBuilder: (BuildContext context, int index) {
                                      TradeItemModel tradeItemModel = this.stoneList.datalist[index];
                                      return MarketBidItem(
                                        buttonName: "购 买",
                                        name: tradeItemModel.mytrade ? "我" : tradeItemModel.displayname,
                                        bidType: "stone",
                                        myTrade: tradeItemModel.mytrade,
                                        amount: tradeItemModel.amount,
                                        needCoin: tradeItemModel.price,
                                        buttonCallback: () {
                                          if (tradeItemModel.price > baseUserInfo.tcoinamount) {
                                            CommonUtils.showErrorMessage(msg: "您当前的金币数量不足");
                                            return;
                                          }

                                          showDialog<Null>(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return new AlertDialog(
                                                title: new Text('您确认购买石材么?'),
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
                                                      this.widget.HUD();
                                                      MarketService.marketBuy(tradeItemModel.productid, (bool success) {
                                                        this.widget.HUD();
                                                        if (success) {
                                                          CommonUtils.showSuccessMessage(msg: "购买成功");

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
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          ).then((val) {
                                            print(val);
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
                              height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight - SystemButtonSize.largeButtonHeight),
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
                                        showDialog<Null>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return new AlertDialog(
                                              title: new Text('您确定取消订单么?'),
                                              actions: <Widget>[
                                                new FlatButton(
                                                  child: new Text('返回'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                new FlatButton(
                                                  child: new Text('确定'),
                                                  onPressed: () {
                                                    this.widget.HUD();
                                                    MarketService.cancelMyMarketTrade(tradeItemModel.productid, tradeItemModel.type, (data) {
                                                      this.widget.HUD();
                                                      if (data) {
                                                        CommonUtils.showSuccessMessage(msg: "取消订单成功");
                                                        baseUserInfo.cancelBid(tradeItemModel.type, tradeItemModel.amount);
                                                        getMyTradeList();
                                                      }
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        ).then((val) {
                                          print(val);
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
                  textSize: ScreenUtil().setSp(SystemFontSize.buttonTextFontSize),
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
