import 'package:flutter/material.dart';
import 'package:fluttertest/api/detail.dart' as DetailApi;

class DetailPage extends StatefulWidget {
  DetailPage({ Key key, this.params }) : super(key: key);

  final params;

  @override
  DetailState createState() => DetailState();
}

class DetailState extends State<DetailPage> {
  var detailTitle = '';

  @override
  void initState() {
    super.initState();
    // getList();
    // uploadFile();
    setState(() {
      detailTitle = 'Detail_${widget.params['id']}';
    });
  }

  Future<void> getList() async {
    var res = await DetailApi.getFile({ 'date': DateTime.now().toString() });
    print('res: $res');
  }

  Future<void> uploadFile() async {
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
          child: Card(
            child: FlatButton(
              onPressed: () => Navigator.of(context).pop(),
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
              ),
            ),
          )
        )
      ),
    );
  }
}
