import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/globalDataModel.dart';
import 'package:upgradegame/Src/common/model/hero.dart';
import 'package:upgradegame/Src/pages/heroAltar/model/holdHeroDisplayModel.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';

class HeroAltarClock extends StatefulWidget {
  String imageUrl;
  double adIconHeight;
  List<HoldHeroDisplayModel> remainDays;
  Function callback;
  int consumeCoin;
  bool isPermanent;
  int type;

  HeroAltarClock({Key key, this.isPermanent = true, this.consumeCoin = 0, this.type,this.remainDays, this.adIconHeight, this.imageUrl, this.callback}) : super(key: key);

  @override
  _HeroAltarClockState createState() => _HeroAltarClockState();
}

class _HeroAltarClockState extends State<HeroAltarClock> {
  Widget buildList(BaseUserInfoProvider baseUserInfo) {
    List<Widget> clockDayList = [];
    Widget content;
    for (int i = 0; i < this.widget.remainDays.length; i++) {
      clockDayList.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                Image(image: new AssetImage(this.widget.imageUrl), height: this.widget.adIconHeight),
                Text(
                  this.widget.remainDays[i].days > 31 ? "永久" : this.widget.remainDays[i].days.toString() + '天',
                  style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                ),
              ],
            ),
            Offstage(
              offstage: !this.widget.isPermanent,
              child: Text(
                "消耗" + this.widget.consumeCoin.toString() + '金币',
                style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
              ),
            ),
            Offstage(
              offstage: this.widget.remainDays[i].collected,
              child:  GestureDetector(
                child: Container(
                  width: ScreenUtil().setWidth(SystemButtonSize.smallButtonWidth),
                  height: ScreenUtil().setHeight(SystemButtonSize.smallButtonHeight),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: new AssetImage('resource/images/upgradeButton.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '分 红',
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                    ),
                  ),
                ),
                onTap: (){
                  if(this.widget.type == Heroes.WARRIOR){
                    if(baseUserInfo.ad.wood + baseUserInfo.ad.stone + baseUserInfo.ad.farmone
                        + baseUserInfo.ad.farmtwo + baseUserInfo.ad.farmthree >= Global.extraRule.heroadamount){
                      this.widget.callback(this.widget.type,this.widget.remainDays[i].id);
                    }else{
                      CommonUtils.showErrorMessage(msg: "你当前的广告数量没有达到" + Global.extraRule.heroadamount.toString() +"条不能领取分红");
                      return;
                    }
                  }else{
                    if(baseUserInfo.tcoinamount < this.widget.consumeCoin){
                      CommonUtils.showErrorMessage(msg: "您当前的金币不足,请有足够金币的时候再来吧");
                      return;
                    }
                    if(baseUserInfo.ad.wood + baseUserInfo.ad.stone + baseUserInfo.ad.farmone
                        + baseUserInfo.ad.farmtwo + baseUserInfo.ad.farmthree >= Global.extraRule.heroadamount){
                      this.widget.callback(this.widget.type,this.widget.remainDays[i].id);
                    }else{
                      CommonUtils.showErrorMessage(msg: "你当前的广告数量没有达到" + Global.extraRule.heroadamount.toString() +"条不能领取分红");
                      return;
                    }
                  }

                },
              ),
            ),
          ],
        ),
      );
    }
    content = Container(
      //最高只能为360
      height: ScreenUtil().setHeight(clockDayList.length * SystemButtonSize.smallButtonHeight > 360 ? 360 : clockDayList.length * SystemButtonSize.smallButtonHeight),
      child: SingleChildScrollView(
        child: Column(
          children: clockDayList,
        ),
      ),
    );
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
          return buildList(baseUserInfo);
        })
    );
  }
}
