import 'package:flutter/material.dart';

class ListComp extends StatelessWidget {
  final int page; // 页码
  final List dataList; // 数据
  final bool hasMore; //  还有更多数据
  final String loadingText; // 请求时的提示
  final String nomoreText; // 没有更多数据的提示
  final Function listItemBuilder; // 每项显示的解构
  final Function itemClick; // 每项点击
  final Function onRefresh; // 下拉刷新
  final Function onLoadMore; // 上滑加载

  final ScrollController _scrollController = ScrollController();

  ListComp({
    Key key,
    @required this.dataList,
    @required this.hasMore,
    this.page = 1,
    this.loadingText = '拼命加载中...',
    this.nomoreText = '--- 我是有底线的 ---',
    this.listItemBuilder,
    this.itemClick,
    @required this.onRefresh,
    @required this.onLoadMore,
  }) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
        onLoadMore();
      }
    });
  }

  void listItemClick(item) {
    if (itemClick != null) itemClick(item);
  }

  Widget listItem(item, int index) {
    return Container(
      padding: index == 0 
        ? const EdgeInsets.fromLTRB(8, 10, 8, 10)
        : const EdgeInsets.fromLTRB(8, 0, 8, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: [BoxShadow(
          color: Color.fromRGBO(0, 0, 0, .4),
          offset: Offset(0, 0.5),
          blurRadius: 1.0,
          spreadRadius: -10.0
        )]
      ),
      child: FlatButton(
        padding: const EdgeInsets.all(20),
        onPressed: () => listItemClick(item),
        color: Colors.white,
        child: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: listItemBuilder(item),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget loadingItem() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(hasMore ? '$loadingText' : '$nomoreText' , style: TextStyle(
            color: Colors.grey
          ),)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: dataList.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == dataList.length-1) return loadingItem();
                return listItem(dataList[index], index);
              }
            ),
          ),
        ],
      )
    );
  }
}
