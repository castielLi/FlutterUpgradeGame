
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class ImageButton extends StatefulWidget {
  @override
  String buttonName;
  String imageUrl;
  VoidCallback callback;
  double width;
  double height;
  double textSize;
  ImageButton({Key key,this.buttonName = "",this.imageUrl,this.callback,this.height,this.width,
  this.textSize = 0}):super(key:key);
  _ImageButtonState createState() => new _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {

  @override
  Widget build(BuildContext context) {
    if(this.widget.textSize == 0){
      this.widget.textSize = SystemFontSize.buttonTextFontSize;
    }
    return new FlatButton(
      textColor: Colors.white,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        height: this.widget.height,
        width: this.widget.width,
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(this.widget.imageUrl),
              fit: BoxFit.fitWidth),
        ),
        child: Center(
          child: Text(this.widget.buttonName,style: TextStyle(fontSize: ScreenUtil().setSp(this.widget.textSize)),),
        ),
      ),
      /*
      排行榜，
       */
      // ),
      onPressed: () {
          this.widget.callback();
      },
    );
  }
}