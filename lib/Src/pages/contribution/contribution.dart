import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/widget/textField/myTextField.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/baseResourceModel.dart';
import 'package:upgradegame/Src/pages/contribution/event/contributionEventBus.dart';
import 'package:upgradegame/Src/pages/contribution/model/myContributionModel.dart';
import 'package:upgradegame/Src/pages/contribution/service/contributionService.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';

class ContributionDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  ContributionDetail({Key key, this.HUD}) : super(key: key);

  _ContributionDetailState createState() => new _ContributionDetailState();
}

class _ContributionDetailState extends State<ContributionDetail> {
  final amountController = TextEditingController();
  String tabName = "showContribution";
  int coin = 0;
  MyContributionModel currentContributionModel;
  Color highlight = Colors.red;

  @override
  void initState() {
    super.initState();
    ContributionHttpRequestEvent().on("getMyContribution", this.getMyContribution);
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

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    ContributionHttpRequestEvent().off();
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
    return new Container(
      child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
        return Container(
          margin: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(100), // 左
              ScreenUtil().setHeight(400), // 上
              ScreenUtil().setWidth(100), // 右
              ScreenUtil().setHeight(200)), // 下
          child: Column(
            children: [
              ButtonsList(
                buttonWidth: ScreenUtil().setWidth(SystemButtonSize.smallButtonWidth),
                buttonHeight: ScreenUtil().setHeight(SystemButtonSize.smallButtonHeight),
                buttonBackgroundImageUrl: 'resource/images/yellowButton.png',
                textSize: SystemFontSize.smallButtonWithIconFontSize,
                buttons: [
                  ImageTextButton(
                    buttonName: '分红',
                    callback: () {
                      changeTab("showContribution");
                      ContributionHttpRequestEvent().emit("getMyContribution");
                    },
                  ),
                  ImageTextButton(
                    buttonName: '购买',
                    callback: () {
                      changeTab("buyContribution");
                    },
                  ),
                ],
              ),
              Offstage(
                offstage: "buyContribution" != this.tabName,
                child: Column(
                  children: <Widget>[
                    MyTextField(
                      height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
                      controller: amountController,
                      hintText: '购买数量',
                      icon: Icon(Icons.attach_money),
                      onChanged: () {
                        setState(() {
                          //TODO 兑换贡献值规则
                          String amount = amountController.text;
                          if (!RegExp(r"^\d*$").hasMatch(amount)) {
                            CommonUtils.showErrorMessage(msg: "请输入正整数");
                            this.coin = 0;
                          }
                          this.coin = int.parse(amount);
                        });
                      },
                    ),
                    Text('价格:' + this.coin.toString() + 'T币', style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize)),
                    ImageTextButton(
                      imageUrl: "resource/images/upgradeButton.png",
                      imageWidth: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
                      imageHeight: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
                      buttonName: '确 定',
                      callback: () {
                        this.buyContribution(int.parse(amountController.text));
                        amountController.clear();
                      },
                      textSize: SystemFontSize.settingTextFontSize,
                    ),
                  ],
                ),
              ),
              Offstage(
                offstage: "showContribution" != this.tabName,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "个人贡献值",
                            style: CustomFontSize.defaultTextStyle(70),
                          ),
                          Text(
                            "(每天中午12点更新结算)",
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: ScreenUtil().setWidth(250),
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
                                width: ScreenUtil().setWidth(250),
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
                                width: ScreenUtil().setWidth(250),
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
                        ],
                      ),
                    ),
                    Divider(
                      height: 1.0,
                      color: Colors.white,
                    ),
                    Container(
                      height: ScreenUtil().setHeight(450),
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 0),
                          itemCount: this.currentContributionModel == null ? 0 : this.currentContributionModel.conditions.length,
                          itemBuilder: (BuildContext context, int index) {
                            Conditions condition = this.currentContributionModel.conditions[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            ],
          ),
        );
      }),
    );
  }

  void changeTab(String tabName) {
    setState(() {
      this.tabName = tabName;
    });
  }
}
