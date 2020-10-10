import 'package:flutter/material.dart';
import 'package:upgradegame/Common/app/config.dart';

class HeroAltarClock extends StatefulWidget {
  String imageUrl;
  double adIconHeight;
  List<int> remainDays;

  HeroAltarClock({Key key, this.remainDays, this.adIconHeight, this.imageUrl}) : super(key: key);

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
            Image(image: new AssetImage(this.widget.imageUrl), height: this.widget.adIconHeight),
            Text(
              this.widget.remainDays[i] > 30 ? "永久" : this.widget.remainDays[i].toString() + '天',
              style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
            ),
          ],
        ),
      );
    }
    content = GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      crossAxisCount: 3,
      childAspectRatio: 2,
      children: clockDayList,
    );
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return buildList();
  }
}
