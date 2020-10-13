import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class HeroAltarClock extends StatefulWidget {
  String imageUrl;
  double adIconHeight;
  List<int> remainDays;
  VoidCallback callback;

  HeroAltarClock({Key key, this.remainDays, this.adIconHeight, this.imageUrl, this.callback}) : super(key: key);

  @override
  _HeroAltarClockState createState() => _HeroAltarClockState();
}

class _HeroAltarClockState extends State<HeroAltarClock> {
  Widget buildList() {
    List<Widget> clockDayList = [];
    Widget content;
    for (int i = 0; i < this.widget.remainDays.length; i++) {
      clockDayList.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                Image(image: new AssetImage(this.widget.imageUrl), height: this.widget.adIconHeight),
                Text(
                  this.widget.remainDays[i] > 31 ? "永久" : this.widget.remainDays[i].toString() + '天',
                  style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                ),
              ],
            ),
            GestureDetector(
              child: Container(
                width: ScreenUtil().setWidth(SystemButtonSize.smallButtonWidth),
                height: ScreenUtil().setHeight(SystemButtonSize.smallButtonHeight),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: new AssetImage('resource/images/upgradeButton.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: Text(
                    '分 红',
                    style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                  ),
                ),
              ),
              onTap: this.widget.callback,
            ),
          ],
        ),
      );
    }
    content = Container(
      height: ScreenUtil().setHeight(360),
      child: SingleChildScrollView(
        child: Column(
          children: clockDayList,
        ),
      ),
    );
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return buildList();
  }
}
