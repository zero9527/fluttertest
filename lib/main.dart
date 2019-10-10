import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'views/StartScreen/index.dart';
import 'router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({ Key key }) : super(key: key) {

    // 沉浸式状态栏
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   // primarySwatch: Colors.blue,
      // ),
      home: StartScreen(), // Home()
      initialRoute: '/',
      onGenerateRoute: generateRoute,
    );
  }
}
