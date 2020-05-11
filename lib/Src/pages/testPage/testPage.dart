import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => new _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool hadInit = false;

  ///创建时候在initState 之后被调用
  ///在依赖的InheritedWidget发生变化的时候会被调用
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hadInit) {
      return;
    }

    ///防止多次进入
    hadInit = true;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,width: 750, height: 1334);
    return new Container(
      color: SystemColor.primaryWhite,
      child: Stack(
        children: <Widget>[
          new Center(
            child:
            new Image(image: new AssetImage('static/images/welcome.png')),
          ),
        ],
      ),
    );
  }
}
