import 'package:flutter/material.dart';
import 'package:fluttertest/BLoC/count_bloc.dart';

class Counter extends StatelessWidget {
  /// 使用 BloC 
  Counter({ Key key }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text('  BLoC 测试: '),
        IconButton(
          onPressed: () => bloC.decrease(),
          icon: Icon(Icons.remove_circle_outline)
        ),
        StreamBuilder(
          stream: bloC.stream,
          initialData: bloC.value,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Text('  ${snapshot.data}  ', style: TextStyle(
              fontSize: 20
            ),);
          },
        ),
        IconButton(
          onPressed: () => bloC.increment(),
          icon: Icon(Icons.add_circle_outline),
        ),
      ],
    );
  }
}
