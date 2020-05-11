import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/toast/model/bottomSheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';

class CommonUtils {
  //系统操作错误消息提示
  static showSystemErrorMessage({msg}) {
    return Fluttertoast.showToast(
      msg: msg,
      fontSize: ScreenUtil().setSp(
        SystemFontSize.normalTextSize,
      ),
      backgroundColor: SystemColor.primaryBlack,
      textColor: SystemColor.primaryWhite,
      gravity: ToastGravity.BOTTOM,
    );
  }

  //用户操作错误消息提示
  static showErrorMessage({msg}) {
    return Fluttertoast.showToast(
      msg: msg,
      fontSize: ScreenUtil().setSp(
        SystemFontSize.normalTextSize,
      ),
      backgroundColor: SystemColor.primaryBlack,
      textColor: SystemColor.primaryWhite,
      gravity: ToastGravity.CENTER,
    );
  }

  //用户操作警告消息提示
  static showWarningMessage({msg}) {
    return Fluttertoast.showToast(
      msg: msg,
      fontSize: ScreenUtil().setSp(
        SystemFontSize.normalTextSize,
      ),
      backgroundColor: SystemColor.primaryOrangeText,
      textColor: SystemColor.primaryWhite,
      gravity: ToastGravity.CENTER,
    );
  }

  //操作成功消息提示
  static showSuccessMessage({msg}) {
    return Fluttertoast.showToast(
      msg: msg,
      fontSize: ScreenUtil().setSp(
        SystemFontSize.normalTextSize,
      ),
      backgroundColor: SystemColor.primaryBlue,
      textColor: SystemColor.primaryWhite,
      gravity: ToastGravity.CENTER,
    );
  }

  ///弹窗
  static showNovaAlertDialog(
      context,
      String title,
      String content, {
        String okText = '确定',
        VoidCallback okCallBack,
        String cancelText = '取消',
        VoidCallback cancelCallback,
      }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: new RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        title: Container(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: SystemColor.primaryBlack,
              fontSize: ScreenUtil().setSp(SystemFontSize.normalTextSize),
            ),
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                content,
                style: TextStyle(
                  color: SystemColor.primaryGray,
                  fontSize: ScreenUtil().setSp(SystemFontSize.normalTextSize),
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new FlatButton(
                child: new Text(
                  cancelText,
                  style: TextStyle(
                    color: SystemColor.primaryGray,
                    fontSize: ScreenUtil().setSp(SystemFontSize.normalTextSize),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  cancelCallback?.call();
                },
              ),
              Padding(padding: EdgeInsets.only(left: 10.0)),
              new FlatButton(
                child: new Text(
                  okText,
                  style: TextStyle(
                    color: SystemColor.primaryBlue,
                    fontSize: ScreenUtil().setSp(SystemFontSize.normalTextSize),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  okCallBack?.call();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  ///正在加载框...
  static Future<Null> showLoadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return new Material(
          color: Colors.transparent,
          child: WillPopScope(
            onWillPop: () => new Future.value(false),
            child: Center(
              child: new Container(
                width: 200.0,
                height: 200.0,
                padding: new EdgeInsets.all(4.0),
                decoration: new BoxDecoration(
                  color: Colors.transparent,
                  //用一个BoxDecoration装饰器提供背景图片
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      child: SpinKitCubeGrid(color: SystemColor.primaryWhite),
                    ),
                    new Container(height: 10.0),
                    new Container(
                      child: new Text(
                        '正在加载中....',
                        style: TextStyle(
                            color: SystemColor.primaryWhite, fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ///selectedIndex:默认选中
  ///onOK：返回选中的第几个
  ///list展示列表：这里只用到了name
  static Future<Null> novaShowBottomSheet(BuildContext context,
      List<BottomSheetModel> list, int selectedIndex, onOK) {
    //控制默认选中
    final FixedExtentScrollController scrollController =
    FixedExtentScrollController(initialItem: selectedIndex);

    List<Widget> _textWidgets = list.map((item) {
      return Center(
        child: Text(
          item.title,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      );
    }).toList();
    int selectItem = 0;
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.only(top: 15, left: 15, bottom: 15),
                child: Text(
                  '取消',
                  style: TextStyle(
                    fontSize: 18,
                    color: SystemColor.primaryBlack,
                  ),
                ),
              ),
            ),
            iconTheme: IconThemeData(color: SystemColor.primaryBlack),
            elevation: 1,
            backgroundColor: SystemColor.primaryWhite,
            actions: <Widget>[
              Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        onOK(selectItem);
                        Navigator.pop(context);
                      },
                      child: Text(
                        '确定',
                        style: TextStyle(
                          fontSize: 18,
                          color: SystemColor.primaryBlue,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          body: GestureDetector(
            onTap: () {},
            child: CupertinoPicker(
              scrollController: scrollController,
              magnification: 1,
              backgroundColor: SystemColor.primaryWhite,
              children: _textWidgets,
              itemExtent: 60, //height of each item
              looping: true, //是否循环
              useMagnifier: true,
              onSelectedItemChanged: (int index) {
                selectItem = index;
              },
            ),
          ),
        );
      },
    );
  }
}
