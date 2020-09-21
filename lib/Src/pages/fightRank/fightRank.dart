import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/fightRank/service/fightRankService.dart';
import 'package:upgradegame/Src/pages/rank/model/rankModel.dart';
import 'package:upgradegame/Src/pages/rank/rankItem.dart';
import 'package:upgradegame/Src/pages/rank/service/rankService.dart';

class FightRankDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  FightRankDetail({Key key, this.HUD}) : super(key: key);

  _FightRankDetailState createState() => new _FightRankDetailState();
}

class _FightRankDetailState extends State<FightRankDetail> {
  List<dynamic> fightList = [];
  String tabName = 'coin';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      FightRankService.getFightRank((model) {
        if (null != model) {
          setState(() {
            fightList = model.datalist;
          });
        }
      });
      this.widget.HUD();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(SystemScreenSize.detailDialogTop),
          ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(250)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(1000),
            child: ListView.builder(
              itemCount: fightList.length,
              itemExtent: ScreenUtil().setHeight(SystemScreenSize.inputDecorationHeight),
              padding: EdgeInsets.only(top: 0),
              itemBuilder: (BuildContext context, int index) {
                int count = index + 1;
                if (count > 5) {
                  count = 5;
                }
                String imageUrl = 'resource/images/rank$count.png';
                return RankItem(
                  imageUrl: imageUrl,
                  avatarUrl: 'resource/images/avatar.png',
                  rankName: fightList[index].displayname,
                  value: fightList[index].amount,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void changeTabs(String tab) {
    setState(() {
      tabName = tab;
    });
  }
}
