import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Src/pages/trainArmy/trainArmy.dart';
import 'package:upgradegame/Src/route/application.dart';

class MessageItem extends StatefulWidget {
  // 攻打日期
  String tDate;

  // 攻打人名称
  String displayname;

  String lineup;

  bool win;

  bool isattack;

  int winwood;

  int winstone;

  MessageItem({Key key, this.tDate, this.displayname, this.lineup, this.win, this.isattack, this.winwood, this.winstone}) : super(key: key);

  @override
  _MessageItem createState() => _MessageItem();
}

class _MessageItem extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              this.widget.tDate,
              style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
            ),
            Expanded(
              child: Text(
                this.widget.displayname,
                textAlign: TextAlign.center,
                style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: ScreenUtil().setWidth(50)),
              child: Text(
                (this.widget.isattack ? '进攻' : '防守') + (this.widget.win ? '成功' : '失败'),
                style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
              ),
            ),
          ],
        ),
        ImageButton(
          buttonName: '回看',
          imageUrl: 'resource/images/upgradeButton.png',
          textSize: SystemFontSize.bigTextSize,
          width: ScreenUtil().setWidth(210),
          height: ScreenUtil().setHeight(140),
          callback: () {
            var lineup = List<List<int>>();
            var list = convert.jsonDecode(this.widget.lineup);
            for (int i = 0; i < list.length; i++) {
              var row = List<int>();
              for (int j = 0; j < list[i].length; j++) {
                row.add(list[i][j]);
              }
              lineup.add(row);
            }

            Navigator.push(context, PopWindow(pageBuilder: (context) {
              List<List<int>> content = List<List<int>>();
              if (null != this.widget.lineup && '' != this.widget.lineup) {
                var list = convert.jsonDecode(this.widget.lineup);
                for (int i = 0; i < list.length; i++) {
                  var row = List<int>();
                  for (int j = 0; j < list[i].length; j++) {
                    row.add(list[i][j]);
                  }
                  content.add(row);
                }
              }
              return TrainArmyDetail(
                contentName: 'reWatch',
                content: lineup,
                isFightWin: this.widget.win,
                winsupplies: this.widget.win ? 8 : -10,
                winwood: null == this.widget.winwood ? 0 : this.widget.winwood,
                winstone: null == this.widget.winstone ? 0 : this.widget.winstone,
                isReWatchAttack: this.widget.isattack,
              );
            }));
          },
        ),
        Divider(
          height: 1.0,
          color: Colors.white,
        ),
      ],
    );
  }
}
