import 'package:flutter/material.dart';

class ListComp extends StatefulWidget {
  final int page; // 页码
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BoxDecoration decoration;
  final List dataList; // 数据
  final bool hasMore; //  还有更多数据
  final String loadingText; // 请求时的提示
  final Widget loadingWidget; // 请求时的显示 Widget 
  final String nomoreText; // 没有更多数据的提示
  final Function listItemBuilder; // 每项显示的解构
  final Function itemClick; // 每项点击
  final Function onRefresh; // 下拉刷新
  final Function onLoadMore; // 上拉加载

  ListComp({
    Key key,
    @required this.dataList,
    @required this.hasMore,
    this.page = 1,
    this.decoration,
    this.margin,
    this.padding = const EdgeInsets.all(10),
    this.loadingText = '拼命加载中...',
    this.loadingWidget,
    this.nomoreText = '----- 我是有底线的 -----',
    this.itemClick,
    @required this.listItemBuilder,
    @required this.onRefresh,
    @required this.onLoadMore,
  }) : super(key: key);

  @override
  ListState createState() => ListState();
}

class ListState extends State<ListComp> {
  List _dataList = [];
  String listBottomText = '上滑加载更多';
  bool isReachBottom = true; // 是否到达底部
  final ScrollController _scrollController = ScrollController();

  ListState() : super() {
    _scrollController.addListener(onListScroll);
  }

  // 列表滚动
  void onListScroll() {
    // 是否到达底部
    bool reachBottom = _scrollController.position.pixels == _scrollController.position.maxScrollExtent;
    if (reachBottom) {
      setState(() {
        isReachBottom = true;
      });
      onLoadMore();
    }
  }

  // 监听一次 build 渲染完成
  void layoutRenderedListener() {
    WidgetsBinding.instance.addPostFrameCallback(layoutRenderedCallback);
  }

  void layoutRenderedCallback(Duration duration) {
    // 如果列表数据不多，没有滚动条，导致 ListView 不能触发下拉刷新、上滑等手势，
    // 则继续加载下一页
    if (_scrollController.position.maxScrollExtent == 0) {
      onLoadMore();
    } else {
      setState(() {
        isReachBottom = false;
      });
    }
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
    layoutRenderedListener();
    return widget.onRefresh();
  }

  Widget listItem(item, int index) {
    return Container(
      margin: widget.margin,
      padding: const EdgeInsets.all(0),
      decoration: widget.decoration,
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
                ? isReachBottom ? widget.loadingWidget : greyText(listBottomText)
                : isReachBottom ? greyText(widget.loadingText) : greyText(listBottomText))
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
    layoutRenderedListener();
    super.didUpdateWidget(oldWidget);
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
