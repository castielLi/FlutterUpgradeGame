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

//  int coin = 0;
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
    ContributionService.buyContribution(tcoinamount, (BaseResourceModel model) {
      this.widget.HUD();
      if (model != null) {
        Provide.value<BaseUserInfoProvider>(context).buyContribution(model);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    this.contributionRate = Global.getCoinBuyContribution();
    int rateContentHeight = 350;
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
                    textSize: ScreenUtil().setSp(SystemButtonSize.smallButtonFontSize),
                    buttons: [
                      ImageTextButton(
                        buttonName: '贡献值',
                        callback: () {
                          setState(() {
                            this.hideExchangeCoinForContribution = false;
                            this.hideExchangeContributionForCoin = true;
                          });
                        },
                      ),
                      ImageTextButton(
                        buttonName: 'T币',
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
                  Offstage(
                    offstage: this.hideExchangeCoinForContribution,
                    child: Column(
                      children: <Widget>[
                        MyTextField(
                          height: ScreenUtil().setHeight(SystemScreenSize.inputDecorationHeight),
                          controller: amountController,
                          hintText: '兑换数量',
                          icon: Icon(Icons.attach_money),
                          inputType: TextInputType.number,
                          onChanged: () {
                            setState(() {
                              String amount = amountController.text;
                              if (!RegExp(r"^\d*$").hasMatch(amount)) {
                                CommonUtils.showErrorMessage(msg: "请输入正整数");
                              }
                            });
                          },
                        ),
                        Text('兑换' + this.contributionRate.toString() + '贡献值需要1T币', style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize)),
                        ImageTextButton(
                          imageUrl: "resource/images/upgradeButton.png",
                          imageWidth: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
                          imageHeight: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
                          buttonName: '确 定',
                          callback: () {
                            if (amountController.text != "") {
                              this.buyContribution(int.parse(amountController.text));
                              amountController.clear();
                            } else {
                              CommonUtils.showErrorMessage(msg: "输入有误,请重新输入");
                            }
                          },
                          textSize: ScreenUtil().setSp(SystemFontSize.settingTextFontSize),
                        ),
                      ],
                    ),
                  ),
                  Offstage(
                    offstage: this.hideExchangeContributionForCoin,
                    child: Container(
                      height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight - SystemButtonSize.smallButtonHeight),
                      child: new Center(
                        child: ListView.builder(
                            itemCount: exchangeContributionModel.datalist==null?0:exchangeContributionModel.datalist.length,
                            itemBuilder: (BuildContext context, int index) {
                              String contribution = "0";
                              String coin = "0";
                              bool isBuy = true;
                              String productId = "";
                              if (exchangeContributionModel != null && exchangeContributionModel.datalist != null) {
                                contribution = exchangeContributionModel.datalist[index].contributionamount;
                                coin = exchangeContributionModel.datalist[index].tcoinamount.toString();
                                isBuy = exchangeContributionModel.datalist[index].isbuy;
                                productId = exchangeContributionModel.datalist[index].productid;
                              }
                              return new ExchangeCoinItem(
                                contributionAmount: contribution,
                                coinAmount: coin,
                                isBuy: isBuy,
                                callback: () {
                                  ContributionService.exchangeContribution(productId, (bool response) {
                                    if (response) {
                                      CommonUtils.showSuccessMessage(msg: '兑换贡献值成功');
                                    }
                                  });
                                },
                              );
//                              return new ExchangeCoinItem(
//                                contributionAmount: "100",
//                                callback: () {},
//                                coinAmount: "5",
//                                isBuy: true,
//                              );
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight - rateContentHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "个人贡献值",
                            style: CustomFontSize.defaultTextStyle(70),
                          ),
                          Text(
                            "(每天凌晨0点更新结算)",
                            style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                          ),
                          Text(
                            this.currentContributionModel == null ? "0" : this.currentContributionModel.amount.toString(),
                            style: TextStyle(fontSize: ScreenUtil().setSp(70), color: highlight),
                          ),
                          Divider(
                            height: 1.0,
                            color: Colors.white,
                          ),
                          Text(
                            "昨日累计贡献值",
                            style: CustomFontSize.defaultTextStyle(50),
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
