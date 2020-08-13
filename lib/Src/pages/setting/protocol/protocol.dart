import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Src/pages/setting/event/settingEventBus.dart';
import 'package:upgradegame/Src/pages/setting/protocol/service/protocolService.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'model/protocol.dart';

class ProtocolDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  ProtocolDetail({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _ProtocolDetailState createState() => new _ProtocolDetailState();
}

class _ProtocolDetailState extends State<ProtocolDetail> {
  String content = "";

  @override
  void initState() {
    super.initState();
    SettingHttpRequestEvent().on("protocol", this.getProtocol);
  }

  Future<String> loadAsset(callback) async {
    var content = await rootBundle.loadString('resource/file/serviceProtocol.txt');
    callback(content);
  }

  void getProtocol() {
//    this.widget.HUD();
//    ProtocolService.getProtocolList((data) {
//      if (null != data) {
//        setState(() {
//          content = ProtocolModel.fromJson(data).content;
//        });
//      }
//    });
//    this.widget.HUD();
    this.loadAsset((String content){
      setState(() {
        this.content = content;
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
                this.content,
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
//                this.widget.HUD();
              this.widget.viewCallback();
            },
          ),
        ],
      ),
    );
  }
}
