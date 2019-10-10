import 'package:flutter/material.dart';
import 'package:fluttertest/BLoC/count_bloc.dart';
import 'package:fluttertest/BLoC/global_bloc.dart';

class Counter extends StatelessWidget {
  Counter({ Key key }) : super(key: key);

  void decrease() {
    countBLoC.decrease();
    globalBLoC.setIsLogin(!globalBLoC.isLogin);
  }

  void increment() {
    countBLoC.increment();
    globalBLoC.setIsLogin(!globalBLoC.isLogin);
  }
 
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text('  BLoC 测试: '),
        IconButton(
          onPressed: decrease,
          icon: Icon(Icons.remove_circle_outline)
        ),
        StreamBuilder(
          stream: countBLoC.stream,
          initialData: countBLoC.count,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Text('  ${countBLoC.count}  ', style: TextStyle(
              fontSize: 20
            ),);
          },
        ),
        IconButton(
          onPressed: increment,
          icon: Icon(Icons.add_circle_outline),
        ),
      ],
    );
  }
}
