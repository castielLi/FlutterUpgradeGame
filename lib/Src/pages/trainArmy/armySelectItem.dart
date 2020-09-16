import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';

class ArmySelectItem extends StatefulWidget {
  double size;
  String armyIconImageUrl;
  VoidCallback callback;

  ArmySelectItem({Key key, this.size, this.armyIconImageUrl, this.callback}) : super(key: key);

  @override
  _ArmySelectItem createState() => new _ArmySelectItem();
}

class _ArmySelectItem extends State<ArmySelectItem> {
  @override
  Widget build(BuildContext context) {
    bool hideArmy = ("" == this.widget.armyIconImageUrl || null == this.widget.armyIconImageUrl);
    return GestureDetector(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image(
            image: AssetImage("resource/images/armyBaseBackground.png"),
            height: ScreenUtil().setHeight(this.widget.size),
            width: ScreenUtil().setWidth(this.widget.size),
          ),
          Offstage(
            offstage: hideArmy,
            child: Stack(
              children: [
                Image(
                  image: AssetImage("resource/images/armyBlueBackground.png"),
                  height: ScreenUtil().setHeight(this.widget.size - 30),
                  width: ScreenUtil().setWidth(this.widget.size - 30),
                ),
                Image(
                  image: AssetImage(
                    "resource/images/" + (hideArmy ? "rangeAttack" : this.widget.armyIconImageUrl) + "Icon.png",
                  ),
                  height: ScreenUtil().setHeight(this.widget.size - 30),
                  width: ScreenUtil().setWidth(this.widget.size - 30),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: this.widget.callback,
    );
  }
}
