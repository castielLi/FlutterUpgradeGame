import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';

class ProductItem extends StatefulWidget {
  String cashAmount;
  String volumeAmount;
  VoidCallback callback;

  ProductItem({Key key, this.cashAmount, this.volumeAmount, this.callback}) : super(key: key);

  _ProductItemState createState() => new _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return new
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: new AssetImage('resource/images/marketItemBackground.png'),
          fit: BoxFit.fill,
        ),
      ),
      child:  Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(0),ScreenUtil().setHeight(30),ScreenUtil().setWidth(40),ScreenUtil().setHeight(50)),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(35)),
                    width: ScreenUtil().setWidth(180),
                    child: new Text("¥" + this.widget.cashAmount,
                        textAlign: TextAlign.center, style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: ScreenUtil().setSp(SystemFontSize.storeCashGoldTextFontSize))),
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                    child: Image(
                      image: new AssetImage("resource/images/cashGold.png"),
                      width: ScreenUtil().setWidth(120),
                      height: ScreenUtil().setHeight(120),
                      fit: BoxFit.fill,
                    ),
                  ),
                  new Container(
                    width: ScreenUtil().setWidth(130),
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(100)),
                    child: new Text(this.widget.volumeAmount,
                        textAlign: TextAlign.center, style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: ScreenUtil().setSp(SystemFontSize.storeCashGoldTextFontSize))),
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                    child: Image(
                      image: new AssetImage("resource/images/volume.png"),
                      width: ScreenUtil().setHeight(120),
                      height: ScreenUtil().setHeight(120),
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
              new ImageTextButton(
                imageUrl: "resource/images/upgradeButton.png",
                imageWidth: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
                imageHeight: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
                buttonName: "购 买",
                callback: () {
                  this.widget.callback();
                },
                textSize: ScreenUtil().setSp(SystemFontSize.storeCashGoldTextFontSize),
              )
            ],
          ))
    );


  }
}
