import 'package:flutter/material.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/enum/adTypeEnum.dart';
import 'package:upgradegame/Src/common/model/watchAdModel.dart';
import 'package:upgradegame/Src/common/service/adService.dart';
import 'package:upgradegame/Src/common/widget/adDialog/adDialog.dart';
import 'package:upgradegame/Src/provider/baseAdTimerProvider.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';

class AdIconRow extends StatefulWidget {
  double adIconHeight;
  int countInOneRow;
  int alreadyWatched;
  String imageUrlUnwatch;
  String imageUrlWatched;
  String imageUrlWaiting;
  AdTypeEnum type;
  VoidCallback HUD;

  AdIconRow({Key key, this.adIconHeight, this.type ,this.HUD,this.imageUrlWaiting,this.countInOneRow, this.imageUrlUnwatch, this.alreadyWatched, this.imageUrlWatched}) : super(key: key);

  @override
  _AdIconRow createState() => _AdIconRow();
}

class _AdIconRow extends State<AdIconRow> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AdDialog().setCallback(this.adFinishedCallback,this.adFailedCallback,false);
  }

  void adFailedCallback(){
    this.widget.HUD();
    CommonUtils.showErrorMessage(msg: "广告观看失败");
  }

  void adFinishedCallback() {
    print("广告已经看完了要执行代码了");
    AdService.watchAd(this.widget.type.index, (WatchAdModel model){
      this.widget.HUD();
      if(model!=null){
        CommonUtils.showSuccessMessage(msg: "获取资源成功");
        Provide.value<BaseAdTimerProvider>(context).watchAd(this.widget.type);
        Provide.value<BaseUserInfoProvider>(context).watchedAnAd(model);
      }
    });
  }

  Widget buildList(BaseAdTimerProvider baseAdTimerInfo) {
    List<Widget> adIconList = [];
    bool waiting =  false;
    switch(this.widget.type){
      case AdTypeEnum.sawmill:
        waiting = baseAdTimerInfo.Sawmill;
        break;
      case AdTypeEnum.farm:
        waiting = baseAdTimerInfo.Farm;
        break;
      case AdTypeEnum.stone:
        waiting = baseAdTimerInfo.Stone;
        break;
    }
    Widget content;
    for (int i = 0; i < this.widget.alreadyWatched; i++) {
      adIconList.add(
        GestureDetector(
          child: new Image(image: new AssetImage(this.widget.imageUrlWatched), height: this.widget.adIconHeight),
          onTap: () {
            CommonUtils.showErrorMessage(msg: '您已经看过该广告了');
          },
        ),
      );
    }
    for (int i = 0; i < (this.widget.countInOneRow - this.widget.alreadyWatched); i++) {
      adIconList.add(
        GestureDetector(
          child: new Image(image: new AssetImage(waiting?this.widget.imageUrlWaiting:this.widget.imageUrlUnwatch), height: this.widget.adIconHeight),
          onTap: () {
            if(waiting){
              CommonUtils.showErrorMessage(msg: '您需要等待一段时间才能继续操作,去看看其他资源吧');
              return;
            }

//            adview = "POSID8rbrja0ih10i";
//            baidu = "7111030";
//            tencent = "6031610694170610";
            ///type选择平台  1：adview 2：baidu 3：腾讯
            ///showType 选择展示 方式 1：开屏广告 2：视频广告
            ///posid 为可选则参数如果有第三个posid参数则用传过来的 否则为andorid模块内默认参数， posid为广告位id
            this.widget.HUD();
            if(this.widget.type == AdTypeEnum.farm){
              ///如果adview的开屏广告初始化成功,那么就展示adview的广告，否则展示腾讯广告
              if(AdDialog().initAdViewSuccess) {
                AdDialog().showAd(1, 2);
//                AdDialog().showAd(1, 2,"POSID8rbrja0ih10i");
              }else{
                AdDialog().showAd(3, 2);
//                AdDialog().showAd(3, 2,"6031610694170610");
              }
            }else if(this.widget.type == AdTypeEnum.stone){
              AdDialog().showAd(2, 2);
//              AdDialog().showAd(2, 2,"7111030");
            }else{
              AdDialog().showAd(3, 2);
//              AdDialog().showAd(3, 2,"6031610694170610");
            }
          },
        ),
      );
    }
    content = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: adIconList
    );
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child:ProvideMulti(
        builder: (context, child, model) {
          BaseAdTimerProvider baseAdTimerInfo = model.get<BaseAdTimerProvider>();
        return buildList(baseAdTimerInfo);
      },
        requestedValues: [BaseUserInfoProvider,BaseAdTimerProvider],
    ),
    );
  }
}
