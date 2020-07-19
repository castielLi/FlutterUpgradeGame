import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/team/model/invitation.dart';

class TeamItem extends StatefulWidget {
  // 等级
  int level;

  // 徒弟数据
  InvitationModel invite;

  TeamItem({
    Key key,
    this.invite,
    this.level,
  }) : super(key: key);

  @override
  _TeamItem createState() => _TeamItem();
}

class _TeamItem extends State<TeamItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
//            Image(
//              image: new AssetImage(this.widget.invite.avatar == ""
//                  ? 'resource/images/avatar.png'
//                  : this.widget.invite.avatar),
//              height: ScreenUtil().setHeight(100),
//            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  this.widget.invite.displayname,
                  style: CustomFontSize.defaultTextStyle(55),
                ),
                Text(
                  this.widget.invite.registertime,
                  style: CustomFontSize.defaultTextStyle(40),
                ),
              ],
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
          child: Text(
            '¥' +
                this.widget.invite.income.toString() +
                "(" +
                this.widget.invite.voucherincome.toString() +
                ')',
            style: CustomFontSize.defaultTextStyle(45),
          ),
        ),
      ],
    );
  }
}
