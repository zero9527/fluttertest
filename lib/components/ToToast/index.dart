import 'package:flutter/material.dart';
import 'dart:async';

/// Color(0xdf333333)
const initialColor = Color(0xdf333333); 
/// Color(0xfff6f6f6)
const initialTextColor = Color(0xfff6f6f6); 
/// Color(0x66000000)
const initialCoverScreenColor = Color(0x66000000);

class ToToast {
  /// ### Toast 提示小弹窗
  /// 
  /// * context: BuildContext `@required`
  /// * position：'top', 'center', 'bottom'; `default: 'center'`
  /// * color：背景颜色，`使用text，而不是child有效`
  /// * textColor：文字颜色，`使用text，而不是child有效`
  /// * autoCloseSeconds：自动关闭时间(秒), `default: 2`
  /// * borderRadius：圆角
  /// * type：类型样式：ToToast.success, ToToast.warning, ToToast.failed 
  /// * text: 文本
  /// * child：内容 Widget
  /// * coverScreen： true: 覆盖全屏，除提示框外，不可点击; `default: false`
  /// * useCloseHandler: true: 调用 toastCloseHandler 方式关闭; `default: false`
  
  ToToast({ 
    @required this.context,
    this.position = 'center', 
    this.padding = const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
    this.color = initialColor,
    this.textColor = initialTextColor,
    this.autoCloseSeconds = 2,
    this.borderRadius = 60,
    this.type,
    this.text,
    this.child,
    this.coverScreen = false,
    this.coverScreenColor = initialCoverScreenColor,
    this.useCloseHandler = false
  }) {
    _build(this.context);
  }

  /// context: BuildContext
  final BuildContext context;
  /// position：'top', 'center', 'bottom'; `default: 'center'`
  final String position;
  /// padding
  final EdgeInsetsGeometry padding;
  /// background
  final Color color;
  /// textColor
  final Color textColor;
  /// autoCloseSeconds: 自动关闭时间(秒)
  final int autoCloseSeconds;
  /// type: 类型样式：ToToast.success, ToToast.warning, ToToast.failed, 或自定义格式：
  /// ```
  /// static Map<String, dynamic> success = {
  ///  'color': Color(0xdf66bb61),
  ///  'textColor': Colors.white,
  ///  'icon': Icons.check_circle
  ///};
  /// ```
  final Map type;
  /// 圆角
  final double borderRadius;
  /// 文本
  final String text;
  /// child
  final Widget child;
  /// 覆盖全屏，除提示框外，不可点击
  final bool coverScreen;
  /// 覆盖全屏的背景色
  final Color coverScreenColor;
  /// 调用 toastCloseHandler 方式关闭
  /// ```
  /// var toast = ToToast(...);
  /// toast.toastCloseHandler();
  /// ```
  final bool useCloseHandler;

  /// type: 类型样式: success
  static Map<String, dynamic> success = {
    'color': Color(0xdf66bb61),
    'textColor': Colors.white,
    'icon': Icons.check_circle
  };
  
  /// type: 类型样式: warnning
  static Map warnning = {
    'color': Color(0xdfffa000),
    'textColor': Colors.white,
    'icon': Icons.info
  };

  /// type: 类型样式: failed
  static Map failed = {
    'color': Color(0xdfef5350),
    'textColor': Colors.white,
    'icon': Icons.not_interested
  };
  
  OverlayEntry overlayEntry;
  Timer autoCloseTimer;

  void _build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    // 自动关闭
    if (this.autoCloseSeconds != 0 && !useCloseHandler) {
      if (autoCloseTimer != null) autoCloseTimer.cancel(); 
      autoCloseTimer = Timer(Duration(seconds: this.autoCloseSeconds), () {
        toastCloseHandler();
      });
    }
    
    OverlayState overlaystate = Overlay.of(context);

    if (overlayEntry == null) {
      overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Stack(
          children: <Widget>[
            this.coverScreen
            ?  Container(
                width: screen.width,
                height: screen.height,
                color: this.coverScreenColor,
              )
            : Container(
              width: 0,
              height: 0,
            ),
            GestureDetector(
              onTap: toastClick,
              child: BuildToastContent(
                position: this.position, 
                padding: this.padding,
                color: this.color,
                textColor: this.textColor,
                autoCloseSeconds: this.autoCloseSeconds,
                borderRadius: this.borderRadius,
                type: this.type,
                text: this.text,
                child: this.child,
              ),
            ),
          ],
        ),
      );

