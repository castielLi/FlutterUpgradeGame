import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Src/pages/trainArmy/armySelect.dart';
import 'package:upgradegame/Src/route/application.dart';

class SmallDetailDialog extends StatefulWidget {
  double height;
  double width;
  String childWidgetName;
  String title;
  int row;
  int column;

  SmallDetailDialog({Key key, this.height, this.width, this.childWidgetName, this.title = "",this.row,this.column}) : super(key: key);

  @override
  _SmallDetailDialogState createState() => new _SmallDetailDialogState();
}

class _SmallDetailDialogState extends State<SmallDetailDialog> {
  ProgressHUD _progressHUD;
  bool _loading = false;
  String currentDisplayTitle = "";
  int lastClickTime;

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

    void changeCurrentDialogTitle(String title) {
      setState(() {
        currentDisplayTitle = title;
      });
    }

    void displayOriginalTitle() {
      setState(() {
        currentDisplayTitle = this.widget.title;
      });
    }

    Widget currentWidget;
    switch (this.widget.childWidgetName) {
      case 'armySelectDetail':
        {
          currentWidget = new ArmySelectDetail(
            HUD: showOrDismissProgressHUD,
          );
          break;
        }
    }

    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil().setWidth(1080),
          height: ScreenUtil().setHeight(1920),
          color: Colors.transparent,
          child: new Container(
              color: Colors.transparent,
              margin: EdgeInsets.fromLTRB((ScreenUtil().setWidth(1080) - this.widget.width) / 2, (ScreenUtil().setHeight(1920) - this.widget.height) / 2,
                  (ScreenUtil().setWidth(1080) - this.widget.width) / 2, (ScreenUtil().setHeight(1920) - this.widget.height) / 2),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: new Image(
                      image: new AssetImage('resource/images/smallDetailDialogBackground.png'),
                      fit: BoxFit.fill,
                      height: widget.height,
                      width: widget.width,
                    ),
                  ),
                  Container(
//                    color: Colors.red,
                    height: ScreenUtil().setHeight(210),
                    width: this.widget.width,
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(820)),
                    child: ImageButton(
                        height: ScreenUtil().setHeight(150),
                        width: ScreenUtil().setWidth(150),
                        imageUrl: "resource/images/cancelDialog.png",
                        callback: () {
                          /// 防止重复点击
                          if (null == this.lastClickTime || (DateTime.now().millisecondsSinceEpoch - this.lastClickTime > 1000)) {
//                            Provide.value<BaseDialogClickProvider>(context).setDialogHide();
                            Application.router.pop(context);
                            this.lastClickTime = DateTime.now().millisecondsSinceEpoch;
                          }
                        }),
                  ),
                  currentWidget,
                  _progressHUD,
                ],
              )),
        ),
      ),
    );
  }
}
