import 'package:flutter/material.dart';

class List extends StatefulWidget {
  List({ Key key }) : super(key: key);

  @override
  ListState createState() => ListState();
}

class ListState extends State<List> {

  void toDetail(id) {
    Navigator.pushNamed(context, '/detail', arguments: id);
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
            RaisedButton(
              onPressed: () => toDetail(2333),
              child: Text('to detail'),
            ),
            Material(
              color: Colors.amber[100],
              child: InkWell(
                onTap: () => toDetail(1),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: <Widget>[
                      Text('list item 1')
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.amber[100],
              child: InkWell(
                onTap: () => toDetail(1),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: <Widget>[
                      Text('list item 2')
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
