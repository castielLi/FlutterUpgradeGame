import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';

class TCoinDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  TCoinDetail({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _TCoinDetailState createState() => new _TCoinDetailState();
}

class _TCoinDetailState extends State<TCoinDetail> {
  int page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    UserInfoHttpRequestEvent().on("tcoinDetail",this.getTCoinDetail);
  }

  void getTCoinDetail() {
//    print("开始请求tcoindetail");
//    this.widget.HUD();
//    UserInfoService.getUserTCoinDetail(this.page,(){
//      this.widget.HUD();
//    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Stack(
        children: <Widget>[
          new Container(
            child: Center(
              child: new ImageButton(
                height: ScreenUtil().setHeight(200),
                width: ScreenUtil().setWidth(400),
                buttonName: "升 级",
                imageUrl: "resource/images/upgradeButton.png",
                callback: () {
//                this.widget.HUD();
                  this.widget.viewCallback();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
