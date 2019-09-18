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
  int page = 1;
  List dataList = [];
  bool hasMore = true;
  final initialList = [
    { 'id': 1, 'text': 'list item 1list item 1list item 1list item 1list item 1list item 1list item 1list item 1' },
    { 'id': 2, 'text': 'list item 2' },
    { 'id': 3, 'text': 'list item 3' },
    { 'id': 4, 'text': 'list item 4' },
    { 'id': 5, 'text': 'list item 5' },
    { 'id': 6, 'text': 'list item 6' },
    { 'id': 7, 'text': 'list item 7' },
    { 'id': 8, 'text': 'list item 8' },
    { 'id': 9, 'text': 'list item 9' },
    { 'id': 10, 'text': 'list item 10' },
    {}
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      dataList.addAll(initialList);
    });
  }

  Future<void> onRefresh() async {
    setState(() {
      hasMore = true;
      page = 1;
    });
    await Future.delayed(const Duration(seconds: 1), () {
      setState(() {
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
    final moreList = [
      { 'id': 11, 'text': 'list item 11' },
      { 'id': 12, 'text': 'list item 12' },
      { 'id': 13, 'text': 'list item 13' },
      { 'id': 14, 'text': 'list item 14' },
      { 'id': 15, 'text': 'list item 15' },
    ];

    List(5).map((item) {
      print(item);
    });

    await Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        dataList.removeLast();
        dataList.addAll(moreList);
        dataList.add({});
        if (page == 3) hasMore = false;
      });
    });
  }

  void toDetail(item) {
    Navigator.pushNamed(context, '/detail', arguments: { 'id': item['id'], 'text': item['text'] });
  }

  Widget listItemChild(item) {
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
              hasMore: hasMore,
              dataList: dataList,
              itemClick: (item) => toDetail(item),
              onRefresh: onRefresh,
              onLoadMore: loadMore,
              listItemBuilder: (item) => listItemChild(item),
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
                    Text('${dataList.length-1}', style: TextStyle(color: Colors.black26),)
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
