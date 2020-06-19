import 'package:flutter/material.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';

class ButtonsInOneRow extends StatefulWidget {
  double width;
  double height;
  double buttonWidth;
  double buttonHeight;
  double iconWidth;
  double iconHeight;
  String buttonBackgroundImageUrl;
  double textSize;
  List<ImageTextButton> buttons;

  ButtonsInOneRow(
      {Key key,
      this.height,
      this.width,
      this.buttonWidth,
      this.buttonHeight,
      this.iconWidth,
      this.iconHeight,
      this.buttonBackgroundImageUrl,
      this.textSize,
      this.buttons})
      : super(key: key);

  _ButtonsInOneRowState createState() => new _ButtonsInOneRowState();
}

class _ButtonsInOneRowState extends State<ButtonsInOneRow> {
  @override
  Widget build(BuildContext context) {
    return buildList();
  }

  Widget buildList() {
    List<Widget> adIconList = [];
    Widget content;
    this.widget.buttons.forEach((imageTextButtonWithIcon) {
      adIconList.add(
        ImageTextButton(
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
