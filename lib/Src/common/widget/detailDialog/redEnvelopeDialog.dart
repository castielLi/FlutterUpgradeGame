import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Src/route/application.dart';

class RedEnvelopeDialog extends StatefulWidget {
  double height;
  double width;

  RedEnvelopeDialog({
    Key key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  _RedEnvelopeDialogState createState() => new _RedEnvelopeDialogState();
}

class _RedEnvelopeDialogState extends State<RedEnvelopeDialog> {
  ProgressHUD _progressHUD;
  bool _loading = false;
  int lastClickTime;
  bool isRedEnvelopeClose = true;

  void initState() {
    super.initState();

    _progressHUD = new ProgressHUD(
      backgroundColor: Colors.transparent,
      color: Colors.white,
      containerColor: Colors.black,
      borderRadius: 5.0,
      text: '',
      loading: false,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(1, 1, 1, 0.3),
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil().setWidth(1080),
          height: ScreenUtil().setHeight(1920),
          color: Colors.transparent,
          child: new Container(
              color: Colors.transparent,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: new Image(
                      image: new AssetImage('resource/images/' + (this.isRedEnvelopeClose ? 'redEnvelopeClose' : 'redEnvelopeOpen') + '.png'),
                      fit: BoxFit.fill,
                      height: widget.height,
                      width: widget.width,
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      child: Container(
                        color: Colors.transparent,
                        margin: EdgeInsets.only(top: ScreenUtil().setHeight(300)),
                        height: ScreenUtil().setHeight(200),
                        width: ScreenUtil().setWidth(200),
                      ),
                      onTap: () {
                        if (this.isRedEnvelopeClose) {
                          setState(() {
                            this.isRedEnvelopeClose = false;
                          });
                        }
                      },
                    ),
                  ),
                  Center(
                    child: Container(
                      height: ScreenUtil().setWidth(210),
                      width: ScreenUtil().setWidth(210),
                      margin: EdgeInsets.only(top: ScreenUtil().setWidth(1100)),
                      child: ImageButton(
                          height: ScreenUtil().setHeight(150),
                          width: ScreenUtil().setWidth(150),
                          imageUrl: "resource/images/cancelDialog.png",
                          callback: () {
                            if (null == this.lastClickTime || (DateTime.now().millisecondsSinceEpoch - this.lastClickTime > 1000)) {
                              Application.router.pop(context);
                            }
                            this.lastClickTime = DateTime.now().millisecondsSinceEpoch;
                          }),
                    ),
                  ),

                  Center(
                    child: Offstage(
                      offstage: !this.isRedEnvelopeClose,
                      child: Container(
                        margin: EdgeInsets.only(top: ScreenUtil().setHeight(600)),
                        child: Text(
                          '花费120贡献值打开红包',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(SystemFontSize.bigTextSize),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Offstage(
                      offstage: this.isRedEnvelopeClose,
                      child: Container(
                        child: Text(
                          '获得' + Random().nextInt(20).toString() + '元红包',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(SystemFontSize.moreMoreLargerTextSize),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // currentWidget,
                  _progressHUD,
                ],
              )),
        ),
      ),
    );
  }
}
