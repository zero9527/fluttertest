import 'dart:async';
import 'package:flutter/material.dart';

class GlobalBLoC {
  bool _isLogin;
  Color _themeColor; // 状态栏背景色
  Color _themeTextColor; // 状态栏文本色
  StreamController _globalController;

  GlobalBLoC() {
    _isLogin = false;
    _themeColor = Colors.blue;
    _globalController = StreamController.broadcast();
  }

  bool get isLogin => _isLogin;
  Color get themeColor => _themeColor;
  Color get themeTextColor => _themeTextColor;
  Stream get stream => _globalController.stream;

  void setIsLogin(bool isLogin) {
    _globalController.sink.add(_isLogin = isLogin);
  }

  void setTheme({@required Color themeColor, Color themeTextColor = Colors.white}) {
    _globalController.sink.add(_themeColor = themeColor);
    _globalController.sink.add(_themeTextColor = themeTextColor);
  }

  dispose() {
    _globalController.close();
  }
}

GlobalBLoC globalBLoC = GlobalBLoC();
