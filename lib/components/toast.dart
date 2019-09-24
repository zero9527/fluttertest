import 'package:flutter/material.dart';

class Toast extends Dialog {
  Toast({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency, //透明类型
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.white,
          child: Center(child: Text('toast'),),
        ),
      )
    );
  }
}
