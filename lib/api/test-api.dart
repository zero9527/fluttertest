import 'package:flutter/cupertino.dart';
import './index.dart';

getFile([params]) {
  return new HttpUtil().get('/api/file/getFile', params);
}

uploadFile([params]) {
  return new HttpUtil().post('/api/file/uploadFile', params);
}

/// platform: 0: 'android', 1: 'ios'
getNewestVersion({@required num platform, @required String version}) {
  return new HttpUtil().get('/api/app/getCurrentVersion1', {
    'platform': platform,
    'version': version
  });
}
