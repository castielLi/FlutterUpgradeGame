import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/activity/model/activityModel.dart';
import 'package:upgradegame/Src/activity/service/activityService.dart';

class ActivityDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  ActivityDetail({Key key, this.HUD}) : super(key: key);

  _ActivityDetailState createState() => new _ActivityDetailState();
}

class _ActivityDetailState extends State<ActivityDetail> {
  String activity;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      ActivityService.getActivity((data) {
        if (null != data) {
          setState(() {
            activity = ActivityModel.fromJson(data).content;
          });
        }
      });
      this.widget.HUD();
    });
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
            null == activity || '' == activity ? "目前没有活动" : activity,
            textAlign: TextAlign.center,
            style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
          ),
        ),
      ),
    );
  }
}
