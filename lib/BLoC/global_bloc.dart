import 'package:flutter/material.dart';
// import 'dart:async';

class GlobalBLoC {
  Color _themeColor;
  // StreamController _globalController;

  GlobalBLoC() {
    _themeColor = Colors.blue;
  }

  Color get theme => _themeColor;
  // StreamController get stream => _globalController;

  setTheme(Color color) {
    _themeColor = color;
    // _globalController.sink.add((){
    //   _themeColor = color;
    // });
  }

  // dispose() {
  //   _globalController.close();
  // }
}

GlobalBLoC globalBLoC = GlobalBLoC();
