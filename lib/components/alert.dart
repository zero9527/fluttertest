import 'package:flutter/material.dart';

// 基于 AlertDialog 封装的弹窗
class Alert {
  /// 所有参数可选，
  /// 默认 两个按钮“确定”，“取消”，可传“confirmText”，“cancelText”或自定义内容“actions”；
  /// 方法可选，使用默认按钮时，有两个方法“onConfirm”，“onCancel”
  BuildContext context;
  Widget title; 
  Widget content;
  List<Widget> actions;
  bool barrierDismissible;
  String confirmText;
  String cancelText;
  Function onConfirm;
  Function onCancel;

  // 构造函数
  Alert({ 
    Key key,
    @required this.context, 
    this.title, 
    this.content, 
    this.actions, 
    this.barrierDismissible = false,
    this.confirmText = '确定',
    this.cancelText = '取消',
    this.onConfirm,
    this.onCancel
  }) {
    init();
  }

  void init() {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible, // 点击背景关闭
      builder: (BuildContext context) {
        return AlertDialog(
          title: title, 
          content: content,
          actions: actions != null 
            ? actions 
            : <Widget>[
              FlatButton(
                textColor: Colors.blue,
                child: Text('$confirmText'),
                onPressed: (){
                  // print('$confirmText');
                  if (onConfirm != null) onConfirm();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                textColor: Colors.red,
                child: Text('$cancelText'),
                onPressed: (){
                  // print('$cancelText');
                  if (onCancel != null) onCancel();
                  Navigator.of(context).pop();
                },
              ),
            ]
        );
      }
    );
  }
}
