import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestPage extends StatefulWidget {
  TestPage({ Key key }) : super(key: key);
  
  @override
  TestState createState() => TestState();
}

class TestState extends State<TestPage> {
  TestState() : super() {
    // 无效
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // brightness: Brightness.dark, // 无效
        title: Text('Test Page', style: TextStyle(
          color: Colors.white,
        ),),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('lib/assets/images/2019-09-20_15_12_12.gif', width: 100,)
        ],
      ),
    );
  }
}
