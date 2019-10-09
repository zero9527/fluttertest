import 'dart:async';
import 'package:flutter/material.dart';

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
    if (lastSeconds == 0) {
      Navigator.pushNamed(context, '/home');
      return;
    }
    setState(() {
      lastSeconds--;
    });
    timer = Timer(Duration(seconds: 1), countDown);
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
      body: Container(
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
            ),)
          ],
        ),
      ),
    );
  }
}
