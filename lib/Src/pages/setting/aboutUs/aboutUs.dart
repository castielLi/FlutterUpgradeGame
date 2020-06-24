import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/setting/aboutUs/service/aboutUsService.dart';

import 'model/aboutUsModel.dart';

class AboutUsDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  AboutUsDetail({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _AboutUsDetailState createState() => new _AboutUsDetailState();
}

class _AboutUsDetailState extends State<AboutUsDetail> {
  String content = "关于我们";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      AboutUsService.getAboutUs().then((data) {
        if (data.code == ConfigSetting.SUCCESS && data.data != null) {
          setState(() {
            content = AboutUsModel.fromJson(data.data).content;
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
          ScreenUtil().setWidth(0), // 左
          ScreenUtil().setHeight(120), // 上
          ScreenUtil().setWidth(0), // 右
          ScreenUtil().setHeight(120)),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(820),
            child: ListView(
              children: <Widget>[
                Text(
                  this.content,
                  textAlign: TextAlign.center,
                  style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                ),
              ],
            ),
          ),
          new ImageButton(
            height: ScreenUtil().setHeight(200),
            width: ScreenUtil().setWidth(400),
            buttonName: "返回",
            imageUrl: "resource/images/upgradeButton.png",
            callback: () {
              print('点击升级');
//                this.widget.HUD();
              this.widget.viewCallback();
            },
          ),
        ],
      ),
    );
  }
}
