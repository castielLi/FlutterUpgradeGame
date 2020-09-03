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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(600),
                  child: Text(
                    this.widget.invite.displayname,
                    style: CustomFontSize.defaultTextStyle(55),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  this.widget.invite.registertime,
                  style: CustomFontSize.defaultTextStyle(40),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: ScreenUtil().setWidth(0)),
              width: ScreenUtil().setWidth(200),
              child: Text(
                '¥' +
                    this.widget.invite.voucherincome.toString() +
                    "(" +
                    this.widget.invite.contribution.toString() +
                    ')',
                style: CustomFontSize.defaultTextStyle(45),
                overflow: TextOverflow.clip,
              ),
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
