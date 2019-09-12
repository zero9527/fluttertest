import 'package:flutter/material.dart';

abstract class IListItem {
  int id;
  String text;
}

class ListComp extends StatefulWidget {
  ListComp({ Key key }) : super(key: key);

  @override
  ListState createState() => ListState();
}

class ListState extends State<ListComp> {
  List dataList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      dataList = [
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
        { 'id': 11, 'text': 'list item 11' },
        { 'id': 12, 'text': 'list item 12' },
      ];
    });
  }

  void toDetail(String text, int id) {
    Navigator.pushNamed(context, '/detail', arguments: { 'id': id, 'text': text });
  }

  Widget listItem(item, int index) {
    return Material(
      // color: Colors.amber[100],
      child: InkWell(
        onTap: () => toDetail(item['text'], index+1),
        // highlightColor: Color.fromRGBO(220, 220, 220, .1),
        child: Container(
          padding: index == 0 
            ? const EdgeInsets.fromLTRB(8, 10, 8, 10)
            : const EdgeInsets.fromLTRB(8, 0, 8, 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.amber[100],
              borderRadius: BorderRadius.all(Radius.circular(4)),
              boxShadow: [BoxShadow(
                color: Color.fromRGBO(0, 0, 0, .4),
                offset: Offset(0, 0.5),
                blurRadius: 1.0,
                spreadRadius: -1.0
              )]
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(item['text']),
                )
              ],
            )
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Page'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              color: Colors.amberAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('嘿嘿嘿'),
                ],
              ),
            ),
            Flexible(
              child: ListView.builder(
                // shrinkWrap: true,
                // scrollDirection: Axis.vertical,
                itemCount: this.dataList.length,
                itemBuilder: (BuildContext context, int index) => 
                  listItem(this.dataList[index], index),
              ),
            )
          ],
        ),
      ),
    );
  }
}
