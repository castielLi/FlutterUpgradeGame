import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/setting/private/service/privacyService.dart';

import 'model/privacyModel.dart';

class PrivateDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  PrivateDetail({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _PrivateDetailState createState() => new _PrivateDetailState();
}

class _PrivateDetailState extends State<PrivateDetail> {
  String content = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      PrivacyService.getPrivacy().then((data) {
        if (data.code == ConfigSetting.SUCCESS && data.data != null) {
          setState(() {
            content = PrivacyModel.fromJson(data.data).content;
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
                Text(this.content,textAlign: TextAlign.center,
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
