import 'package:flutter/material.dart';
import 'package:fluttertest/api/detail.dart' as DetailApi;

class Detail extends StatefulWidget {
  Detail({ Key key, this.params }) : super(key: key);

  final params;

  @override
  DetailState createState() => DetailState();
}

class DetailState extends State<Detail> {
  var detailTitle = '';

  @override
  void initState() {
    super.initState();
    getList();
    uploadFile();
    setState(() {
      detailTitle = 'Detail_${widget.params['id']}';
    });
  }

  void getList() async {
    var res = await DetailApi.getFile({ 'date': DateTime.now().toString() });
    print('res: $res');
  }

  void uploadFile() async {
    var res = await DetailApi.uploadFile({ 'date': DateTime.now().toString() });
    print('res: $res');
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
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.green[50],
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4.0),
                color: Color.fromRGBO(0, 0, 0, .4),
                blurRadius: 2.0,
                spreadRadius: -4.0,
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
              Text('detail-id: ${widget.params['id']}', style: TextStyle(
                fontSize: 20
              ),),
            ],
          )
        )
      ),
    );
  }
}
