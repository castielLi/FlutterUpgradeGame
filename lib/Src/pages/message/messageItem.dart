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

  MessageItem({Key key, this.tDate, this.displayname, this.lineup}) : super(key: key);

  @override
  _MessageItem createState() => _MessageItem();
}

class _MessageItem extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
            callback: (){
              Navigator.push(context, PopWindow(pageBuilder: (context) {
                return TrainArmyDetail();
              }));
            },
          ),
        ],
      ),
      Divider(
        height: 1.0,
        color: Colors.white,
      ),
    ],);
  }
}
