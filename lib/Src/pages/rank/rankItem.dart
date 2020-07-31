import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class RankItem extends StatefulWidget {
  //排名图标
  String imageUrl;

  // 头像
  String avatarUrl;

  // 名称
  String rankName;

  // 数值
  dynamic value;

  RankItem({Key key, this.imageUrl, this.avatarUrl, this.rankName, this.value}) : super(key: key);

  @override
  _RankItem createState() => _RankItem();
}

class _RankItem extends State<RankItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(20), // 左
          ScreenUtil().setHeight(0), // 上
          ScreenUtil().setWidth(30), // 右
          ScreenUtil().setHeight(0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image(
                image: new AssetImage(this.widget.imageUrl),
                //TODO 修改大小
                height: ScreenUtil().setHeight(120),
              ),
//            Image(
//              image: new AssetImage(this.widget.avatarUrl),
//              height: ScreenUtil().setHeight(120),
//            ),
              Text(
                this.widget.rankName,
                style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
              ),
            ],
          ),
          Text(
            this.widget.value.toString(),
            style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
          ),
        ],
      ),
    );
  }
}
