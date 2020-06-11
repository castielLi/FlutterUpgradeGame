
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class ImageTextButton extends StatefulWidget {
  @override
  String buttonName;
  String imageUrl;
  VoidCallback callback;
  double imageHeight;
  double imageWidth;
  double textSize;
  ImageTextButton({Key key,this.buttonName = "",this.imageUrl,this.callback,this.imageWidth,this.imageHeight,
    this.textSize = 0}):super(key:key);
  _ImageTextButtonState createState() => new _ImageTextButtonState();
}

class _ImageTextButtonState extends State<ImageTextButton> {

  @override
  Widget build(BuildContext context) {
    if(this.widget.textSize == 0){
      this.widget.textSize = SystemFontSize.buttonTextFontSize;
    }
    return new Container(
      height: this.widget.imageHeight,
      width: this.widget.imageWidth,
      child: new  GestureDetector(
        child: Container(
          margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(this.widget.imageUrl),
                fit: BoxFit.fill),
          ),
          child: Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(this.widget.buttonName,textAlign: TextAlign.center
                    ,style:  TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: ScreenUtil().setSp(this.widget.textSize)),),
                ],
              )
          ),
        ),
        onTap: (){
          this.widget.callback();
        },
      ),
    );
  }
}