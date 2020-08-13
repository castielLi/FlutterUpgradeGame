import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Src/pages/setting/event/settingEventBus.dart';
import 'package:upgradegame/Src/pages/setting/private/service/privacyService.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'model/privacyModel.dart';

class PrivateDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  PrivateDetail({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _PrivateDetailState createState() => new _PrivateDetailState();
}

class _PrivateDetailState extends State<PrivateDetail> {
  String privacy = '';

  @override
  void initState() {
    super.initState();
    SettingHttpRequestEvent().on("private", this.getPrivacy);
  }

  Future<String> loadAsset(callback) async {
    var content = await rootBundle.loadString('resource/file/privateProtocol.txt');
    callback(content);
  }

  void getPrivacy() {
//    this.widget.HUD();
//    PrivacyService.getPrivacy((data) {
//      if (null != data) {
//        setState(() {
//          privacy = PrivacyModel.fromJson(data).content;
//        });
//      }
//    });
//    this.widget.HUD();
  this.loadAsset((String content){
    setState(() {
      privacy = content;
    });
  });
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight),
            child: SingleChildScrollView(
              child: Text(
                this.privacy,
                textAlign: TextAlign.center,
                style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
              ),
            ),
          ),
          new ImageButton(
            height: ScreenUtil().setHeight(SystemButtonSize.largeButtonHeight),
            width: ScreenUtil().setWidth(SystemButtonSize.largeButtonWidth),
            buttonName: "返回",
            imageUrl: "resource/images/upgradeButton.png",
            callback: () {
              this.widget.viewCallback();
            },
          ),
        ],
      ),
    );
  }
}
