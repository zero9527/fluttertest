import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:fluttertest/views/FileManager/index.dart';
import 'views/Home/index.dart';
import 'router.dart';

void main() {
  String sdCardDir;
  
  Future<void> getSDCardDir() async {
    /// path_provider: v1.1.0 之后 getExternalStorageDirectory 获取的就不是SD卡根目录了。。。
    sdCardDir = (await getExternalStorageDirectory()).path;
  }

   // Permission check
  Future<void> getPermission() async {
    if (Platform.isAndroid) {
      bool permission1 = await SimplePermissions.checkPermission(Permission.ReadExternalStorage);
      bool permission2 = await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
      if (!permission1) {
        await SimplePermissions.requestPermission(Permission.ReadExternalStorage);
      }
      if (!permission2) {
        await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
      }
      await getSDCardDir();
    } else if (Platform.isIOS) {
      await getSDCardDir();
    }
  }

  Future.wait([getPermission()]).then((_) {
    runApp(MyApp(sdCardDir: sdCardDir));
  });

}

class MyApp extends StatelessWidget {
  MyApp({
    Key key,
    this.sdCardDir,
  }) : super(key: key);

  final String sdCardDir;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: Home(sdCardDir: sdCardDir),
      initialRoute: '/', // '/'
      onGenerateRoute: generateRoute,
    );
  }
}
