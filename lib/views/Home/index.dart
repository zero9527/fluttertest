import 'package:flutter/material.dart';
import 'package:fluttertest/components/alert.dart';
import 'package:fluttertest/components/counter.dart';
import 'package:fluttertest/components/menu-popup.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Home Page'),
            MenuPopup(),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Counter(),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () => Alert(
                    context: context,
                    title: Text('标题1'),
                    content: Text('内容1'),
                    confirmText: 'Yes',
                    cancelText: 'No',
                    onConfirm: () => print('confirm1'),
                    onCancel: () => print('oncancel1')
                  ),
                  child: Text('显示弹窗1'),
                ),
                RaisedButton(
                  onPressed: () => Alert(
                    context: context,
                    // title: Text('标题2'),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('内容2')
                      ],
                    ),
                    onConfirm: () => print('确定'),
                    onCancel: () => print('取消')
                  ),
                  child: Text('显示弹窗2'),
                ),
                
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    RaisedButton(
                      color: Color(0xffffffff),
                      onPressed: () => Navigator.pushNamed(context, '/list'),
                      child: Text('List'),
                    ),
                    RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blueAccent,
                      onPressed: () => Navigator.pushNamed(context, '/test-page'),
                      child: Text('Test Page'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
        ],
      )
    );
  }
}
