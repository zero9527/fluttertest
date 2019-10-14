import 'dart:async';

import 'package:flutter/material.dart';
import 'index.dart';
import 'loading-toast.dart';
import 'package:fluttertest/api/test-api.dart' as TestApi;

class ToastTest extends StatefulWidget {
  ToastTest({ Key key }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ToastTestState();
}

class ToastTestState extends State<ToastTest> with TickerProviderStateMixin {
  ToastTestState() : super();

  @override
  void initState() {
    // getFile();
    super.initState();
  }

  void getFile() async {
    var res = await TestApi.getFile();
    // print('res: $res');
  }

  void toggleToast({position, type, autoCloseSeconds = 2, text}) {
    ToToast(
      context: context,
      position: position,
      // text: 'Toast Component Toast Component, Toast组件测试测试ing Toast组件测试测试ing',
      text: text,
      type: type,
      autoCloseSeconds: autoCloseSeconds,
    );
  }

  /// loading
  void loading() {
    LoadingToToast toast = LoadingToToast(context: context);
    Timer(Duration(seconds: 2), () => toast.closeLoadingToToast());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text('Toast Test'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('normal'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () => toggleToast(position: 'top', text: 'Toast Component1'),
                      color: Colors.greenAccent,
                      child: Text('toast top'),
                    ),
                    RaisedButton(
                      onPressed: () => toggleToast(position: 'center', text: 'Toast Component1'),
                      color: Colors.greenAccent,
                      child: Text('toast center'),
                    ),
                    RaisedButton(
                      onPressed: () => toggleToast(position: 'bottom', text: 'Toast Component1'),
                      color: Colors.greenAccent,
                      child: Text('toast bottom'),
                    ),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('with type'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () => toggleToast(position: 'top', type: ToToast.warnning, text: 'Toast Component2'),
                      color: Colors.greenAccent,
                      child: Text('toast top'),
                    ),
                    RaisedButton(
                      onPressed: () => toggleToast(position: 'center', type: ToToast.success, text: 'Toast Component2'),
                      color: Colors.greenAccent,
                      child: Text('toast center'),
                    ),
                    RaisedButton(
                      onPressed: () => toggleToast(position: 'bottom', type: ToToast.failed, text: 'Toast Component2'),
                      color: Colors.greenAccent,
                      child: Text('toast bottom'),
                    ),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('autoCloseSeconds: 0'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () => toggleToast(position: 'top', type: ToToast.warnning, autoCloseSeconds: 0, text: 'Toast Component3'),
                      color: Colors.greenAccent,
                      child: Text('toast top'),
                    ),
                    RaisedButton(
                      onPressed: () => toggleToast(position: 'center', type: ToToast.success, autoCloseSeconds: 0, text: 'Toast Component3'),
                      color: Colors.greenAccent,
                      child: Text('toast center'),
                    ),
                    RaisedButton(
                      onPressed: () => toggleToast(position: 'bottom', type: ToToast.failed, autoCloseSeconds: 0, text: 'Toast Component3'),
                      color: Colors.greenAccent,
                      child: Text('toast bottom'),
                    ),
                  ],
                )
              ],
            ),
            Column(
              children: <Widget>[
                Text('cover loading'),
                RaisedButton(
                  onPressed: loading,
                  child: Text('show Loading'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
