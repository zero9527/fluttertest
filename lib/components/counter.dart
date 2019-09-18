import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  Counter({ Key key }) : super(key: key);

  @override
  CounterState createState() => CounterState();
}

class CounterState extends State<Counter> {
  int count = 0;
 
  @override
  void initState() {
    super.initState();
  }

  void counter(type) {
    setState(() {
      switch (type) {
        case '-':
          count--;
          break;
        case '+':
          count++;
          break;
        default:
          count++; 
      }
    });
    print('count: $count');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () => counter('-'),
          icon: Icon(Icons.remove_circle_outline)
        ),
        Container(
          width: 100,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: Text('$count', style: TextStyle(
            fontSize: 30
          )),
        ),
        IconButton(
          onPressed: () => counter('+'),
          icon: Icon(Icons.add_circle_outline),
        ),
      ],
    );
  }
}
