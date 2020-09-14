import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';

class BuildingButton extends StatefulWidget {
  double height;
  double width;
  String imageUrl;
  String name;
  double namePadding;
  double fontSize;
  VoidCallback callback;

  BuildingButton({Key key, this.height, this.width, this.imageUrl, this.name, this.namePadding, this.callback,this.fontSize});

  @override
  _BuildingButtonState createState() => new _BuildingButtonState();
}

class _BuildingButtonState extends State<BuildingButton> {
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        ImageButton(
          height: this.widget.height,
          width: this.widget.width,
          imageUrl: this.widget.imageUrl,
          callback: () {
            this.widget.callback();
          },
        ),
        Container(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(this.widget.namePadding)),
            child: Center(
              child: Text(
                this.widget.name,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: ScreenUtil().setSp(this.widget.fontSize)),
              ),
            ))
      ],
    );
  }
}
