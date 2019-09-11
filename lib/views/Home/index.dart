import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title, this.onChange}) : super(key: key);

  final String title;
  final Function onChange;

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int count = 0;
  Function onChange = () => {};
 
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
    // print('count: $count');
    widget.onChange(count);
  }

  void showTitle() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('标题'), 
          content: Text('哈哈哈'),
          actions:<Widget>[
            FlatButton(
              child: Text('YES'),
              onPressed: (){
                print('yes...');
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('NO'),
              onPressed: (){
                print('no...');
                Navigator.of(context).pop();
              },
            ),
          ]
        );
      });
  }

  void toList() {
    Navigator.pushNamed(context, '/list');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Home Page'),
      ),
      body: Column(
        children: <Widget>[
          Row(
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
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () => showTitle(),
                  child: Text('显示Title'),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: toList,
                  child: Text('to list'),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}
