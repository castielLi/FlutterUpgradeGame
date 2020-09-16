import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class ArmyCampItem extends StatefulWidget {
  String armyImageUrl;
  String armyDescription;
  String armyPrice;

  ArmyCampItem({Key key, this.armyImageUrl, this.armyDescription, this.armyPrice}) : super(key: key);

  _ArmyCampItemState createState() => new _ArmyCampItemState();
}

class _ArmyCampItemState extends State<ArmyCampItem> {
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
        Container(
          height: ScreenUtil().setHeight(150),
          width: ScreenUtil().setHeight(700),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('所需金币'),
              Row(
                children: [
                  Image(
                    image: new AssetImage("resource/images/coin.png"),
                    width: ScreenUtil().setWidth(SystemIconSize.mainPageResourceBarIconSize),
                    height: ScreenUtil().setWidth(SystemIconSize.mainPageResourceBarIconSize),
                    fit: BoxFit.fill,
                  ),
                  Text(this.widget.armyPrice),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          child: Container(
            width: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
            height: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('resource/images/upgradeButton.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Text(
                '购 买',
                style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
              ),
            ),
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
