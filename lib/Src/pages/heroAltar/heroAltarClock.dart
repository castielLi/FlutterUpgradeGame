import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class HeroAltarClock extends StatefulWidget {
  String imageUrl;
  double adIconHeight;
  List<int> remainDays;

  HeroAltarClock({Key key, this.remainDays, this.adIconHeight, this.imageUrl})
      : super(key: key);

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
          children: <Widget>[
            Image(
                image: new AssetImage(this.widget.imageUrl),
                height: ScreenUtil().setHeight(this.widget.adIconHeight)),
            Text(
              this.widget.remainDays[i].toString() + '天',
              style: CustomFontSize.textStyle16,
            ),
          ],
        ),
      );
    }
    content = new Row(
      children: clockDayList,
    );
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return buildList();
  }
}
