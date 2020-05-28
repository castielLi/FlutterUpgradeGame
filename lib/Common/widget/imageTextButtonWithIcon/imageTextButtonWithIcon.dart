import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class ImageTextButtonWithIcon extends StatefulWidget {
  @override
  String buttonName;
  String imageUrl;
  VoidCallback callback;
  double imageHeight;
  double imageWidth;
  String iconUrl;
  double iconHeight;
  double iconWidth;
  double textSize;
  ImageTextButtonWithIcon({Key key,this.buttonName='',this.imageUrl,this.callback,this.imageWidth,this.imageHeight,
    this.textSize = 0,this.iconHeight,this.iconWidth,this.iconUrl}):super(key:key);
  _ImageTextButtonWithIconState createState() => new _ImageTextButtonWithIconState();
}

class _ImageTextButtonWithIconState extends State<ImageTextButtonWithIcon> {

  @override
  Widget build(BuildContext context) {
    if(this.widget.textSize == 0){
      this.widget.textSize = SystemFontSize.buttonTextFontSize;
    }
    return new Container(
      height: ScreenUtil().setHeight(this.widget.imageHeight),
      width: ScreenUtil().setWidth(this.widget.imageWidth),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(this.widget.imageUrl),
            fit: BoxFit.fill),
      ),
      child: new  GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: new AssetImage(this.widget.iconUrl),height: ScreenUtil().setHeight(this.widget.iconHeight),width: ScreenUtil().setWidth(this.widget.iconWidth),),
            Text(this.widget.buttonName,style: TextStyle(fontSize: this.widget.textSize, color: Colors.white, decoration: TextDecoration.none)),
          ],
        ),
        onTap: (){
          this.widget.callback();
        },
      ),
    );
  }
}