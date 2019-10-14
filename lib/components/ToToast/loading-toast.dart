import 'package:flutter/material.dart';
import 'index.dart';

const initialColor = Color(0x99000000);

class LoadingToToast {
  /// ### 基于 ToToast 的封装
  /// 
  /// ```
  /// // 示例
  /// LoadingToToast toast = LoadingToToast(context: context);
  /// Timer(Duration(seconds: 2), () => toast.closeLoadingToToast());
  /// ```
  /// 
  LoadingToToast({
    @required this.context,
    this.loadingText = '加载中...',
    this.color = initialColor,
    this.child
  }) {
    init();
  }

  final BuildContext context;
  final String loadingText;
  final Color color;
  final Widget child; 

  var toast;

  void init() {
    toast = ToToast(
      context: this.context,
      borderRadius: 2,
      coverScreen: true,
      useCloseHandler: true,
      coverScreenColor: this.color,
      color: Color(0x99000000),
      child: child ?? Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(this.loadingText, 
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 调用关闭
  void closeLoadingToToast() {
    toast?.toastCloseHandler();
  }
}
