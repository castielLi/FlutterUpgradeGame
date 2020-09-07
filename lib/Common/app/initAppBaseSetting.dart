import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluwx_no_pay/fluwx_no_pay.dart' as fluwx;
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:upgradegame/Common/app/notificationEvent.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/globalSystemStatuesControl.dart';

///配置app基础组件 例如:错误信息弹窗
class InitAppSetting extends StatefulWidget {
  final Widget child;

  InitAppSetting({Key key, this.child}) : super(key: key);

  @override
  _InitAppSetting createState() => new _InitAppSetting();
}

class _InitAppSetting extends State<InitAppSetting> with WidgetsBindingObserver{
  String debugLable = 'Unknown';
  final JPush jpush = new JPush();
  final eventBus = new NotificationEvent();
  Timer closeTimer;


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("--" + state.toString());
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。

        break;
      case AppLifecycleState.resumed:// 应用程序可见，前台
        GlobalSystemStatuesControl.setSystemForegournd();
        if(closeTimer != null){
          closeTimer.cancel();
        }
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台
        GlobalSystemStatuesControl.setSystemBackground();
        closeTimer = Timer.periodic(Duration(seconds: 20), (timer) {
          closeTimer.cancel();
          closeTimer = null;
          SystemNavigator.pop();
        });
        break;
      case AppLifecycleState.detached: // 申请将暂时暂停

        break;
    }
  }



  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    jpush.setup(
      appKey: "ea59157f48e85a676b239564", //你自己应用的 AppKey
      channel: "theChannel",
      production: false,
      debug: true,
    );

    jpush.applyPushAuthority(new NotificationSettingsIOS(sound: true, alert: true, badge: true));


    try {
      jpush.addEventHandler(onReceiveNotification: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotification: $message");
        eventBus.eventBus.fire(RecieveNotificationEvent(message));
        setState(() {
          debugLable = "flutter onReceiveNotification: $message";
        });
      }, onOpenNotification: (Map<String, dynamic> message) async {
        print("flutter onOpenNotification: $message");
        setState(() {
          debugLable = "flutter onOpenNotification: $message";
        });
      }, onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
        setState(() {
          debugLable = "flutter onReceiveMessage: $message";
        });
      }, onReceiveNotificationAuthorization: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotificationAuthorization: $message");
        setState(() {
          debugLable = "flutter onReceiveNotificationAuthorization: $message";
        });
      });
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // Platform messages may fail, so we use a try/catch PlatformException.
    jpush.getRegistrationID().then((rid) {
      print("flutter get registration id : $rid");
      NotificationEvent.setDeviceId(rid);
      setState(() {
        debugLable = "flutter getRegistrationID: $rid";
      });
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      debugLable = platformVersion;
    });
  }

  _initFluwx() async {
    await fluwx.registerWxApi(appId: "wxae76a2eb695df231", doOnAndroid: true, doOnIOS: true, universalLink: "");
    var result = await fluwx.isWeChatInstalled;
    print("is installed $result");
    if (!result) {
      CommonUtils.showSystemErrorMessage(msg: '微信初始化失败');
    }
  }

  @override
  void initState() {
    super.initState();
    _initFluwx();
    WidgetsBinding.instance.addObserver(this);
    GlobalSystemStatuesControl();
//    initPlatformState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
