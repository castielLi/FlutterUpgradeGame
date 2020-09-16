import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class ArmyCampDetailItem extends StatefulWidget {
  String armyImageUrl;
  String armyDescription;
  VoidCallback callback;

  ArmyCampDetailItem({Key key, this.armyImageUrl, this.armyDescription, this.callback}) : super(key: key);

  _ArmyCampDetailItemState createState() => new _ArmyCampDetailItemState();
}

class _ArmyCampDetailItemState extends State<ArmyCampDetailItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: ScreenUtil().setHeight(350),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: new AssetImage(this.widget.armyImageUrl),
                height: ScreenUtil().setHeight(350),
                width: ScreenUtil().setWidth(350),
              ),
              Container(
                // color:Colors.red,
                height: ScreenUtil().setHeight(350),
                width: ScreenUtil().setWidth(350),
                child: SingleChildScrollView(
                  child: Text(
                    this.widget.armyDescription,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          child: Container(
            width: ScreenUtil().setWidth(SystemButtonSize.largeButtonWidth),
            height: ScreenUtil().setHeight(SystemButtonSize.largeButtonHeight),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('resource/images/upgradeButton.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Text(
                '返 回',
                style: CustomFontSize.defaultTextStyle(SystemFontSize.buttonTextFontSize),
              ),
            ),
          ),
          onTap: this.widget.callback,
        ),
      ],
    );
  }
}
