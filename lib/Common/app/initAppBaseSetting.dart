import 'package:flutter/material.dart';
import 'dart:async';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/event/errorEvent.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

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

  _initFluwx() async {
    await fluwx.registerWxApi(
        appId: "wxae76a2eb695df231",
        doOnAndroid: true,
        doOnIOS: true,
        universalLink: ""
    );
    var result = await fluwx.isWeChatInstalled;
    print("is installed $result");
    if(!result){
      CommonUtils.showSystemErrorMessage(msg: '微信初始化失败');
    }
  }

  @override
  void initState() {
    super.initState();
    _initFluwx();
  }

  @override
  void dispose() {
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
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