      overlaystate.insert(overlayEntry);
    } else {
      overlayEntry.markNeedsBuild();
    }
  }

  /// 点击
  void toastClick() {
    if (this.autoCloseSeconds == 0) toastCloseHandler();
  }

  /// 关闭
  void toastCloseHandler() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
}

class BuildToastContent extends StatefulWidget {
  BuildToastContent({ 
    Key key,
    this.position,  
    this.padding,
    this.color,
    this.textColor,
    this.autoCloseSeconds,
    this.borderRadius,
    this.type,
    this.text,
    this.child,
  }) : super(key: key);

  /// position：'top', 'center', 'bottom'; `default: 'center'`
  final String position;
  /// padding
  final EdgeInsetsGeometry padding;
  /// background
  final Color color;
  /// textColor
  final Color textColor;
  /// autoCloseSeconds: 自动关闭时间(秒)
  final int autoCloseSeconds;
  /// type: 类型样式：ToToast.success, ToToast.warning, ToToast.failed 
  final Map type;
  /// 圆角
  final double borderRadius;
  /// 文本
  final String text;
  /// child
  final Widget child;

  @override
  BuildToastContentState createState() => BuildToastContentState();
}

class BuildToastContentState extends State<BuildToastContent> with TickerProviderStateMixin {
  BuildToastContentState() : super();

  Animation _slideAnimation;
  AnimationController _slideController;

  @override
  void initState() {
    Map tweenConfig = {
      'top': {
        'begin': 30.0,
        'end': 50.0
      },
      'center': {
        'begin': 0.0,
        'end': 0.0
      },
      'bottom': {
        'begin': 80.0,
        'end': 100.0
      },
    };

    _slideController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this
    );

    Tween<double> _tween = Tween<double>(
      begin: tweenConfig[widget.position]['begin'], 
      end: tweenConfig[widget.position]['end']
    );
    _slideAnimation = _tween.animate(_slideController);
    _slideAnimation.addListener(() {
      setState(() {});
    });

    _slideAnimation.addStatusListener((status) {});

    super.initState();
  }

  /// 构建内容
  Widget _buildToastContent() {
    // 公共部分内容
    Widget content = Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.92
      ),
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.type != null 
          ? widget.type['color']
          : widget.color,
        borderRadius: BorderRadius.all(
          Radius.circular(widget.borderRadius)
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            offset: Offset(0, 1),
          )
        ]
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _generateTypeIcon(),
          Flexible(
            child: widget.child != null
              ? widget.child
              : Text('${widget.text}', 
                  style: TextStyle(
                    color: widget.type != null ? widget.type['textColor'] : widget.textColor,
                    decoration: TextDecoration.none,
                    fontSize: 14
                  ), 
                  textAlign: TextAlign.center,
                ),
          ),
          closeHandler()
        ],
      ),
    );

    switch (widget.position) {
      case 'top':
        return Stack(
          children: <Widget>[
            Positioned(
              width: MediaQuery.of(context).size.width,
              top: _slideAnimation.value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  content
                ],
              )
            )
          ],
        );
      case 'bottom':
        return Stack(
          children: <Widget>[
            Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: _slideAnimation.value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  content
                ],
              )
            )
          ],
        );
      case 'center': 
        return Center(
          child: content,
        );
      default:
        return Center(
          child: content,
        );
    }
  }

  /// type 部位null时，显示类型图标
  Widget _generateTypeIcon() {
    return widget.type != null 
      ? Container(
        margin: const EdgeInsets.only(right: 10),
        child: Icon(widget.type['icon'], 
          color: widget.type != null 
            ? widget.type['textColor'] 
            : Colors.white,
          ),
      )
      : Container(width: 0, height: 0);
  }

  /// autoCloseSeconds: 为0时，显示关闭按钮 点击手动关闭
  Widget closeHandler() {
    return widget.autoCloseSeconds == 0
      ? Container(
        height: 16,
        width: 16,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: widget.type != null 
            ? widget.type['textColor'] 
            : Colors.white,
          shape: BoxShape.circle
        ),
        child: Icon(Icons.close, 
          size: 15, 
          color: widget.type != null 
            ? widget.type['color']
            : widget.color,
          ),
      )
      : Container(width: 0, height: 0);
  }
  
  @override
  Widget build(BuildContext context) {
    _slideController.forward();
    return _buildToastContent();
  }
}
