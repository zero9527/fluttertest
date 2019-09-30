import 'package:flutter/material.dart';
import 'package:fluttertest/components/alert.dart';
import 'package:fluttertest/components/counter.dart';
import 'package:fluttertest/components/menu-popup.dart';

class Home extends StatefulWidget {
  Home({
    Key key,
    this.sdCardDir,
  }) : super(key: key);

  final String sdCardDir;

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  void goto(BuildContext context, String routeName, [Map params]) {
    Navigator.pushNamed(context, routeName, arguments: params);
  }

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
                      onPressed: () => goto(context, '/list'),
                      child: Text('List'),
                    ),
                    RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blueAccent,
                      onPressed: () => goto(context, '/list-custom'),
                      child: Text('List Custom'),
                    ),
                    RaisedButton(
                      color: Colors.amberAccent,
                      onPressed: () => goto(context, '/video'),
                      child: Text('Video'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: RaisedButton(
              onPressed: () => goto(context, '/toast-test'),
              color: Colors.greenAccent,
              child: Text('toast-test'),
            ),
          ),
          Container(
            child: RaisedButton(
              color: Colors.black,
              textColor: Colors.white,
              onPressed: () => goto(context, '/file-manager', { 'sdCardDir': widget.sdCardDir }),
              child: Text('FileManager'),
            ),
          ),
        ],
      )
    );
  }
}
