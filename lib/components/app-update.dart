import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:fluttertest/api/test-api.dart';

class AppInfo extends StatelessWidget {
  AppInfo() : super();

  void checkVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var res = await getNewestVersion(platform: 0, version: packageInfo.version);
    print('$res');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: checkVersion,
        child: Text('checkVersion'),
      ),
    );
  }
}
