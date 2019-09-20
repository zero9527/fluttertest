import 'package:flutter/material.dart';
import 'views/Home/index.dart';
import 'views/ListPage/index.dart';
import 'views/DetailPage/index.dart';
import 'views/TestPage/index.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => Home());
    case '/list':
      return MaterialPageRoute(
        builder: (context) => ListPage()
      );
    case '/detail':
      return MaterialPageRoute(
        builder: (context) => DetailPage(params: settings.arguments)
      );
    case '/test-page':
      return MaterialPageRoute(
        builder: (context) => TestPage()
      );
    default:
      return MaterialPageRoute(builder: (context) => Home());
  }
}