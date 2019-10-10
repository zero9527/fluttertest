import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({ Key key }) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  LoginState();

  String user_name = null;
  String password = null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                TextField(
                  decoration: new InputDecoration(
                    hintText: 'Type something',
                  ),
                ),
                Text('data'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
