
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class DividendPart extends StatefulWidget {
  @override
  String imageUrl;
  double imageHeight;
  double imageWidth;
  String imageTitle;
  String title;
  String amount;
  VoidCallback callback;
  DividendPart({Key key,this.imageUrl,this.imageHeight,this.imageWidth,this.imageTitle,this.title,this.amount,this.callback}):super(key:key);
  _DividendPartState createState() => new _DividendPartState();
}

class _DividendPartState extends State<DividendPart> {

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: this.widget.callback,
      child: new Container(
        margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
        decoration: new BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.7),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: new Row(
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Image(image: new AssetImage(this.widget.imageUrl),
                  width: this.widget.imageWidth,
                  height: this.widget.imageHeight,
                  fit: BoxFit.fill,
                ),
                new Container(
                    width: this.widget.imageWidth,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(this.widget.imageTitle,textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: SystemFontSize.dividendTitleTextFontSize)),
                      ],
                    )
                )
              ],
            ),
            new Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(this.widget.title,textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: SystemFontSize.dividendContentTextFontSize)),
                  Text(this.widget.amount,textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: SystemFontSize.dividendTitleTextFontSize)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}