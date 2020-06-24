import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';

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
            '出售的' + this.widget.sellType + '数量:',
            style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
          ),
          Container(
            height: ScreenUtil().setHeight(150),
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
            height: ScreenUtil().setHeight(150),
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
