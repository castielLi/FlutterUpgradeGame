import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/red/service/redService.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:upgradegame/Src/route/application.dart';

import 'model/redModel.dart';

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
  String cashAmount = "0";

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
    void showOrDismissProgressHUD() {
      setState(() {
        if (_loading) {
          _progressHUD.state.dismiss();
        } else {
          _progressHUD.state.show();
        }

        _loading = !_loading;
      });
    }

    return new Container(
      child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
        return Scaffold(
          backgroundColor: Color.fromRGBO(1, 1, 1, 0.3),
          body: SingleChildScrollView(
            child: Container(
              width: ScreenUtil().setWidth(1080),
              height: ScreenUtil().setWidth(1920),
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
                            if (baseUserInfo.ad.stone + baseUserInfo.ad.wood + baseUserInfo.ad.farmone + baseUserInfo.ad.farmtwo + baseUserInfo.ad.farmthree > -1) {
                              showOrDismissProgressHUD();
                              RedService.recycleRed((RedModel model) {
                                showOrDismissProgressHUD();
                                if (null != model) {
                                  setState(() {
                                    this.cashAmount = (null == model.cash ? "0" : model.cash);
                                  });
                                }
                                if (this.isRedEnvelopeClose) {
                                  setState(() {
                                    this.isRedEnvelopeClose = false;
                                  });
                                }
                              });
                            } else {
                              CommonUtils.showErrorMessage(msg: "您没有足够的广告条数来打开红包哟");
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
                            margin: EdgeInsets.only(top: ScreenUtil().setHeight(1150)),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '需消耗非下级获得的120贡献值才能打开',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(SystemFontSize.bigTextSize),
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '每天只能打开一次',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(SystemFontSize.bigTextSize),
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ),
                        ),
                      ),
                      Center(
                        child: Offstage(
                          offstage: this.isRedEnvelopeClose,
                          child: Container(
                            child: Text(
                              '获得' + this.cashAmount.toString() + '元红包,已打入现金账户',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(SystemFontSize.moreMoreLargerTextSize),
                                color: Colors.white,
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
      }),
    );
  }
}
