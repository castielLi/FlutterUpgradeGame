
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/widget/imageTextButtonWithIcon/imageTextButtonWithIcon.dart';

class ButtonsInOneRow extends StatefulWidget {
  double width;
  double height;
  double buttonWidth;
  double buttonHeight;
  double iconWidth;
  double iconHeight;
  String buttonBackgroundImageUrl;
  double textSize;
  List<ImageTextButtonWithIcon> buttons;

  ButtonsInOneRow({Key key,this.height,this.width,this.buttons
    }):super(key:key);
  _ButtonsInOneRowState createState() => new _ButtonsInOneRowState();
}

class _ButtonsInOneRowState extends State<ButtonsInOneRow> {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(this.widget.height),
      width: ScreenUtil().setWidth(this.widget.width),
      child: buildList(),
    );
  }

  Widget buildList(){
    List <Widget> adIconList = [];
    Widget content;
    this.widget.buttons.forEach((imageTextButtonWithIcon) {
        adIconList.add(
          ImageTextButtonWithIcon(
            imageUrl: this.widget.buttonBackgroundImageUrl,
            imageHeight: this.widget.buttonHeight,
            imageWidth: this.widget.buttonWidth,
            iconUrl: imageTextButtonWithIcon.iconUrl,
            iconHeight: this.widget.iconHeight,
            iconWidth: this.widget.iconWidth,
            buttonName: imageTextButtonWithIcon.buttonName,
            textSize: this.widget.textSize,
            callback: imageTextButtonWithIcon.callback,
          ),

        );
    });
    content = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: adIconList,
    );
    return content;
  }
}