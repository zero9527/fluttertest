import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  Detail({ Key key, this.id }) : super(key: key);

  final id;

  @override
  DetailState createState() => DetailState();
}

class DetailState extends State<Detail> {
  var detailTitle = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      detailTitle = 'Detail_${widget.id}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(detailTitle),
      ),
      body: Center(
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width*90/100,
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 16.0),
                color: Color.fromRGBO(0, 0, 1, .5),
                blurRadius: 20.0,
                spreadRadius: -10.0,
              ),
            ],
          ),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('呵呵呵', style: TextStyle(
                fontSize: 20
              ),),
              Text('detail-id: ${widget.id}', style: TextStyle(
                fontSize: 20
              ),),
            ],
          )
        )
      ),
    );
  }
}
