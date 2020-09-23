import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class FightRaiderDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  FightRaiderDetail({Key key, this.HUD}) : super(key: key);

  _FightRaiderDetailState createState() => new _FightRaiderDetailState();
}

class _FightRaiderDetailState extends State<FightRaiderDetail> {
  String announcement =
      "对战模式是一个绝对公平的竞技玩法，与用户当前等级无关，胜负仅由进攻用户和防守用户当前阵型决定。用户进入对战模式需先布置己方防守阵容，否则进攻方匹配到该用户将直接判定进攻方胜利。防守方只要物资足够，随时可能被其他用户进攻，请谨慎安排防守阵容。发起对战需要至少拥有10物资（仅会匹配物资大于或等于10的用户），每个用户当天仅可在物资小于10时用金币购买一次物资，且仅能购买50物资（5金币=50物资）。当天物资大于10则无法购买物资。每次发起对战需消耗一定木材和石材资源（消耗比例与当前资源等级有关），资源不足则无法发起对战。只要物资和资源充足，当天发起对战次数没有限制。对战匹配仅会匹配物资大于或等于10的用户，胜方将夺取败方部分物资。对战排行榜将每天更新前日胜场，排名前20用户将获得物资奖励。物资为平台金币回收凭证，可消耗物资在平台进行金币回收。";

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
