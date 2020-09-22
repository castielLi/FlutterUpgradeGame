import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/message/messageItem.dart';
import 'package:upgradegame/Src/pages/message/model/fightMessageModel.dart';
import 'package:upgradegame/Src/pages/message/service/fightMessageService.dart';

class MessageDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  MessageDetail({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _MessageDetailState createState() => new _MessageDetailState();
}

class _MessageDetailState extends State<MessageDetail> {
  FightMessageModel messageDetail = new FightMessageModel(total: 0, page: 0, datalist: []);
  int page = 0;
  String noTxText = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.getFightMessageList();
    });
  }

  void getFightMessageList() {
    this.widget.HUD();
    FightMessageService.getFightMessage(this.page, (FightMessageModel model) {
      this.widget.HUD();
      if (null == model) {
        return;
      }
      this.messageDetail.page = model.page;
      if (this.page == 0) {
        this.messageDetail.datalist = [];
      }
      if (model.datalist.length == 0) {
        this.noTxText = '目前没有记录';
        if (this.page != 0) {
          CommonUtils.showErrorMessage(msg: "没有更多了");
        }
      }
      setState(() {
        this.messageDetail.datalist += model.datalist;
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
          this.messageDetail.datalist.length == 0
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
                        '玩家',
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
                  getFightMessageList();
                // });
              },
              // ignore: missing_return
              onRefresh: () {
                // setState(() {
                  this.page = 0;
                  getFightMessageList();
                // });
              },
              child: ListView.builder(
                  itemCount: this.messageDetail == null ? 0 : this.messageDetail.datalist.length,
                  itemBuilder: (content, index) {
                    Datalist item = this.messageDetail.datalist[index];
                    return MessageItem(
                      tDate: item.time,
                      displayname: item.displayname,
                      lineup: item.lineup,
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
