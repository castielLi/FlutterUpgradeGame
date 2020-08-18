import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/widget/textField/myTextField.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/const/resource.dart';
import 'package:upgradegame/Src/pages/market/service/marketService.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';

import 'event/marketEventBus.dart';

class MarketAsk extends StatefulWidget {
  String sellType;

  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  MarketAsk({Key key, this.HUD, this.viewCallback, this.sellType}) : super(key: key);

  _MarketAskState createState() => new _MarketAskState();
}

class _MarketAskState extends State<MarketAsk> {
  final amountController = TextEditingController();
  final coinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '出售的' + (Resource.WOOD == this.widget.sellType ? "木材" : "石材") + '数量:',
              style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
            ),
            MyTextField(
              height: ScreenUtil().setHeight(SystemScreenSize.inputDecorationHeight),
              controller: amountController,
              inputType: TextInputType.number,
            ),
            Text(
              '需要的金币数量:',
              style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
            ),
            MyTextField(
              height: ScreenUtil().setHeight(SystemScreenSize.inputDecorationHeight),
              controller: coinController,
              inputType: TextInputType.number,
            ),
            ButtonsList(
              buttonWidth: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
              buttonHeight: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
              buttonBackgroundImageUrl: "resource/images/upgradeButton.png",
              textSize: ScreenUtil().setSp(SystemFontSize.buttonTextFontSize),
              buttons: [
                ImageTextButton(
                  buttonName: '取消',
                  callback: () {
                    this.widget.viewCallback();
                    amountController.clear();
                    coinController.clear();
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
                ImageTextButton(
                  buttonName: '确定',
                  callback: () {
                    String amount = amountController.text;
                    String coin = coinController.text;
                    if ("" == amount || "" == coin) {
                      CommonUtils.showErrorMessage(msg: "输入不能为空");
                      return;
                    }
                    if (!RegExp(r"^\d*$").hasMatch(amount) || !RegExp(r"^\d*$").hasMatch(coin)) {
                      CommonUtils.showErrorMessage(msg: "请输入正整数");
                      return;
                    }
                    MarketService.sellResource(this.widget.sellType, int.parse(this.amountController.text), int.parse(this.coinController.text), (data) {
                      if (data) {
                        CommonUtils.showSuccessMessage(msg: "发布订单成功");
                        baseUserInfo.publishBid(this.widget.sellType == "wood" ? 1 : 2, int.parse(this.amountController.text));
                        this.widget.viewCallback();
                        MarketHttpRequestEvent().emit("getMyTradeList");
                        if(this.widget.sellType == "wood"){
                          MarketHttpRequestEvent().emit("getWoodTradeList");
                        }else{
                          MarketHttpRequestEvent().emit("getStoneTradeList");
                        }
                        amountController.clear();
                        coinController.clear();
                      }
                    });
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    coinController.dispose();
    super.dispose();
  }
}
