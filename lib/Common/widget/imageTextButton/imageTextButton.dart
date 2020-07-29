import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class ImageTextButton extends StatefulWidget {
  String buttonName;
  String imageUrl;
  VoidCallback callback;
  double imageHeight;
  double imageWidth;
  double textSize;
  String iconUrl;
  double iconHeight;
  double iconWidth;

  ImageTextButton({Key key, this.buttonName = "", this.imageUrl, this.callback, this.imageWidth, this.imageHeight, this.iconHeight, this.iconWidth, this.iconUrl, this.textSize = 0}) : super(key: key);

  _ImageTextButtonState createState() => new _ImageTextButtonState();
}

class _ImageTextButtonState extends State<ImageTextButton> {
  @override
  Widget build(BuildContext context) {
    if (this.widget.textSize == 0) {
      this.widget.textSize = SystemFontSize.buttonTextFontSize;
    }
    return new GestureDetector(
      child: new Container(
        height: this.widget.imageHeight,
        width: this.widget.imageWidth,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(this.widget.imageUrl), fit: BoxFit.fill),
        ),
        child: (null == this.widget.iconUrl || "" == this.widget.iconUrl)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(this.widget.buttonName, style: TextStyle(fontSize: ScreenUtil().setSp(this.widget.textSize), color: Colors.white, decoration: TextDecoration.none)),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: new AssetImage(this.widget.iconUrl),
                    height: ScreenUtil().setHeight(this.widget.iconHeight),
                    width: ScreenUtil().setWidth(this.widget.iconWidth),
                  ),
                  Text(this.widget.buttonName, style: TextStyle(fontSize: ScreenUtil().setSp(this.widget.textSize), color: Colors.white, decoration: TextDecoration.none)),
                ],
              ),
      ),
      onTap: () {
        this.widget.callback();
      },
    );
  }
}
