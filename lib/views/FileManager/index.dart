import 'dart:io';
import 'package:flutter/material.dart';

class FileManager extends StatefulWidget {
  /// File Manager
  /// 
  /// * sdCardDir： sd 卡根目录
  FileManager({
    Key key,
    this.params
  }) : super(key: key);

  final Map params;

  @override
  State<StatefulWidget> createState() => FileManagerState();
}

class FileManagerState extends State<FileManager> {
  FileManagerState() : super();

  /// 当前路径
  String currentDir = '/';
  /// 滚动条位置
  double listScrollTop = 0;
  /// 当前路径的文件集合
  List fileList = [];
  bool shouldExit = false;

  // MethodChannel _channel = MethodChannel('openFileChannel');

  @override
  void initState() {
    this.setFileListByDir(widget.params['sdCardDir']);
    super.initState();
  }

  void exitFileManager() {
    setState(() {
      shouldExit = true;
    });
    Navigator.of(context).pop();
  }

  void setFileListByDir(String dir) {
    List sdDir = Directory(dir).listSync();
    List list = [];

    // 按字母排序
    sdDir.sort((a, b) {
      String fa = a.path.substring(a.path.lastIndexOf('/')+1);
      String fb = b.path.substring(b.path.lastIndexOf('/')+1);
      return fa.compareTo(fb);
    });

    sdDir.forEach((item) {
      bool isDir = this.isDirectory(item.path);
      list.add({
        'path': item.path,
        'type': isDir ? 'dir' : 'file',
        'icon': isDir ? Icons.folder : Icons.text_fields,
        'name': item.path.substring(item.path.lastIndexOf('/')+1),
        'num': isDir ? Directory(item.path).listSync().length : 0
      });
    });

    setState(() {
      this.currentDir = dir;
      fileList.clear();
      fileList = list.toList();
    });
  }

  bool isDirectory(path) {
    return FileSystemEntity.isDirectorySync(path);
  }

  void fileItemClick(item) {
    if (this.isDirectory(item['path'])) {
      this.setFileListByDir(item['path']);
    }
  }

  Widget fileItemBuilder(item) {
    return this.fileList.length == 0
      ? Center(child: Text('文件夹为空！'),)
      : FlatButton(
        onPressed: () => this.fileItemClick(item),
        padding: const EdgeInsets.all(0),
        child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xffd6d6d6))
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  item['icon'],
                  color: Colors.cyan,
                ),
                Text('  ${item['name']}'),
              ],
            ),
            Row(
              children: <Widget>[
                Text('${item['num']} 项', style: TextStyle(
                  color: Colors.grey
                ),),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: exitFileManager,
          icon: Icon(Icons.arrow_back),
          tooltip: 'back',
        ),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('File Manager', style: TextStyle(color: Colors.white),),
      ),
      body: WillPopScope(
        onWillPop: () {
          // 点击导航栏箭头，而不是返回键时 退出
          if (shouldExit) return Future.value(true);

          if (currentDir != widget.params['sdCardDir']) {
            setFileListByDir(Directory(currentDir).parent.path);
            // jumpToPosition(false);
          } else {
            Navigator.of(context).pop();
          }
          return Future.value(false);
        },
        child: Column(
          children: <Widget>[
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              color: Color(0xffeeeeee),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Text('$currentDir')
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: this.fileList.length == 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Column(
                  children: <Widget>[
                    Text('文件夹为空！', style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey
                    ),),
                    // Icon(Icons.no)
                  ],
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: this.fileList.length,
                itemBuilder: (BuildContext context, int index) {
                  return this.fileItemBuilder(this.fileList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
