import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '出售的' + (Resource.WOOD == this.widget.sellType ? "木材" : "石材") + '数量:',
            style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
          ),
          Container(
            height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
            padding: EdgeInsets.only(top: 5),
            child: new Card(
                child: new Container(
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(border: InputBorder.none),
                        onSubmitted: (String input) {
                          input = amountController.text;
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
                      amountController.clear();
                    },
                  ),
                ],
              ),
            )),
          ),
          Text(
            '需要的T币数量:',
            style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
          ),
          Container(
            height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
            padding: EdgeInsets.only(top: 5),
            child: new Card(
                child: new Container(
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: TextField(
                        controller: coinController,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(border: InputBorder.none),
                        onSubmitted: (String input) {
                          input = coinController.text;
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
                      coinController.clear();
                    },
                  ),
                ],
              ),
            )),
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
      ),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    coinController.dispose();
    super.dispose();
  }
}
