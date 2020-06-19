import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';

class MarketAsk extends StatefulWidget {
  String sellType;

  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  MarketAsk({Key key, this.HUD, this.viewCallback, this.sellType})
      : super(key: key);

  _MarketAskState createState() => new _MarketAskState();
}

class _MarketAskState extends State<MarketAsk> {
  final amountController = TextEditingController();
  final coinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          TextField(
            controller: amountController,
            decoration: InputDecoration(
                hintText: '出售的' + this.widget.sellType + '数量',
                border: InputBorder.none),
            onSubmitted: (String input) {
              print(amountController.text);
            },
          ),
          TextField(
            controller: coinController,
            decoration:
                InputDecoration(hintText: '需要的T币数量', border: InputBorder.none),
            onSubmitted: (String input) {
              print(coinController.text);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ImageButton(
                height: ScreenUtil().setHeight(150),
                width: ScreenUtil().setWidth(300),
                buttonName: "取消",
                imageUrl: "resource/images/upgradeButton.png",
                callback: () {
                  setState(() {
                    this.widget.viewCallback();
                  });
                },
              ),
              ImageButton(
                height: ScreenUtil().setHeight(150),
                width: ScreenUtil().setWidth(300),
                buttonName: "确定",
                imageUrl: "resource/images/upgradeButton.png",
                callback: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
