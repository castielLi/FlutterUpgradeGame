import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/MyEasyRefresh/myEasyRefresh.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/message/messageItem.dart';
import 'package:upgradegame/Src/pages/message/model/fightMessageModel.dart';
import 'package:upgradegame/Src/pages/message/service/fightMessageService.dart';

class MessageDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  MessageDetail({Key key, this.HUD}) : super(key: key);

  _MessageDetailState createState() => new _MessageDetailState();
}

class _MessageDetailState extends State<MessageDetail> {
  FightMessageModel messageDetail = new FightMessageModel(total: 0, page: 0, datalist: []);
  int page = 0;
  String noTxText = '';
  double listOffset = 0;
  ScrollController listController = new ScrollController();

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
      if (model.page == 0) {
        this.messageDetail.datalist = [];
        this.listOffset = 0;
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
      WidgetsBinding.instance.addPostFrameCallback((mag) {
        this.listController.jumpTo(this.listOffset);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(1050),
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(SystemScreenSize.detailDialogTop),
          ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(0)),
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
                        '结果',
                        style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
                      ),
                    ],
                  ),
                ),
          Container(
            height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight),
            child: MyEasyRefresh(
              // ignore: missing_return
              loadMoreCallback: () {
                this.page++;
                getFightMessageList();
                this.listOffset = this.listController.offset;
              },
              // ignore: missing_return
              onRefreshCallback: () {
                this.page = 0;
                getFightMessageList();
              },
              child: ListView.builder(
                  itemCount: this.messageDetail == null ? 0 : this.messageDetail.datalist.length,
                  controller: this.listController,
                  itemBuilder: (content, index) {
                    Datalist item = this.messageDetail.datalist[index];
                    return MessageItem(
                      tDate: item.time,
                      displayname: item.displayname,
                      lineup: item.lineup,
                      win: item.win,
                      isattack: item.isattack,
                      winstone: item.winstone,
                      winwood: item.winwood,
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
