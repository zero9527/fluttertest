import 'package:flutter/material.dart';
import 'package:fluttertest/components/menu-popup.dart';
import 'package:fluttertest/components/test.dart';

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
      body: Test(),
    );
  }
}
