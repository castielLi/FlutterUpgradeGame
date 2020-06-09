import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class AnnouncementDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  AnnouncementDetail({Key key, this.HUD}) : super(key: key);

  _AnnouncementDetailState createState() => new _AnnouncementDetailState();
}

class _AnnouncementDetailState extends State<AnnouncementDetail> {
  // 获取数据

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(120), // 左
          ScreenUtil().setHeight(400), // 上
          ScreenUtil().setWidth(120), // 右
          ScreenUtil().setHeight(220)),
      child: ListView(
        children: <Widget>[
          Text("游戏公告",textAlign: TextAlign.center,),
        ],
      ),

    );
  }
}
