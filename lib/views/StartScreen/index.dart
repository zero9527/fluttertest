import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertest/views/Home/index.dart';

class StartScreen extends StatefulWidget {
  StartScreen({ Key key }) : super(key: key);

  @override
  State<StatefulWidget> createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {
  StartScreenState() : super();
  
  int lastSeconds = 3;
  Timer timer;

  @override
  void initState() {
    countDown();
    super.initState();
  }

  void countDown() {
    setState(() {
      lastSeconds--;
    });
    if (lastSeconds == 0) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (BuildContext context) => Home()
      ));
    } else {
      timer = Timer(Duration(seconds: 1), countDown);
    }
  }

  /// 点击跳过
  void toHome() {
    timer.cancel();
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (BuildContext context) => Home()
    ));
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size; 
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 50),
            width: screenSize.width,
            height: screenSize.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/start-screen.jpeg'),
                fit: BoxFit.cover
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text('Flutter Test 启动屏！', style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),),
                Text('倒计时: $lastSeconds s', style: TextStyle(
                  color: Colors.white
                ),),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 20,
            child: FlatButton(
              onPressed: toHome,
              color: Color(0x22ffffff),
              padding: const EdgeInsets.all(12),
              shape: CircleBorder(),
              child: Text('跳过', style: TextStyle(
                color: Colors.white
              ),),
            ),
          ),
        ],
      ),
    );
  }
}
