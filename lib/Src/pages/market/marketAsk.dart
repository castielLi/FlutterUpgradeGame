import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/widget/textField/myTextField.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/const/resource.dart';
import 'package:upgradegame/Src/pages/market/service/marketService.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '出售的' + (Resource.WOOD == this.widget.sellType ? "木材" : "石材") + '数量:',
          style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
        ),
        MyTextField(
          height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
          controller: amountController,
          inputType: TextInputType.number,
        ),
        Text(
          '需要的T币数量:',
          style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
        ),
        MyTextField(
          height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
          controller: coinController,
          inputType: TextInputType.number,
        ),
        ButtonsList(
          buttonWidth: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
          buttonHeight: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
          buttonBackgroundImageUrl: "resource/images/upgradeButton.png",
          textSize: SystemFontSize.buttonTextFontSize,
          buttons: [
            ImageTextButton(
              buttonName: '取消',
              callback: () {
                this.widget.viewCallback();
              },
            ),
            ImageTextButton(
              buttonName: '确定',
              callback: () {
                MarketService.sellResource(this.widget.sellType, double.parse(this.amountController.text), double.parse(this.coinController.text), (data) {
                  if (ConfigSetting.SUCCESS == data) {
                    CommonUtils.showSuccessMessage(msg: "订单发布成功");
                    amountController.clear();
                    coinController.clear();
                    this.widget.viewCallback();
                  }
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    coinController.dispose();
    super.dispose();
  }
}
