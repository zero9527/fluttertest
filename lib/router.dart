import 'package:flutter/material.dart';
import 'views/Home/index.dart';
import 'views/ListComp/index.dart';
import 'views/Detail/index.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => Home());
    case '/list':
      return MaterialPageRoute(
        builder: (context) => ListComp()
      );
    case '/detail':
      return MaterialPageRoute(
        builder: (context) => Detail(params: settings.arguments)
      );
    default:
      return MaterialPageRoute(builder: (context) => Home());
  }
}