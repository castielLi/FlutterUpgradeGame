import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/message/messageItem.dart';
import 'package:upgradegame/Src/pages/userInfo/model/tCoinDetailModel.dart';
import 'package:upgradegame/Src/pages/userInfo/service/userInfoService.dart';
import 'package:upgradegame/Src/pages/userInfo/tradeDetail/tradeItem.dart';

class MessageDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  MessageDetail({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _MessageDetailState createState() => new _MessageDetailState();
}

class _MessageDetailState extends State<MessageDetail> {
  TCoinDetailModel tCoinDetail = new TCoinDetailModel(total: 0, page: 0, datalist: []);
  int page = 0;
  String noTxText = '';

  @override
  void initState() {
    super.initState();
    this.getTCoinDetail();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      this.getTCoinDetail();
      this.widget.HUD();
    });
  }

  void getTCoinDetail() {
    UserInfoService.getUserTCoinDetail(this.page, (TCoinDetailModel model) {
      if (null == model) {
        return;
      }
      this.tCoinDetail.page = model.page;
      if (this.page == 0) {
        this.tCoinDetail.datalist = [];
      }
      if (model.datalist.length == 0) {
        this.noTxText = '目前没有记录';
        if (this.page != 0) {
          CommonUtils.showErrorMessage(msg: "没有更多了");
        }
      }
      setState(() {
        this.tCoinDetail.datalist += model.datalist;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(1000),
      width: ScreenUtil().setWidth(850),
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(SystemScreenSize.detailDialogTop),
          ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(250)),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          this.tCoinDetail.datalist.length == 0
              ? Text(
                  this.noTxText,
                  style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
                )
              : Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        '日期',
                        style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
                      ),
                      Text(
                        '结果',
                        style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
                      ),
                      Text(
                        '操作',
                        style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
                      ),
                    ],
                  ),
                ),
          Container(
            // color: Colors.yellow,
            height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight),
            child: EasyRefresh(
              refreshFooter: ClassicsFooter(
                bgColor: Colors.transparent,
                loadText: "上滑加载",
                loadReadyText: "松开加载",
                loadingText: "正在加载",
                loadedText: "加载完成",
                noMoreText: "没有更多了",
                loadHeight: 35,
                key: new GlobalKey<RefreshFooterState>(),
              ),
              refreshHeader: ClassicsHeader(
                bgColor: Colors.transparent,
                refreshText: "下拉刷新",
                refreshReadyText: "松开刷新",
                refreshingText: "正在刷新",
                refreshedText: "刷新完成",
                refreshHeight: 35,
                key: new GlobalKey<RefreshHeaderState>(),
              ),
              // ignore: missing_return
              loadMore: () {
                // setState(() {
                  this.page++;
                  getTCoinDetail();
                // });
              },
              // ignore: missing_return
              onRefresh: () {
                // setState(() {
                  this.page = 0;
                  getTCoinDetail();
                // });
              },
              child: ListView.builder(
                  itemCount: this.tCoinDetail == null ? 0 : this.tCoinDetail.datalist.length,
                  itemBuilder: (content, index) {
                    Datalist tCoinTx = this.tCoinDetail.datalist[index];
                    return MessageItem(
                      tDate: tCoinTx.datetime,
                      result: Random().nextBool()?'胜利':'失败',
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
