import 'package:flutter/material.dart';

class ListComp extends StatefulWidget {
  final int page; // 页码
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BoxDecoration decoration;
  final List dataList; // 数据
  final bool hasMore; //  还有更多数据
  final bool skeletonLoading; // 开始时使用骨架屏 loading
  final String loadingText; // 请求时的提示
  final Widget loadingWidget; // 请求时的显示 Widget 
  final String nomoreText; // 没有更多数据的提示
  final Function listItemBuilder; // 每项显示的解构
  final Function itemClick; // 每项点击
  final Function onRefresh; // 下拉刷新
  final Function onLoadMore; // 上滑加载

  ListComp({
    Key key,
    @required this.dataList,
    @required this.hasMore,
    this.page = 1,
    this.decoration,
    this.margin = const EdgeInsets.all(10),
    this.padding = const EdgeInsets.all(10),
    this.skeletonLoading = false,
    this.loadingText = '拼命加载中...',
    this.loadingWidget,
    this.nomoreText = '----- 我是有底线的 -----',
    this.listItemBuilder,
    this.itemClick,
    @required this.onRefresh,
    @required this.onLoadMore,
  }) : super(key: key);

  @override
  ListState createState() => ListState();
}

class ListState extends State<ListComp> {
  List _dataList = [];
  bool isReachBottom = true; // 是否到达底部
  final ScrollController _scrollController = ScrollController();

  ListState() : super() {
    _scrollController.addListener(() {
      if (listReachBottom()) {
        onLoadMore();

      } else {
        setState(() {
          isReachBottom = false;
        });
      }
    });
  }

  // 是否到达底部
  bool listReachBottom() {
    return _scrollController.position.pixels == _scrollController.position.maxScrollExtent;
  }

  void listItemClick(item) {
    if (widget.itemClick != null) widget.itemClick(item);
  }

  void onLoadMore() {
    setState(() {
      isReachBottom = true;
    });
    widget.onLoadMore();
  }

  Future<void> onRefresh() {
    setState(() {
      isReachBottom = true;
    });
    return widget.onRefresh();
  }

  Widget listItem(item, int index) {
    return Container(
      margin: widget.margin,
      decoration: widget.decoration != null 
        ? widget.decoration
        : BoxDecoration(
          color: Colors.white,
        ),
      child: FlatButton(
        padding: widget.padding,
        onPressed: () => listItemClick(item),
        child: Row(
          children: <Widget>[
            Expanded(
              child: widget.listItemBuilder(item),
            ),
          ],
        ),
      ),
    );
  }

  Widget loadingItem() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Visibility(
            visible: widget.hasMore && isReachBottom,
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Colors.grey),
              ),
            )
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: widget.hasMore 
              ? (widget.loadingWidget != null 
                ? isReachBottom ? widget.loadingWidget : greyText('上滑加载更多')
                : isReachBottom ? greyText(widget.loadingText) : greyText('上滑加载更多'))
              : greyText(widget.nomoreText)
          )
        ],
      ),
    );
  }

  Widget greyText(String text) {
    return Text('$text', 
      style: TextStyle(color: Colors.grey)
    );
  }

  @override
  void didUpdateWidget(ListComp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dataList.length != widget.dataList.length) return;
    Future.delayed(Duration(seconds: 2), () {
      // 一页数量太少，没有滚动条，导致ListView不能触发上滑
      if (
        widget.page == 1
        && _scrollController.position.maxScrollExtent == 0
      ) {
        onLoadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (_dataList.length > 0 && _dataList[_dataList.length-1][0] == null) _dataList.removeLast();
      if (_dataList.length > 1) _dataList.clear();
      _dataList.addAll(widget.dataList);
      _dataList.add({});
    });

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        itemCount: _dataList.length,
        itemBuilder: (BuildContext context, int index) {
          if (
            widget.dataList.length == 0 ||
            index == _dataList.length-1
          ) {
            return loadingItem();
          }
          return listItem(_dataList[index], index);
        }
      ),
    );
  }
}
