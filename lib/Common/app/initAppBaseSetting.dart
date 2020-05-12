import 'package:flutter/material.dart';
import 'dart:async';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/event/errorEvent.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';

///配置app基础组件 例如:错误信息弹窗
class InitAppSetting extends StatefulWidget {
  final Widget child;

  InitAppSetting({Key key, this.child}) : super(key: key);
  @override
  _InitAppSetting createState() => new _InitAppSetting();
}

class _InitAppSetting extends State<InitAppSetting> {
  StreamSubscription stream;
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    stream = ConfigSetting.eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
//    fluwx.register(
//        appId: "wxea0b8491b5101053",
//        doOnAndroid: true,
//        doOnIOS: true,
//        enableMTA: false);
  }

  @override
  void dispose() {
//    fluwx.dispose();
//    if (stream != null) {
//      stream.cancel();
//      stream = null;
//    }
    super.dispose();
  }

  ///网络错误
  errorHandleFunction(int code, message) {
    switch (code) {
      case ConfigSetting.NETWORK_ERROR:
        CommonUtils.showSystemErrorMessage(msg: '网络错误');
        break;
      case 401:
        CommonUtils.showSystemErrorMessage(
            msg: '[401错误可能: 未授权 \\ 授权登录失败 \\ 登录过期]');
        break;
      case 403:
        CommonUtils.showSystemErrorMessage(msg: '403权限错误');
        break;
      case 404:
        CommonUtils.showSystemErrorMessage(msg: '404错误,请稍后重试！');
        break;
      case ConfigSetting.NETWORK_TIMEOUT:
        CommonUtils.showSystemErrorMessage(msg: '请求超时');
        break;
      default:
        CommonUtils.showSystemErrorMessage(
          msg: "其他异常" + " " + message,
        );
        break;
    }
  }
}