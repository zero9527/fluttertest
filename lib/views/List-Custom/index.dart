import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ListCustom extends StatefulWidget {
  ListCustom({ Key key }) : super(key: key);
  
  @override
  ListCustomState createState() => ListCustomState();
}

class ListCustomState extends State<ListCustom> {
  ScrollController onListScrollController = ScrollController();

  ListCustomState() : super() {
    Future.delayed(Duration(seconds: 1), () {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    });
    
    onListScrollController.addListener(() {
      double pixels = onListScrollController.position.pixels;
      SystemChrome.setSystemUIOverlayStyle(
        pixels < MediaQuery.of(context).padding.top 
          ? SystemUiOverlayStyle.dark 
          : SystemUiOverlayStyle.light
      );
    });
  }

  @override
  void didUpdateWidget(ListCustom oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView.custom(
        physics: BouncingScrollPhysics(),
        controller: onListScrollController,
        childrenDelegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text('ListView.custom', style: TextStyle(
                  fontSize: 20
                ),),
              ),
              Image.asset('lib/assets/images/2019-09-20_15_12_12.gif'),
            ],
          );
        }, childCount: 1),
      ),
    );
  }
}
