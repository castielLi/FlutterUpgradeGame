import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContributionDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  ContributionDetail({Key key, this.HUD}) : super(key: key);

  _ContributionDetailState createState() => new _ContributionDetailState();
}

class _ContributionDetailState extends State<ContributionDetail> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      ///加载数据
      this.widget.HUD();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(100), // 左
          ScreenUtil().setHeight(400), // 上
          ScreenUtil().setWidth(100), // 右
          ScreenUtil().setHeight(200)), // 下
      child: Text("贡献值"),
    );
  }

}
