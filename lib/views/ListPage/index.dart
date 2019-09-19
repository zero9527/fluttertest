import 'package:flutter/material.dart';
import 'package:fluttertest/components/list-comp.dart';

abstract class IListItem {
  int id;
  String text;
}

class ListPage extends StatefulWidget {
  ListPage({ Key key }) : super(key: key);

  @override
  ListState createState() => ListState();
}

class ListState extends State<ListPage> {
  int page = 0;
  List dataList = [];
  bool hasMore = true;
  final initialList = [
    { 'id': 1, 'text': 'list item 1list item 1list item 1list item 1list item 1list item 1list item 1list item 1' },
    { 'id': 2, 'text': 'list item 2list item 2list item 2list item 2list item 2list item 2list item 2' },
    { 'id': 3, 'text': 'list item 3' },
    { 'id': 4, 'text': 'list item 4' },
    { 'id': 5, 'text': 'list item 5' },
    { 'id': 6, 'text': 'list item 6' },
    { 'id': 7, 'text': 'list item 7' },
    { 'id': 8, 'text': 'list item 8' },
    { 'id': 9, 'text': 'list item 9' },
    { 'id': 10, 'text': 'list item 10' },
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      loadMore();
    });
  }

  Future<void> onRefresh() async {
    setState(() {
      hasMore = true;
      page = 1;
    });
    await Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        // dataList = initialList;
        dataList.clear();
        dataList.addAll(initialList);
      });
    });
  }

  Future<void> loadMore() async {
    if (!hasMore) return;
    setState(() {
      ++page;
    });
    final moreList = [];
    List.generate(10, (int index) {
      moreList.add(
        { 'id': dataList.length+index+1, 'text': 'list item ${dataList.length+index+1}' }
      );
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        dataList.addAll(moreList);
        if (page >= 3) hasMore = false;
      });
    });

  }

  void toDetail(item) {
    Navigator.pushNamed(context, '/detail', arguments: { 'id': item['id'], 'text': item['text'] });
  }

  Widget listItemBuilder(item) {
    return Text('${item['text']}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Page'),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ListComp(
              page: page,
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue
                ),
              ),
              // padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              hasMore: hasMore,
              dataList: dataList,
              skeletonLoading: true,
              // itemClick: (item) => toDetail(item),
              onRefresh: onRefresh,
              onLoadMore: loadMore,
              listItemBuilder: (item) => listItemBuilder(item),
            ),
            Positioned(
              bottom: 30,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(220, 220, 220, .6),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x00000000), 
                      offset: Offset(0, 1.0),
                      blurRadius: 1.0,
                      spreadRadius: 1.0
                    )
                  ]
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('$page/', style: TextStyle(fontSize: 20, color: Colors.black45),),
                    Text('${dataList.length}', style: TextStyle(color: Colors.black26),)
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
