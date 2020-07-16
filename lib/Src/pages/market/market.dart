import 'package:flutter/material.dart';
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
import 'package:upgradegame/Src/pages/market/marketBid.dart';
import 'package:upgradegame/Src/pages/market/model/tradeListModel.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MarketHttpRequestEvent().on("getMyTradeList", this.getMyTradeList);
    MarketHttpRequestEvent().on("getWoodTradeList", this.getWoodTradeList);
    MarketHttpRequestEvent().on("getStoneTradeList", this.getStoneTradeList);
    ///默认会显示木材的市场，所以第一次进界面的时候需要请求木材和我的发布订单两个http
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      Future.wait([this.getMyTradeList(),this.getStoneTradeList()]).then((List array){
        this.widget.HUD();
        if(this.judgeAllRequestSuccess(array)){
          CommonUtils.showErrorMessage(msg: "请求市场数据出错，请关闭界面重新获取");
        }
      });
    });
  }

  ///判断当前的请求都请求成功
  bool judgeAllRequestSuccess(List array){
    for(int i = 0; i<array.length;i++){
      if(!array[i]){
        return false;
      }
    }
    return true;
  }

  /// 获取我所发布的市场订单
  Future<bool> getMyTradeList() async{
    MarketService.getMyMarketTrade((model){
      if(model!=null){
        print(model);
        return true;
      }else{
        return false;
      }
    });
  }
  
  void getWoodTradeList(){
    this.widget.HUD();
    MarketService.getMarketTradeByType(1,MarketTradeTypeEnum.wood,(TradeListModel model){
      if(model!=null){
        print(model);
      }else{

      }
      this.widget.HUD();
    });
  }

  ///获取石材的市场订单情况
  Future<bool> getStoneTradeList() async{
    MarketService.getMarketTradeByType(1,MarketTradeTypeEnum.stone,(TradeListModel model){
      if(model!=null){
        print(model);
        return true;
      }else{
        return false;
      }
    });
  }

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
                        MarketHttpRequestEvent().emit("getWoodTradeList");
                      },
                    ),
                    ImageTextButton(
                      buttonName: '石材',
                      iconUrl: 'resource/images/stone.png',
                      callback: () {
                        changeTabs(Resource.STONE);
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
                        offstage: tabName != Resource.COIN,
                        child: Scaffold(
                          resizeToAvoidBottomInset: false,
                          backgroundColor: Colors.transparent,
                          body: Column(
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
                                        userSearchResultHide = false;
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
