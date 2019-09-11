import 'package:flutter/material.dart';
import 'views/Home/index.dart';
import 'views/List/index.dart';
import 'views/Detail/index.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => Home());
    case '/list':
      return MaterialPageRoute(
        builder: (context) => List()
      );
    case '/detail':
      var arguments = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => Detail(id: arguments)
      );
    default:
      return MaterialPageRoute(builder: (context) => Home());
  }
}