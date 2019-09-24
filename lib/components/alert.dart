import 'package:flutter/material.dart';

class Alert {
  /// ### 基于 AlertDialog 封装的弹窗
  /// 
  /// 所有参数可选，
  /// * 默认 两个按钮“确定”，“取消”，可传“confirmText”，“cancelText”或自定义内容“actions”；
  /// * 方法可选，使用默认按钮时，有两个方法“onConfirm”，“onCancel”
  /// 
  /// ### 属性：
  /// * title：标题
  /// * content：内容
  /// * actions：按钮
  /// * barrierDismissible：点击背景关闭
  /// * confirmText：确认按钮的文字
  /// * cancelText：取消按钮的文字
  /// * onConfirm：确认的回调
  /// * onCancel：取消的回调
  /// 
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

  BuildContext context;
  /// 标题
  Widget title; 
  /// 内容
  Widget content;
  /// 按钮
  List<Widget> actions;
  /// 点击背景关闭
  bool barrierDismissible;
  /// 确认按钮的文字
  String confirmText;
  /// 取消按钮的文字
  String cancelText;
  /// 确认的回调
  Function onConfirm;
  /// 取消的回调
  Function onCancel;

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
