import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/widget/textField/myTextField.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/baseResourceModel.dart';
import 'package:upgradegame/Src/common/model/globalDataModel.dart';
import 'package:upgradegame/Src/pages/contribution/ExchangeCoinItem.dart';
import 'package:upgradegame/Src/pages/contribution/event/contributionEventBus.dart';
import 'package:upgradegame/Src/pages/contribution/model/myContributionModel.dart';
import 'package:upgradegame/Src/pages/contribution/service/contributionService.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';

import 'model/getChangeContributionModel.dart';

class ContributionDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  ContributionDetail({Key key, this.HUD}) : super(key: key);

  _ContributionDetailState createState() => new _ContributionDetailState();
}

class _ContributionDetailState extends State<ContributionDetail> {
  final amountController = TextEditingController();
  String tabName = "showContribution";

  MyContributionModel currentContributionModel;
  GetChangeContributionModel exchangeContributionModel;
  Color highlight = Colors.red;
  int contributionRate = 0;
  bool hideExchangeCoinForContribution = false;
  bool hideExchangeContributionForCoin = true;

  @override
  void initState() {
    super.initState();
    ContributionHttpRequestEvent().on("getMyContribution", this.getMyContribution);
    ContributionHttpRequestEvent().on("getExchangeContributionList", this.getExchangeContributionList);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.getMyContribution();
    });
  }

  void getMyContribution() {
    this.widget.HUD();
    ContributionService.getContribution((MyContributionModel model) {
      this.widget.HUD();
      if (model != null) {
        Provide.value<BaseUserInfoProvider>(context).setContribution(model.amount);
        setState(() {
          this.currentContributionModel = model;
        });
      }
    });
  }

  void getExchangeContributionList() {
    this.widget.HUD();
    ContributionService.getExchangeContributionList((GetChangeContributionModel model) {
      if (model != null) {
        setState(() {
          exchangeContributionModel = model;
        });
      }
    });
    this.widget.HUD();
  }

  void buyContribution(int tcoinamount) {
    this.widget.HUD();
    ContributionService.exchangeCoinForContribution(tcoinamount, (BaseResourceModel model) {
      this.widget.HUD();
      if (model != null) {
        int contribution = tcoinamount * Global.getCoinBuyContribution();
        Provide.value<BaseUserInfoProvider>(context).buyContribution(model, contribution);
        CommonUtils.showSuccessMessage(msg: '兑换贡献值成功');
      }
    });
  }


  void exchangeContributionForCoin(String productId){
    this.widget.HUD();
    ContributionService.exchangeContributionForCoin(productId, (BaseResourceModel model) {
      this.widget.HUD();
      if (model != null) {
        CommonUtils.showSuccessMessage(msg: "贡献值兑换金币成功");
        var array = exchangeContributionModel;
        int contribution = 0;
        for (int i = 0; i < array.datalist.length; i++) {
          if (array.datalist[i].productid == productId) {
            contribution = array.datalist[i].contributionamount;
            array.datalist.removeAt(i);
            setState(() {
              exchangeContributionModel = array;
            });
          }
        }
        Provide.value<BaseUserInfoProvider>(context).exchangeContribution(model, contribution);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    this.contributionRate = Global.getCoinBuyContribution();
    int rateContentHeight = 360;
    int rowWidth = 250;
    return new Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(SystemScreenSize.detailDialogTop),
          ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(SystemScreenSize.detailDialogBottom)),
      child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
        return Column(
          children: [
            ButtonsList(
              buttonWidth: ScreenUtil().setWidth(SystemButtonSize.largeButtonWidth),
              buttonHeight: ScreenUtil().setHeight(SystemButtonSize.largeButtonHeight),
              buttonBackgroundImageUrl: 'resource/images/teamSwitchBackground.png',
              textSize: ScreenUtil().setSp(SystemButtonSize.largeButtonFontSize),
              buttons: [
                ImageTextButton(
                  buttonName: '分红',
                  callback: () {
                    changeTab("showContribution");
                    ContributionHttpRequestEvent().emit("getMyContribution");
                    //隐藏键盘
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
                ImageTextButton(
                  buttonName: '兑换',
                  callback: () {
                    changeTab("exchange");
                    ContributionHttpRequestEvent().emit("getExchangeContributionList");
                  },
                ),
              ],
            ),
            Offstage(
              offstage: "exchange" != this.tabName,
              child: Column(
                children: <Widget>[
                  ButtonsList(
                    buttonWidth: ScreenUtil().setWidth(SystemButtonSize.smallButtonWidth),
                    buttonHeight: ScreenUtil().setHeight(SystemButtonSize.smallButtonHeight),
                    buttonBackgroundImageUrl: 'resource/images/yellowButton.png',
                    textSize: ScreenUtil().setSp(SystemButtonSize.exchangeContributionButtonFontSize),
                    buttons: [
                      ImageTextButton(
                        buttonName: '兑换贡献值',
                        callback: () {
                          setState(() {
                            this.hideExchangeCoinForContribution = false;
                            this.hideExchangeContributionForCoin = true;
                          });
                        },
                      ),
                      ImageTextButton(
                        buttonName: '兑换金币',
                        callback: () {
                          setState(() {
                            this.hideExchangeCoinForContribution = true;
                            this.hideExchangeContributionForCoin = false;
                          });
                          //隐藏键盘
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                    width: ScreenUtil().setWidth(SystemScreenSize.displayContentHeight),
                    child: Text(
                      this.hideExchangeCoinForContribution
                          ? "当前拥有: " + (this.currentContributionModel == null ? "0" : baseUserInfo.Contribution.toString()) + " 贡献值"
                          : "当前拥有: " + baseUserInfo.tcoinamount.toString() + " 金币",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: ScreenUtil().setSp(SystemFontSize.moreMoreLargerTextSize), color: Colors.white, decoration: TextDecoration.none),
                    ),
                  ),
                  Offstage(
                    offstage: this.hideExchangeCoinForContribution,
                    child: Column(
                      children: <Widget>[
                        MyTextField(
                          height: ScreenUtil().setHeight(SystemScreenSize.inputDecorationHeight),
                          controller: amountController,
                          hintText: '输入金币数量',
                          icon: Icon(Icons.attach_money),
                          inputType: TextInputType.number,
                          warningText: '每个金币可以兑换' + this.contributionRate.toString() + '贡献值',
                          warningTextFontSize: SystemFontSize.moreMoreLargerTextSize,
                          onChanged: () {
                            setState(() {
                              String amount = amountController.text;
                              if (!RegExp(r"^\d*$").hasMatch(amount)) {
                                CommonUtils.showErrorMessage(msg: "请输入正整数");
                              }
                            });
                          },
                        ),
                        ImageTextButton(
                          imageUrl: "resource/images/upgradeButton.png",
                          imageWidth: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
                          imageHeight: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
                          buttonName: '确 定',
                          callback: () {
                            String amount = amountController.text;
                            if (!RegExp(r"^\d*$").hasMatch(amount)) {
                              CommonUtils.showErrorMessage(msg: "请输入正整数");
                              return;
                            }
                            if(int.parse(amount)>baseUserInfo.tcoinamount){
                              CommonUtils.showErrorMessage(msg: "金币不足，请重新输入");
                              return;
                            }
                            showDialog<Null>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return new AlertDialog(
                                  title: new Text('您确认通过金币兑换贡献值么?'),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text('取消'),
                                      onPressed: () {
                                        amountController.clear();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    new FlatButton(
                                      child: new Text('确认'),
                                      onPressed: () {
                                        this.buyContribution(int.parse(amountController.text));
                                        amountController.clear();
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
                          textSize: ScreenUtil().setSp(SystemFontSize.settingTextFontSize),
                        ),
                      ],
                    ),
                  ),
                  Offstage(
                    offstage: this.hideExchangeContributionForCoin,
                    child: Container(
//                      color:Colors.blue,
                      height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight - SystemButtonSize.smallButtonHeight),
                      child: new Center(
                        child: ListView.builder(
                            itemCount: exchangeContributionModel == null ? 0 : exchangeContributionModel.datalist.length,
                            itemBuilder: (BuildContext context, int index) {
                              int contribution = 0;
                              int coin = 0;
                              bool isBuy = true;
                              String productId = "";
                              if (exchangeContributionModel != null && exchangeContributionModel.datalist != null) {
                                contribution = exchangeContributionModel.datalist[index].contributionamount;
                                coin = exchangeContributionModel.datalist[index].tcoinamount;
                                isBuy = exchangeContributionModel.datalist[index].isbuy;
                                productId = exchangeContributionModel.datalist[index].productid;
                              }
                              return new ExchangeCoinItem(
                                contributionAmount: contribution,
                                coinAmount: coin,
                                isBuy: isBuy,
                                callback: () {
                                  if(baseUserInfo.Contribution<contribution){
                                    CommonUtils.showErrorMessage(msg: '贡献值不足');
                                    return;
                                  }

                                  showDialog<Null>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return new AlertDialog(
                                        title: new Text('您确认通过贡献值兑换金币么?'),
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
                                              this.exchangeContributionForCoin(productId);
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
                  ),
                ],
              ),
            ),
            Offstage(
              offstage: "showContribution" != this.tabName,
              child: Container(
                height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight - rateContentHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "个人贡献值(已兑换值)",
                            style: CustomFontSize.defaultTextStyle(70),
                          ),
                          Text(
                            "(每天凌晨0点更新结算)",
                            style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                          ),
                          Text(
                            this.currentContributionModel == null ? "0(-0)" : this.currentContributionModel.amount.toString() + "(" + this.currentContributionModel.exchange.toString() + ")",
                            style: TextStyle(fontSize: ScreenUtil().setSp(70), color: highlight),
                          ),
                          Divider(
                            height: 1.0,
                            color: Colors.white,
                          ),
                          Text(
                            "每日中午12点进行分红结算(拥有英雄才能参与分红)",
                            style: CustomFontSize.defaultTextStyle(30),
                          ),
                          Text(
                            this.currentContributionModel == null ? "昨日累计贡献值(0)" : "昨日累计贡献值(" + this.currentContributionModel.yesterdayamount.toString() + ")",
                            style: CustomFontSize.defaultTextStyle(45),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: ScreenUtil().setWidth(rowWidth),
                                child: Column(
                                  children: [
                                    Text(
                                      "单价",
                                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                                    ),
                                    Text(
                                      this.currentContributionModel == null ? "0" : this.currentContributionModel.price,
                                      style: TextStyle(fontSize: ScreenUtil().setSp(SystemFontSize.moreLargerTextSize), color: highlight),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(rowWidth),
                                child: Column(
                                  children: [
                                    Text(
                                      "比例达标状态",
                                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                                    ),
                                    Text(
                                      (this.currentContributionModel == null || this.currentContributionModel.myrate <= 0) ? "未达标" : "已达标",
                                      style: TextStyle(fontSize: ScreenUtil().setSp(SystemFontSize.moreLargerTextSize), color: highlight),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(rowWidth),
                                child: Column(
                                  children: [
                                    Text(
                                      "分红比例",
                                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                                    ),
                                    Text(
                                      this.currentContributionModel == null ? "0" : this.currentContributionModel.myrate.toString() + "%",
                                      style: TextStyle(fontSize: ScreenUtil().setSp(SystemFontSize.moreLargerTextSize), color: highlight),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 1.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(rateContentHeight),
                      width: ScreenUtil().setWidth(500),
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 0),
                          itemCount: this.currentContributionModel == null ? 0 : this.currentContributionModel.conditions.length,
                          itemBuilder: (BuildContext context, int index) {
                            Conditions condition = this.currentContributionModel.conditions[this.currentContributionModel.conditions.length - 1 - index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  condition.amount.toString(),
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(SystemFontSize.moreLargerTextSize), color: this.currentContributionModel.myrate < condition.rate ? Colors.white : highlight),
                                ),
                                Text(
                                  condition.rate.toString() + '%',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(SystemFontSize.moreLargerTextSize), color: this.currentContributionModel.myrate < condition.rate ? Colors.white : highlight),
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  void changeTab(String tabName) {
    setState(() {
      this.tabName = tabName;
    });
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    ContributionHttpRequestEvent().off();
  }
}
