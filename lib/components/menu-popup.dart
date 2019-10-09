import 'package:flutter/material.dart';

class MenuPopup extends StatefulWidget {
  MenuPopup({ Key key }) : super(key: key);

  @override
  MenuPopupState createState() => MenuPopupState();
}

class MenuPopupState extends State<MenuPopup> {
  int count = 0;
  String menuSelected = '';

  @override
  void initState() {
    super.initState();
  }

  void onSelected(result) {
    print('result: $result');
    setState(() {
      menuSelected = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // This menu button widget updates a _selection field (of type WhyFarther,
        // not shown here).
        PopupMenuButton<String>(
          offset: Offset(0, 100),
          onSelected: (String result) => onSelected(result),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem(
              value: 'harder',
              child: Text('Working a lot harder'),
            ),
            const PopupMenuItem(
              value: 'smarter',
              child: Text('Being a lot smarter'),
            ),
            const PopupMenuItem(
              value: 'selfStarter',
              child: Text('Being a self-starter'),
            ),
            const PopupMenuItem(
              value: 'tradingCharter',
              child: Text('Placed in charge of trading charter'),
            ),
          ],
        )
      ],
    );
  }
}
