import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class TeamContribution extends StatefulWidget {
  String title;
  int total;
  int my;
  int secondGrade;
  int thirdGrade;

  TeamContribution({Key key, this.title, this.total, this.my, this.secondGrade, this.thirdGrade}) : super(key: key);

  @override
  _TeamContribution createState() => _TeamContribution();
}

class _TeamContribution extends State<TeamContribution> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(360),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: new AssetImage('resource/images/woodButton.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            this.widget.title,
            style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    this.widget.total.toString(),
                    style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                  ),
                  Text(
                    '今日总贡献',
                    style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    this.widget.my.toString(),
                    style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                  ),
                  Text(
                    '我的贡献',
                    style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    this.widget.secondGrade.toString(),
                    style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                  ),
                  Text(
                    '徒弟贡献',
                    style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    this.widget.thirdGrade.toString(),
                    style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                  ),
                  Text(
                    '徒孙贡献',
                    style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
