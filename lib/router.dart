import 'package:flutter/material.dart';
import 'views/Home/index.dart';
import 'views/ListPage/index.dart';
import 'views/DetailPage/index.dart';
import 'views/List-Custom/index.dart';
import 'views/Video/index.dart';

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
    case '/list-custom':
      return MaterialPageRoute(
        builder: (context) => ListCustom()
      );
    case '/video':
      return MaterialPageRoute(
        builder: (context) => Video()
      );
    default:
      return MaterialPageRoute(builder: (context) => Home());
  }
}