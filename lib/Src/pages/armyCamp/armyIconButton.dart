import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArmyIconButton extends StatefulWidget {
  bool isChosen;
  String armyIconImageUrl;
  double size;
  VoidCallback callback;

  ArmyIconButton({Key key, this.isChosen, this.armyIconImageUrl, this.size, this.callback}) : super(key: key);

  _ArmyIconButtonState createState() => new _ArmyIconButtonState();
}

class _ArmyIconButtonState extends State<ArmyIconButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image(
            image: AssetImage("resource/images/army" + (this.widget.isChosen ? "Red" : "Blue").toString() + "Background.png"),
            height: ScreenUtil().setHeight(this.widget.size),
            width: ScreenUtil().setWidth(this.widget.size),
          ),
          Image(
            image: AssetImage(this.widget.armyIconImageUrl),
            height: ScreenUtil().setHeight(this.widget.size),
            width: ScreenUtil().setWidth(this.widget.size),
          ),
        ],
      ),
      onTap: this.widget.callback,
    );
  }
}
