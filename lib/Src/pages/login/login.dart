import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/login/service/loginService.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:provide/provide.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:upgradegame/Src/provider/basePageLogicProvider.dart';


class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const platform = const MethodChannel('samples.flutter.ad');
  static const EventChannel _eventChannel = const EventChannel('samples.flutter.ad.event');
  ProgressHUD _progressHUD;
  bool _loading = false;

  void initState() {
    super.initState();
    _eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
    _progressHUD = new ProgressHUD(
      backgroundColor: Colors.transparent,
      color: Colors.white,
      containerColor: Colors.black,
      borderRadius: 5.0,
      text: '',
      loading: false,
    );
  }


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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.black,
      child: ProvideMulti(
        builder: (context,child,model){
          return Stack(
            children: <Widget>[
              new Container(
                child:Center(
                  child:Column(
                    children: <Widget>[
                      new RaisedButton(child:Text("adview kaipin"),onPressed: (){
                        toast(1, 1);
                      }),
                      new RaisedButton(child:Text("adview video"),onPressed: (){
                        toast(1, 2);
                      }),
                      new RaisedButton(child:Text("baidu kaipin"),onPressed: (){
                        toast(2, 1);
                      }),
                      new RaisedButton(child:Text("baidu video"),onPressed: (){
                        toast(2, 2);
                      }),
                      new RaisedButton(child:Text("Tencent kaipin"),onPressed: (){
                        toast(3, 1);
                      }),
                      new RaisedButton(child:Text("Tencent video"),onPressed: (){
                        toast(3, 2);
                      }),
                      new RaisedButton(child:Text("login"),onPressed: (){
                        this.showOrDismissProgressHUD();
                        LoginService.login((model){
                          this.showOrDismissProgressHUD();
                          Provide.value<BaseUserInfoProvider>(context).initBaseUserInfo(model);
                          Application.router
                              .navigateTo(context, UpgradeGameRoute.mainPage, clearStack: true);
                        });
                      }),
                    ],
                  )

                ),
                margin: EdgeInsets.only(top: 200),
              ),
              _progressHUD
            ],
          );
        },
          requestedValues: [BaseUserInfoProvider, BasePageLogicProvider]
      ),
    );
  }
  // ÏÔÊ¾¹ã¸æ
  // action = showAd Ê¼ÖÕ²»±ä
  // type ÏÔÊ¾µÄ¹ã¸æ³§ÉÌ 1 adview 2-°Ù¶È¹ã¸æ 3-¹ãµãÍ¨
  //  showType Ê¾µÄ¹ã¸æÀàÐÍ 1 ¿ªÆÁ 2 ÊÓÆµ
  // posId ¹ã¸æÎ»Id
  void toast(int type,int showType) async {
    try {
      await platform.invokeMethod('showAd', <String, dynamic>{'type': type,"showType":showType,"posId":""});
    } on PlatformException catch (e) {
      print(e);
    }
  }
  void _onEvent(Object event) {
    print("event »ØÀ´ÁË³É¹¦");
  }

  void _onError(Object error) {
    print("event »ØÀ´ÁËÊ§°Ü");
  }
}