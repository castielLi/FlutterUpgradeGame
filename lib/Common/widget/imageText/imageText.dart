
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class ImageText extends StatefulWidget {
  @override
  String text;
  String imageUrl;
  double imageHeight;
  double imageWidth;
  double textSize;
  ImageText({Key key,this.text = "",this.imageUrl,this.imageWidth,this.imageHeight,
    this.textSize = 0}):super(key:key);
  _ImageTextState createState() => new _ImageTextState();
}

class _ImageTextState extends State<ImageText> {

  @override
  Widget build(BuildContext context) {
    if(this.widget.textSize == 0){
      this.widget.textSize = SystemFontSize.buttonTextFontSize;
    }
    return new Container(
      height: this.widget.imageHeight,
      width: this.widget.imageWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(this.widget.imageUrl),
            fit: BoxFit.fill),
      ),
      child: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(this.widget.text,textAlign: TextAlign.center
                ,style:  TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: ScreenUtil().setSp(this.widget.textSize*3)),),
            ],
          )
      ),
    );
  }
}