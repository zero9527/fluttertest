import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertest/BLoC/global_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertest/components/alert.dart';
import 'package:fluttertest/components/counter.dart';
import 'package:fluttertest/components/app-update.dart';

class Test extends StatefulWidget {
  Test({ Key key }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TestState();
}

class TestState extends State<Test> {
  String sdCardDir;

  TestState() : super();

  @override
  void initState() {
    getPermission();
    super.initState();
  }

  Future<void> getSDCardDir() async {
    /// path_provider: v1.1.0 之后 getExternalStorageDirectory 获取的就不是SD卡根目录了。。。
    String _sdCardDir = (await getExternalStorageDirectory()).path;
    setState(() {
      sdCardDir = _sdCardDir;
    });
  }

   // Permission check
  Future<void> getPermission() async {
    if (Platform.isAndroid) {
      PermissionStatus permission1 = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
      if (permission1.value != 2) {
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      }
      await getSDCardDir();
    } else if (Platform.isIOS) {
      await getSDCardDir();
    }
  }

  void goto(BuildContext context, String routeName, [Map params]) {
    Navigator.pushNamed(context, routeName, arguments: params);
  }

  void _selectFile() {
    FilePicker.getMultiFilePath(
      type: FileType.IMAGE,
    );
  }

  void lauchUrl(String url) {
    launch(url);
  }

  void changeTheme(Color color) {
    globalBLoC.setTheme(themeColor: color);
  }

  void inputChange(val) {
    print('input: $val');
  }

  @override
  Widget build(BuildContext context) {
    Widget comp({@required Widget child}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          child
        ],
      );
    }
    return ListView(
      children: <Widget>[
        Counter(),
        Counter(),
        comp(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () => Alert(
                  context: context,
                  title: Text('标题1'),
                  content: Text('内容1'),
                  confirmText: 'Yes',
                  cancelText: 'No',
                  onConfirm: () => print('confirm1'),
                  onCancel: () => print('oncancel1')
                ),
                child: Text('显示弹窗1'),
              ),
              RaisedButton(
                onPressed: () => Alert(
                  context: context,
                  // title: Text('标题2'),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('内容2')
                    ],
                  ),
                  onConfirm: () => print('确定'),
                  onCancel: () => print('取消')
                ),
                child: Text('显示弹窗2'),
              ),
              
            ],
          ),
        ),
        comp(
          child: Column(
            children: <Widget>[
              RaisedButton(
                color: Color(0xffffffff),
                onPressed: () => goto(context, '/list'),
                child: Text('List'),
              ),
              RaisedButton(
                textColor: Colors.white,
                color: Colors.blueAccent,
                onPressed: () => goto(context, '/list-custom'),
                child: Text('List Custom'),
              ),
              RaisedButton(
                color: Colors.amberAccent,
                onPressed: () => goto(context, '/video'),
                child: Text('Video'),
              ),
            ],
          ),
        ),
        comp(
          child: RaisedButton(
            onPressed: () => goto(context, '/toast-test'),
            color: Colors.greenAccent,
            child: Text('toast-test'),
          ),
        ),
        comp(
          child: RaisedButton(
            color: Colors.black,
            textColor: Colors.white,
            onPressed: () => goto(context, '/file-manager', { 'sdCardDir': this.sdCardDir }),
            child: Text('FileManager'),
          ),
        ),
        // RaisedButton(
        //   onPressed: _selectFile,
        //   child: Text('选择图片'),
        // ),
        // RaisedButton(
        //   onPressed: () => lauchUrl('https://flutter.dev'),
        //   child: Text('https://flutter.dev'),
        //   color: Colors.white,
        // ),
        StreamBuilder(
          stream: globalBLoC.stream,
          initialData: globalBLoC.themeColor,
          builder: (ctx, snapshot) {
            return Text('当前主题颜色为：${globalBLoC.themeColor == Colors.green
              ? "Colors.blue"
              : "Colors.green"}', style: TextStyle(
                color: globalBLoC.themeColor
              ),);
          },
        ),
        Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () => changeTheme(Colors.blue),
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('设置主题颜色为：Colors.blue'),
            ),
            RaisedButton(
              onPressed: () => changeTheme(Colors.green),
              color: Colors.green,
              textColor: Colors.white,
              child: Text('设置主题颜色为：Colors.green'),
            ),
            TextField(
              onChanged: (val) => inputChange(val),
              keyboardType: TextInputType.multiline,
              decoration: new InputDecoration(
                fillColor: Colors.blue,
                labelText: '用户名',
                icon: Icon(Icons.person)
              ),
            ),
          ],
        ),
        AppInfo()
      ],
    );
  }
}
