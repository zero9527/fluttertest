import 'package:flutter/material.dart';

class ListComp extends StatefulWidget {
  ListComp({Key key, this.title, this.onChange}) : super(key: key);

  final String title;
  final Function onChange;

  @override
  ListState createState() => ListState();
}

class ListState extends State<ListComp> {
  int count = 0;
  Function onChange = () => {};

  @override
  void initState() {
    // TODO: implement initState
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

  void showTitle(title) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('标题：$title'), 
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orangeAccent
          ),
          child: Text('ListComp', style: TextStyle(
            fontSize: 20
          )),
        ),
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
        Row(
          children: <Widget>[
            RaisedButton(
              onPressed: () => showTitle(widget.title),
              color: Colors.blueAccent,
              textColor: Colors.white,
              child: Row(
                children: <Widget>[
                  Icon(Icons.info_outline, size: 18,),
                  Container(
                    padding: const EdgeInsets.only(left: 6),
                    child: Text('显示Title'),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
