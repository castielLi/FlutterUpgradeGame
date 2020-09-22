import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Src/pages/trainArmy/trainArmy.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'dart:convert' as convert;

class MessageItem extends StatefulWidget {
  // 攻打日期
  String tDate;

  // 攻打人名称
  String displayname;

  String lineup;

  MessageItem({Key key, this.tDate, this.displayname, this.lineup}) : super(key: key);

  @override
  _MessageItem createState() => _MessageItem();
}

class _MessageItem extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
            ImageButton(
              buttonName: '回看',
              imageUrl: 'resource/images/upgradeButton.png',
              textSize: SystemFontSize.bigTextSize,
              width: ScreenUtil().setWidth(180),
              height: ScreenUtil().setHeight(120),
              callback: () {

                var lineup = List<List<int>>();
                var list = convert.jsonDecode(this.widget.lineup);
                for(int i = 0;i<list.length;i++){
                  var row = List<int>();
                  for(int j = 0;j<list[i].length;j++){
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
                    isFightWin: false,
                  );
                }));
              },
            ),
          ],
        ),
        Divider(
          height: 1.0,
          color: Colors.white,
        ),
      ],
    );
  }
}
