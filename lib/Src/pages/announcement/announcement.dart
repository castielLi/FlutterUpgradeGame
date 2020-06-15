import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/announcement/model/announcementModel.dart';
import 'package:upgradegame/Src/pages/announcement/service/announcementService.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';

class AnnouncementDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  AnnouncementDetail({Key key, this.HUD}) : super(key: key);

  _AnnouncementDetailState createState() => new _AnnouncementDetailState();
}

class _AnnouncementDetailState extends State<AnnouncementDetail> {

  String content = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      AnnouncementService.getAnnouncementList().then((data) {
        if (data.code == ConfigSetting.SUCCESS && data.data != null) {
          setState(() {
            content = AnnouncementModel.fromJson(data.data).content;
          });
        } else {
          CommonUtils.showErrorMessage(msg: "网络请求失败，请重试");
        }
        this.widget.HUD();
      });
    });
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
          Text("$content",textAlign: TextAlign.center,style: CustomFontSize.defaultTextStyle(100),),
        ],
      ),

    );
  }
}
