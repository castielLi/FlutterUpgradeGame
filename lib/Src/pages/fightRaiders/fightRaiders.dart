import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/announcement/model/announcementModel.dart';
import 'package:upgradegame/Src/pages/announcement/service/announcementService.dart';

class FightRaiderDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  FightRaiderDetail({Key key, this.HUD}) : super(key: key);

  _FightRaiderDetailState createState() => new _FightRaiderDetailState();
}

class _FightRaiderDetailState extends State<FightRaiderDetail> {
  String announcement = "战场必读攻略: 所有玩家都可以无差别进入战场,首次进入战场的玩家需要"+
  "在商城里面购买物资,物资是您在战场中最重要的资源,当你购买物资之后请先配置好您的防守阵容,因为一旦"
  +"你有足够的物资,您的部落信息将会进入匹配列表中,其他玩家可以随时进行匹配对战。如果您当前没有防守阵容"
  +"可能会造成一定不必要的损失。玩家有足够的物资,木材和石材即可进行进攻阵容的编排并且攻打其他玩家,胜利者"
  "会获得丰厚的奖励。当您的物资达到足够多的数量时,可以将物资兑换成现金,并且直接发放到现金账户中";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight),
        margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(SystemScreenSize.detailDialogTop),
            ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(SystemScreenSize.detailDialogBottom)),
        child: SingleChildScrollView(
          child: Text(
            announcement,
            textAlign: TextAlign.center,
            style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
          ),
        ),
      ),
    );
  }
}
