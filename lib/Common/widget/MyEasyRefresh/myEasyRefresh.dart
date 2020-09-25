import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

// ignore: must_be_immutable
class MyEasyRefresh extends StatefulWidget {
  VoidCallback loadMoreCallback;
  VoidCallback onRefreshCallback;
  Widget child;

  MyEasyRefresh({Key key, this.loadMoreCallback, this.onRefreshCallback, this.child});

  @override
  _MyEasyRefresh createState() => new _MyEasyRefresh();
}

class _MyEasyRefresh extends State<MyEasyRefresh> {
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      refreshFooter: ClassicsFooter(
        // textColor: Colors.blue,
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
        // textColor: Colors.blue,
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
        this.widget.loadMoreCallback();
      },
      // ignore: missing_return
      onRefresh: () {
        this.widget.onRefreshCallback();
      },
      child: this.widget.child,
    );
  }
}
