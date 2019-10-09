import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertest/components/alert.dart';
import 'package:fluttertest/components/counter.dart';

class Test extends StatefulWidget {
  Test({ Key key }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TestState();
}

class TestState extends State<Test> {
  TestState() : super();
  String sdCardDir;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Counter(),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
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
        Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
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
            ],
          ),
        ),
        Container(
          child: RaisedButton(
            onPressed: () => goto(context, '/toast-test'),
            color: Colors.greenAccent,
            child: Text('toast-test'),
          ),
        ),
        Container(
          child: RaisedButton(
            color: Colors.black,
            textColor: Colors.white,
            onPressed: () => goto(context, '/file-manager', { 'sdCardDir': this.sdCardDir }),
            child: Text('FileManager'),
          ),
        ),
        RaisedButton(
          onPressed: _selectFile,
          child: Text('选择文件'),
        ),
        RaisedButton(
          onPressed: () => lauchUrl('https://flutter.dev'),
          child: Text('flutter.dev'),
        ),
      ],
    );
  }
}
