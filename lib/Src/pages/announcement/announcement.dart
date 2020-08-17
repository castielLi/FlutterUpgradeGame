import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/announcement/model/announcementModel.dart';
import 'package:upgradegame/Src/pages/announcement/service/announcementService.dart';

class AnnouncementDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  AnnouncementDetail({Key key, this.HUD}) : super(key: key);

  _AnnouncementDetailState createState() => new _AnnouncementDetailState();
}

class _AnnouncementDetailState extends State<AnnouncementDetail> {
  String announcement;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      AnnouncementService.getAnnouncementList((data) {
        if (null != data) {
          setState(() {
            announcement = AnnouncementModel.fromJson(data).content;
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
            null == announcement || '' == announcement ? "目前没有公告" : announcement,
            textAlign: TextAlign.center,
            style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
          ),
        ),
      ),
    );
  }
}
